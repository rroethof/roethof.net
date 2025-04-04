---
title: "Let's Build an Ansible Role for Basic Linux Hardening"
date: 2025-04-02
draft: false
slug: ansible-role-linux-hardening
tags: ["Ansible", "Linux", "Security", "Automation", "System Hardening", "Ansible Role", "Tutorial"]
categories: ["Automation & Scripting", "Linux & Open Source", "Security & Privacy", "System Management", "System Hardening", "Sysadmin Life"]
description: "Join me as we build an Ansible role to automate basic Linux security hardening. We'll walk through the key tasks and configurations to secure a fresh system."
---

Alright, let's talk security hardening. It's one of the first, if not *the* first, steps we should take on any new Linux system. But let's be real, doing it all manually gets old fast, especially when we're managing more than a couple of servers. That's where Ansible comes in!

In this post, let's work together to create an Ansible role that automates a lot of the basic hardening. We want to make sure those essential security practices get applied consistently and without us having to remember every single step.

This role we'll build will work for both Debian/Ubuntu and Red Hat/Fedora, which is a lifesaver. It's not about being fancy, it's about getting the basics *right*.

## 1. Role Structure: Organizing Our Hardening Logic

Ansible roles provide a structured way to organize and reuse automation code. Understanding the standard role directory structure is crucial for building and maintaining our hardening role.

A typical Ansible role has the following directory layout:

```
roles/
└── linux-hardening/  # Our role's directory
├── tasks/
│   └── main.yml  # Main task file
├── vars/
│   └── main.yml  # Role variables
├── handlers/
│   └── main.yml  # Role handlers
├── templates/    # Config templates
│   ├── system.conf.j2
│   ├── sshd_config.j2
│   └── ...
└── meta/
└── main.yml  # Role metadata (optional)
```

* `roles/`: This is the top-level directory where all your roles are stored.
* `linux-hardening/`: This is the directory for our specific hardening role. You can name it according to your preferences.
* `tasks/main.yml`: This is the main task file, containing the sequence of actions that Ansible will execute when the role is applied.
* `vars/main.yml`: This file defines variables that can be used within the role, making it configurable.
* `handlers/main.yml`: This file contains handlers, which are special tasks that are only executed when notified by other tasks.
* `templates/`: This directory stores Jinja2 templates for configuration files, allowing for dynamic configuration.
* `meta/main.yml`: This file contains metadata about the role, such as its author, dependencies, and supported platforms.

## 2. Variables: Making Our Role Configurable (`vars/main.yml`)

Ansible variables allow us to customize the behavior of our role without directly modifying the task files. This makes the role more flexible and reusable.

Here are some example variables we'll use in our hardening role:

```yaml
# roles/linux-hardening/vars/main.yml
disable_ipv6: true
allow_vsyscall: false
firewall_enabled: true
sshd_permit_root_login: "no"
sshd_password_authentication: "no"
```

* `disable_ipv6`: A boolean variable to control whether IPv6 is disabled.
* `allow_vsyscall`: A boolean variable to control whether vsyscall is allowed (for compatibility reasons, but generally not recommended).
* `firewall_enabled`: A boolean variable to enable or disable the firewall.
* `sshd_permit_root_login`: A string variable to configure whether root login is allowed via SSH.
* `sshd_password_authentication`: A string variable to configure whether password authentication is allowed for SSH.

## 3. Tasks: Automating the Hardening Steps (`tasks/main.yml`)
The `tasks/main.yml` file contains the core logic of our role. We'll break down the tasks into logical sections for better organization.

### 3.1 System Tuning
This section focuses on optimizing kernel parameters and systemd settings.

### Kernel Tweaks
We'll use `sysctl` to adjust kernel parameters and GRUB to modify kernel boot options.

```
# roles/linux-hardening/tasks/main.yml
- name: Kernel Tweaks
  become: true
  block:
    - name: Set sysctl parameters
      ansible.builtin.sysctl:
        name: "{{ item.key }}"
        value: "{{ item.value }}"
        state: present
      loop:
        - { key: net.ipv4.tcp_syncookies, value: '1' }
        - { key: net.ipv4.conf.all.accept_redirects, value: '0' }
        # ... other sysctl settings ...
```

* `ansible.builtin.sysctl`: This module is used to manage sysctl parameters.
* `loop`: This directive allows us to apply the same task to multiple items.
* `become`: true: This indicates that the task requires elevated privileges (root).

```
- name: Disable vsyscall (Debian/Ubuntu)
  ansible.builtin.lineinfile:
    path: /etc/default/grub
    regexp: '^GRUB_CMDLINE_LINUX='
    line: 'GRUB_CMDLINE_LINUX="vsyscall=none"'
  when: ansible_os_family == "Debian"
  notify: Update GRUB

- name: Disable vsyscall (Red Hat/Fedora)
  ansible.builtin.command:
    cmd: grubby --update-kernel=ALL --args="vsyscall=none"
  when: ansible_os_family == "RedHat"
  notify: Update GRUB
```
* `ansible.builtin.lineinfile`: This module ensures a line is present in a file.
* `ansible_os_family`: This is a built-in Ansible fact that tells us the OS family (Debian or RedHat).
* `ansible.builtin.command`: This module executes a shell command.
* `notify: Update GRUB`: This triggers the `Update GRUB` handler (defined later) if the task changes the system.

```
- name: Disable IPv6
  ansible.builtin.sysctl:
    name: net.ipv6.conf.all.disable_ipv6
    value: '1'
    state: present
  when: disable_ipv6
  # ... (rest of kernel tweaks) ...
```

* `when: disable_ipv6`: This task only runs if the `disable_ipv6` variable is set to `true`.

### Systemd Setup
We'll configure systemd settings for improved security and logging.

```
- name: Systemd Configuration
  become: true
  block:
    - name: Configure system.conf
      ansible.builtin.template:
        src: system.conf.j2
        dest: /etc/systemd/system.conf
        owner: root
        group: root
        mode: 0644
      notify: Restart systemd

    - name: Configure user.conf
      ansible.builtin.template:
        src: user.conf.j2
        dest: /etc/systemd/user.conf
        owner: root
        group: root
        mode: 0644

    - name: Configure journald.conf
      ansible.builtin.template:
        src: journald.conf.j2
        dest: /etc/systemd/journald.conf
        owner: root
        group: root
        mode: 0644
      notify: Restart systemd-journald
```

* `ansible.builtin.template`: This module deploys files from Jinja2 templates, allowing for variable substitution.
* `owner`, `group`, `mode`: These parameters set the file ownership and permissions.

### 3.2 Package Management
This section covers installing and configuring security-related packages.

#### USBGuard
We'll install and configure USBGuard to control USB device access.

```
- name: USBGuard
  become: true
  block:
    - name: Install USBGuard
      ansible.builtin.package:
        name: usbguard
        state: present

    - name: Configure USBGuard (example rule)
      ansible.builtin.lineinfile:
        path: /etc/usbguard/rules.conf
        line: 'allow id * serial "*" name "Trusted USB Drive" hash "*" parent-id "" via-port "" with-interface { 03:00:00 }'
        create: true
```

* `ansible.builtin.package`: This module manages packages.
* `create: true`: This parameter creates the file if it doesn't exist.
* *Important*: The USBGuard rule provided is an example. You'll need to research and create rules specific to your environment.

#### Package Installations
We'll install essential security tools like fail2ban and a firewall.

```
- name: Install Essential Packages
  become: true
  block:
    - name: Debian/Ubuntu packages
      ansible.builtin.apt:
        name:
          - fail2ban
          - ufw # (Uncomplicated Firewall)
        state: present
        update_cache: true
      when: ansible_os_family == "Debian"

    - name: Red Hat/Fedora packages
      ansible.builtin.dnf:
        name:
          - fail2ban
          - firewalld
        state: present
        update_cache: true
      when: ansible_os_family == "RedHat"
```

* `ansible.builtin.apt`: This module manages packages on Debian/Ubuntu systems.
* `ansible.builtin.dnf`: This module manages packages on Red Hat/Fedora systems.
* `update_cache: true`: This updates the package cache before installing.

### Auto-Updates
We'll configure automatic security updates.

```
- name: Auto-Updates
  become: true
  block:
    - name: Debian/Ubuntu unattended-upgrades
      ansible.builtin.apt:
        name: unattended-upgrades
        state: present
      when: ansible_os_family == "Debian"

    - name: Configure unattended-upgrades
      ansible.builtin.template:
        src: unattended-upgrades.j2
        dest: /etc/apt/apt.conf.d/50unattended-upgrades
        owner: root
        group: root
        mode: 0644
      when: ansible_os_family == "Debian"

    - name: Enable dnf-automatic (Red Hat/Fedora)
      ansible.builtin.dnf:
        name: dnf-automatic
        state: present
      when: ansible_os_family == "RedHat"

    - name: Configure dnf-automatic
      ansible.builtin.template:
        src: dnf-automatic.j2
        dest: /etc/etc/dnf/automatic.conf
        owner: root
        group: root
        mode: 0644
      when: ansible_os_family == "RedHat"
```