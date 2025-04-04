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

## 3.3 Security Essentials
This section covers core security configurations.

### Host Access Control
We'll configure `hosts.allow` and `hosts.deny`.

```
- name: Host Access Control
  become: true
  block:
    - name: Configure hosts.allow
      ansible.builtin.template:
        src: hosts.allow.j2
        dest: /etc/hosts.allow
        owner: root
        group: root
        mode: 0644

    - name: Configure hosts.deny
      ansible.builtin.template:
        src: hosts.deny.j2
        dest: /etc/hosts.deny
        owner: root
        group: root
        mode: 0644
```

### Login Limits
We'll configure `login.defs` and `limits.conf`.
```
- name: Login Limits
  become: true
  block:
    - name: Configure login.defs
      ansible.builtin.template:
        src: login.defs.j2
        dest: /etc/login.defs
        owner: root
        group: root
        mode: 0644

    - name: Configure limits.conf
      ansible.builtin.template:
        src: limits.conf.j2
        dest: /etc/security/limits.conf
        owner: root
        group: root
        mode: 0644
```

Core Dumps
We'll configure core dump handling and disable `kdump`.

```
- name: Core Dumps
  become: true
  block:
    - name: Configure coredump.conf
      ansible.builtin.template:
        src: coredump.conf.j2
        dest: /etc/systemd/coredump.conf
        owner: root
        group: root
        mode: 0644

    - name: Disable kdump
      ansible.builtin.service:
        name: kdump
        state: absent # Or 'stopped' and 'disabled'
        enabled: false
```

* `ansible.builtin.service`: This module manages systemd services.

### PAM Configuration
We'll configure PAM files for strong authentication.

```
- name: PAM Configuration
  become: true
  block:
    - name: Configure PAM common-auth
      ansible.builtin.template:
        src: common-auth.j2
        dest: /etc/pam.d/common-auth
        owner: root
        group: root
        mode: 0644

    - name: Configure PAM common-password
      ansible.builtin.template:
        src: common-password.j2
        dest: /etc/pam.d/common-password
        owner: root
        group: root
        mode: 0644

    # ... other PAM configurations ...
```

### SSH Hardening
We'll configure the SSH server for security.

```
- name: SSH Hardening
  become: true
  block:
    - name: Configure sshd_config
      ansible.builtin.template:
        src: sshd_config.j2
        dest: /etc/ssh/sshd_config
        owner: root
        group: root
        mode: 0644
      notify: Restart sshd

    # ... other SSH hardening tasks (keys, firewall rules, etc.) ...
```

### Filesystem Mounts
We'll configure filesystem mount options for security.

```
- name: Filesystem Mounts
  become: true
  block:
    - name: Mount /tmp with noexec
      ansible.posix.mount:
        path: /tmp
        opts: rw,noexec,nosuid,nodev
        state: mounted
        fstype: tmpfs

    - name: Mount /var with nodev,nosuid
      ansible.posix.mount:
        path: /var
        opts: rw,nodev,nosuid
        state: mounted
        fstype: ext4 # Or whatever your /var filesystem is
```

* `ansible.posix.mount`: This module manages mount points.

## 3.4 Logging and Time
This section configures logging and time synchronization.

### Log Rotation
We'll configure logrotate.

```
- name: Log Rotation
  become: true
  block:
    - name: Configure logrotate
      ansible.builtin.template:
        src: logrotate.conf.j2
        dest: /etc/logrotate.conf
        owner: root
        group: root
        mode: 0644

    # ... other logrotate configurations ...
```

### System Logging
We'll configure `rsyslog`.

```
- name: System Logging
  become: true
  block:
    - name: Configure rsyslog
      ansible.builtin.template:
        src: rsyslog.conf.j2
        dest: /etc/rsyslog.conf
        owner: root
        group: root
        mode: 0644

    # ... other rsyslog configurations ...
```

### Time Synchronization
We'll configure `systemd-timesyncd`.

```
- name: Time Synchronization
  become: true
  block:
    - name: Ensure systemd-timesyncd is installed
      ansible.builtin.package:
        name: systemd-timesyncd
        state: present

    - name: Enable and start systemd-timesyncd
      ansible.builtin.service:
        name: systemd-timesyncd
        enabled: true
        state: started

    - name: Configure systemd-timesyncd
      ansible.builtin.template:
        src: timesyncd.conf.j2
        dest: /etc/systemd/timesyncd.conf
        owner: root
        group: root
        mode: 0644

    # ... other timesyncd configurations ...
```

## 4. Handlers: Reacting to Changes (`handlers/main.yml`)

Handlers are special tasks that are only executed when notified by other tasks. They are used to perform actions that should only occur after a change has been made, such as restarting a service.

Here are the handlers we'll use in our role:

```yaml
# roles/linux-hardening/handlers/main.yml
- name: Restart systemd
  ansible.builtin.systemd:
    name: systemd
    state: restarted

- name: Restart systemd-journald
  ansible.builtin.systemd:
    name: systemd-journald
    state: restarted

- name: Update GRUB
  ansible.builtin.command:
    cmd: update-grub
  when: ansible_os_family == "Debian"

- name: Restart sshd
  ansible.builtin.service:
    name: sshd
    state: restarted
```

* `ansible.builtin.systemd`: This module manages systemd services.
* `ansible.builtin.command`: This module executes a shell command.
* The `Update GRUB` handler is specific to Debian/Ubuntu, as Red Hat/Fedora uses `grubby`.

## 5. Templates: Configuring Files Dynamically (`templates/`)
Jinja2 templates allow us to create configuration files dynamically, using variables defined in our role. This makes the configuration flexible and adaptable.

Here are examples of some of the template files we'll use:
`sshd_config.j2`

```
# roles/linux-hardening/templates/sshd_config.j2
Port 22
Protocol 2
PermitRootLogin {{ sshd_permit_root_login }}
PasswordAuthentication {{ sshd_password_authentication }}
# ... other SSH settings ...
```

* `{{ sshd_permit_root_login }}` and `{{ sshd_password_authentication }}` are variables that will be replaced with the values defined in `vars/main.yml`.

`login.defs.j2`

```
# roles/linux-hardening/templates/login.defs.j2
PASS_MAX_DAYS   90
PASS_WARN_AGE   7
# ... other login.defs settings ...
```

`limits.conf.j2`
```
# roles/linux-hardening/templates/limits.conf.j2
* soft    nofile          65536
* hard    nofile          65536
# ... other limits.conf settings ...
```

`sysctl.conf.j2 (or individual files)`
```
# roles/linux-hardening/templates/sysctl.conf.j2
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
# ... other sysctl settings ...
```

## Other Templates
We'll also need templates for:

* `rsyslog.conf`
* `logrotate.conf`
* `unattended-upgrades` (Debian)
* `dnf-automatic` (Red Hat)
* `coredump.conf`
* PAM configuration files (`common-auth`, `common-password`, etc.)

*Note*: The content of these templates will vary depending on your specific hardening requirements.

## 6. Using the Role: A Playbook Example
To use our `linux-hardening` role, we need to include it in an Ansible playbook.

Here's an example playbook:
```
- hosts: all
  become: true
  roles:
    - role: linux-hardening
      disable_ipv6: true
      firewall_enabled: true
      sshd_permit_root_login: "no"
```

* `hosts: all`: This indicates that the playbook will run on all hosts in the inventory.
* `become: true`: This enables privilege escalation (sudo).
* `roles:`: This section includes the linux-hardening role.
* We can also set role variables directly in the playbook, as shown in the example.

## 7. Further Improvements: Expanding the Role
Our basic hardening role provides a solid foundation, but there are many ways to expand and improve it:

* *Firewall Management*: Integrate with a dedicated firewall role for more advanced firewall configuration.
* *Compliance Checks*: Implement tasks to check for compliance with security benchmarks like CIS (Center for Internet Security) benchmarks.
* *Automated Patching*: Add tasks to automate the patching process.
* *More Granular Control*: Provide more variables for fine-grained control over various settings.

## 8. Conclusion
Ansible is a powerful tool for automating Linux security hardening. By building this role, we've created a reusable and consistent way to apply essential security measures. Remember to adapt and expand this role to meet your specific security requirements.

Automating these tasks not only saves time but also reduces the risk of human error, leading to more secure and reliable systems.