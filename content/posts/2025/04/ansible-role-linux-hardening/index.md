---
title: "Let's Build an Ansible Role for Basic Linux Hardening"
date: 2025-04-02
draft: false
slug: ansible-role-linux-hardening
tags: ["Ansible", "Linux", "Security", "Automation", "System Hardening", "Ansible Role", "Tutorial"]
categories: ["Automation & Scripting", "Linux & Open Source", "Security & Privacy", "System Management", "System Hardening", "Sysadmin Life"]
description: "Join me as we build an Ansible role to automate basic Linux security hardening. We'll walk through the key tasks and configurations to secure a fresh system."
---

Alright, let's talk security hardening. It's one of the first, if not *the* first, steps we should take on any new Linux system. Doing it all manually gets old fast, especially when we're managing more than a couple of servers. That's where Ansible comes in!

In this post, let's work together to create an Ansible role that automates a lot of the basic hardening, ensuring those essential security practices get applied consistently. This role will work for both Debian/Ubuntu and Red Hat/Fedora. It's about getting the basics *right*.

## Building a Linux Hardening Role with Ansible

Ansible roles provide a structured way to organize and reuse automation code. A typical role has the following directory layout:

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


*   `roles/`: Top-level directory for roles.
*   `linux-hardening/`: Directory for our hardening role.
*   `tasks/main.yml`: Main task file with the sequence of actions.
*   `vars/main.yml`: Defines variables for role configuration.
*   `handlers/main.yml`: Contains handlers, special tasks executed when notified.
*   `templates/`: Stores Jinja2 templates for dynamic configuration files.
*   `meta/main.yml`: Metadata about the role (author, dependencies, platforms).

To make our role configurable, we'll use Ansible variables. This allows us to customize the role's behavior without modifying task files. Example variables in `vars/main.yml`:

```yaml
# roles/linux-hardening/vars/main.yml
disable_ipv6: true
allow_vsyscall: false
firewall_enabled: true
sshd_permit_root_login: "no"
sshd_password_authentication: "no"
```

*   `disable_ipv6`: Boolean to control IPv6 disabling.
*   `allow_vsyscall`: Boolean to control vsyscall allowance.
*   `firewall_enabled`: Boolean to enable/disable the firewall.
*   `sshd_permit_root_login`: String to configure root login via SSH.
*   `sshd_password_authentication`: String to configure SSH password authentication.

The core logic of our role resides in the `tasks/main.yml` file. Let's break down the key tasks.

### System Tuning

We'll start by optimizing kernel parameters and systemd settings. This involves using `sysctl` to adjust kernel parameters and GRUB to modify kernel boot options.

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

*   `ansible.builtin.sysctl`: Manages sysctl parameters.
*   `loop`: Applies the same task to multiple items.
*   `become: true`: Requires elevated privileges (root).

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

*   `ansible.builtin.lineinfile`: Ensures a line is present in a file.
*   `ansible_os_family`: Built-in Ansible fact for OS family.
*   `ansible.builtin.command`: Executes a shell command.
*   `notify: Update GRUB`: Triggers the `Update GRUB` handler if the task changes the system.

```
- name: Disable IPv6
  ansible.builtin.sysctl:
    name: net.ipv6.conf.all.disable_ipv6
    value: '1'
    state: present
  when: disable_ipv6
  # ... (rest of kernel tweaks) ...
```

*   `when: disable_ipv6`: Runs only if `disable_ipv6` is `true`.

Next, we'll configure systemd settings for improved security and logging.

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

*   `ansible.builtin.template`: Deploys files from Jinja2 templates.
*   `owner`, `group`, `mode`: Sets file ownership and permissions.

### Package Management

Now, let's move on to installing and configuring security-related packages. We'll start by installing and configuring USBGuard to control USB device access.

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

*   `ansible.builtin.package`: Manages packages.
*   `create: true`: Creates the file if it doesn't exist.
*   *Important*: The USBGuard rule is an example; research and create rules specific to your environment.

We'll also install essential security tools like fail2ban and a firewall.

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

*   `ansible.builtin.apt`: Manages packages on Debian/Ubuntu.
*   `ansible.builtin.dnf`: Manages packages on Red Hat/Fedora.
*   `update_cache: true`: Updates the package cache before installing.

To keep our system secure, we'll configure automatic security updates.

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

### Security Essentials

Let's configure some core security settings, starting with `hosts.allow` and `hosts.deny`.

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

Next, we'll configure `login.defs` and `limits.conf`.

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

To manage core dumps, we'll configure core dump handling and disable `kdump`.

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

*   `ansible.builtin.service`: Manages systemd services.

For strong authentication, we'll configure PAM files.

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

SSH is a critical entry point, so we'll configure the SSH server for security.

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

Finally, we'll configure filesystem mount options for security.

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

*   `ansible.posix.mount`: Manages mount points.

### Logging and Time

To ensure proper logging and time synchronization, we'll configure logrotate, `rsyslog`, and `systemd-timesyncd`.

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

### Ensuring System Integrity and Security

To detect tampering and maintain system integrity, we'll use AIDE (Advanced Intrusion Detection Environment). AIDE creates a database of file attributes and compares the current state to detect changes.

```yaml
- name: Integrity Checking (AIDE)
  become: true
  block:
    - name: Install AIDE
      ansible.builtin.package:
        name: aide
        state: present

    - name: Configure AIDE
      ansible.builtin.template:
        src: aide.conf.j2
        dest: /etc/aide/aide.conf
        owner: root
        group: root
        mode: 0644

    - name: Initialize AIDE database
      ansible.builtin.command:
        cmd: aide --init
      creates: /var/lib/aide/aide.db.new

    - name: Copy AIDE database
      ansible.builtin.command:
        cmd: cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
      when: not aide_init_skip

    - name: Schedule AIDE check (systemd timer)
      ansible.builtin.template:
        src: aide.timer.j2
        dest: /etc/systemd/system/aide.timer
        owner: root
        group: root
        mode: 0644
      notify: Reload systemd

    - name: Enable and start AIDE timer
      ansible.builtin.service:
        name: aide.timer
        enabled: true
        state: started
```

*   `ansible.builtin.package`: Installs the AIDE package.
*   `ansible.builtin.template`: Configures AIDE using a Jinja2 template (`aide.conf.j2`).
*   `ansible.builtin.command`: Initializes and updates the AIDE database.
*   `creates: /var/lib/aide/aide.db.new`: Ensures `aide --init` runs only if the database file doesn't exist.
*   `when: not aide_init_skip`: Skips the database copy if needed.
*   `ansible.builtin.service`: Enables and starts the systemd timer.

*Example* `aide.conf.j2`:

```
# roles/linux-hardening/templates/aide.conf.j2
@@define DBDIR /var/lib/aide
database=file:@@{DBDIR}/aide.db.new
database_out=file:@@{DBDIR}/aide.db

# These are the default rules, you might want to adjust them
/etc p+i+n+u+g+s+m+c+sha256
/usr/bin p+i+n+u+g+s+m+c+sha256
/usr/sbin p+i+n+u+g+s+m+c+sha256
/bin p+i+n+u+g+s+m+c+sha256
/sbin p+i+n+u+g+s+m+c+sha256
# ... other directories and rules ...
```

To monitor system activity and detect security breaches, we'll use `auditd`, the user-space auditing daemon.

```yaml
- name: System Auditing (auditd)
  become: true
  block:
    - name: Install auditd
      ansible.builtin.package:
        name: auditd
        state: present

    - name: Configure auditd rules
      ansible.builtin.template:
        src: audit.rules.j2
        dest: /etc/audit/audit.rules
        owner: root
        group: root
        mode: 0644
      notify: Restart auditd

    - name: Ensure auditd service is running
      ansible.builtin.service:
        name: auditd
        enabled: true
        state: started
```

*   `ansible.builtin.package`: Installs the auditd package.
*   `ansible.builtin.template`: Configures auditd rules using a Jinja2 template (`audit.rules.j2`).
*   `ansible.builtin.service`: Ensures the auditd service is enabled and running.

*Example* `audit.rules.j2`:

```
# roles/linux-hardening/templates/audit.rules.j2
# Log all modifications to /etc
-w /etc -p wa -k config-changes

# Log all executions of /usr/bin/passwd
-a always,exit -F path=/usr/bin/passwd -F perm=x -F auid>=1000 -F auid!=4294967295 -k passwd-changes

# Log all login/logout events
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session

# ... other audit rules ...
```

To enforce strong cryptography, ensure compatibility, and meet compliance requirements, we'll configure cryptographic policies.

```yaml
- name: Cryptographic Policies
  become: true
  block:
    - name: Set cryptographic policy (Red Hat/Fedora)
      ansible.builtin.command:
        cmd: update-crypto-policies --set DEFAULT # Or 'FUTURE', 'FIPS', etc.
      when: ansible_os_family == "RedHat"
      notify: Reboot

    # Add similar tasks for other distributions if applicable
    # (Debian/Ubuntu might involve configuring specific packages)
```

To reduce the attack surface, we'll blacklist unnecessary kernel modules.

```yaml
- name: Blacklist kernel file system modules
  become: true
  ansible.builtin.lineinfile:
    path: /etc/modprobe.d/disablefs.conf
    line: "blacklist {{ item }}"
    create: true
    mode: "0644"
    owner: root
    group: root
  loop: "{{ fs_modules_blocklist }}"
  when: fs_modules_blocklist is defined
```

To enhance system security, we'll configure security-focused mount options for `/tmp` and `/run/shm`.

```yaml
- name: Mount security-focused tmp
  ansible.posix.mount:
    path: /tmp
    src: tmpfs
    fstype: tmpfs
    opts: rw,nosuid,nodev,noexec
  when: mount_tmp
  tags:
    - configuration
    - mount
    - tmp
```

```yaml
- name: Mount security-focused /run/shm
  ansible.posix.mount:
    path: /run/shm
    src: tmpfs
    fstype: tmpfs
    opts: rw,nosuid,nodev,noexec
  when: mount_run_shm
  tags:
    - configuration
    - mount
    - run
    - shm
```

To maintain accurate time, which is crucial for system security, we'll configure `systemd-timesyncd`.

```
- name: Install and configure systemd timesyncd
  become: true
  block:
    - name: Install systemd timesyncd
      ansible.builtin.package:
        name: systemd-timesyncd
        state: present

    - name: Configure systemd timesyncd
      ansible.builtin.template:
        src: "etc/systemd/timesyncd.conf.j2"
        dest: /etc/systemd/timesyncd.conf
        backup: true
        mode: "0644"
        owner: root
        group: root
      notify:
        - Reload systemd

    - name: Start timesyncd
      ansible.builtin.systemd:
        name: systemd-timesyncd
        enabled: true
        masked: false
        state: started
      register: timesyncd_start
      changed_when:
        - not timesyncd_start.enabled == true
        - not timesyncd_start.state == 'started'

    - name: Stat timesyncd status
      ansible.builtin.command:
        cmd: systemctl status systemd-timesyncd
      register: timesyncd_status
      changed_when: false
      failed_when: timesyncd_status.rc != 0

    - name: Stat timedatectl show
      ansible.builtin.command:
        cmd: timedatectl show
      register: timedatectl_show
      changed_when: false
      failed_when: timedatectl_show.rc != 0

    - name: Run timedatectl set-ntp
      ansible.builtin.command:
        cmd: timedatectl set-ntp true
      changed_when: false
      when:
        - timedatectl_show.stdout.find('NTP=yes') != -1
        - timesyncd_status.rc == 0
```

To detect rootkits, backdoors, and local exploits, we'll use `rkhunter`.

```yaml
    - name: Install rkhunter
      ansible.builtin.package:
        name: rkhunter
        state: present

    - name: Initialize rkhunter database
      ansible.builtin.command:
        cmd: rkhunter --propupd
      become: true

    - name: Schedule rkhunter check (systemd timer or cron)
      # Example using cron:
      ansible.builtin.cron:
        name: "Run rkhunter check"
        job: "rkhunter --check | mail -s 'rkhunter check results' root"
        schedule: "daily"
      become: true
```

To prevent unauthorized access, we'll harden SSH access by properly configuring `sshd`.

```yaml
    - name: Set sshd_listen_address fact
      ansible.builtin.set_fact:
        sshd_listen_address: "{{ sshd_listen_address_list | join(',') }}"
      when: sshd_listen_address_list is defined

    - name: Set sshd_allowed_users fact
      ansible.builtin.set_fact:
        sshd_allowed_users: "{{ sshd_allowed_users_list | join(',') }}"
      when: sshd_allowed_users_list is defined

    - name: Set sshd_allowed_groups fact
      ansible.builtin.set_fact:
        sshd_allowed_groups: "{{ sshd_allowed_groups_list | join(',') }}"
      when: sshd_allowed_groups_list is defined

    - name: Set sshd_denied_users fact
      ansible.builtin.set_fact:
        sshd_denied_users: "{{ sshd_denied_users_list | join(',') }}"
      when: sshd_denied_users_list is defined

    - name: Set sshd_denied_groups fact
      ansible.builtin.set_fact:
        sshd_denied_groups: "{{ sshd_denied_groups_list | join(',') }}"
      when: sshd_denied_groups_list is defined
```

```
- name: Install openssh-server
  ansible.builtin.package:
    name: openssh-server
    state: present
  tags:
    - configuration
    - sshd
    - openssh-server
```

```
 - name: Configure /etc/ssh/sshd_config
  ansible.builtin.template:
    src: "etc/ssh/sshd_config.j2"
    dest: /etc/ssh/sshd_config
    backup: true
    mode: "0600"
    owner: root
    group: root
  notify:
    - restart sshd
  tags:
    - configuration
    - sshd
    - sshd_config
```

```
- name: Set correct permissions for authorized_keys
  ansible.builtin.file:
    path: "{{ item }}"
    mode: "0600"
    owner: root
    group: root
  with_items:
    - /root/.ssh/authorized_keys
  when: configure_sshd_keys
  tags:
    - configuration
    - sshd
    - sshd_keys

- name: Copy ssh keys
  ansible.builtin.copy:
    src: "{{ item.src }}"
    dest: "{{ item.dest }}"
    mode: "0600"
    owner: root
    group: root
  with_items: "{{ ssh_keys }}"
  when: configure_sshd_keys and ssh_keys is defined
  tags:
    - configuration
    - sshd
    - sshd_keys
```

Finally, to mitigate risks associated with compromised build tools, we'll consider compiler security.

To handle changes, we'll use handlers, which are special tasks that are only executed when notified by other tasks.

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

To configure files dynamically, we'll use Jinja2 templates.

To use our `linux-hardening` role, we need to include it in an Ansible playbook.

```
- hosts: all
  become: true
  roles:
    - role: linux-hardening
      disable_ipv6: true
      firewall_enabled: true
      sshd_permit_root_login: "no"
```

Our basic hardening role provides a solid foundation, but there are many ways to expand and improve it.

## Conclusion

Ansible is a powerful tool for automating Linux security hardening. By building this role, we've created a reusable and consistent way to apply essential security measures. Remember to adapt and expand this role to meet your specific security requirements.

Automating these tasks not only saves time but also reduces the risk of human error, leading to more secure and reliable systems.

```
sed -i 's/\[CODE_BLOCK_START\]/```/g' index.md
sed -i 's/\[CODE_BLOCK_END\]/```/g' index.md
sed -i 's/\[CODE_BLOCK_YAML_START\]/```yaml/g' index.md
```