---
date: '2011-11-18T09:30:29+01:00'
draft: false
title: 'Unattended Security Updates in Ubuntu'
tags:
  - 'Ubuntu'
  - 'Linux'
  - 'Security Updates'
  - 'Unattended Upgrades'
  - 'System Maintenance'
  - 'Automation'
  - 'Scripting'
  - 'Shell Scripting'
  - 'Debian'
  - 'Package Management'
categories:
  - Linux & Open Source
  - Security & Privacy
  - Automation & Scripting
  - System Management
---

In order to have automatic and unattended security updates in Ubuntu, one needs to install the according package:

```
sudo aptitude install unattended-upgrades
```
The file */etc/apt/apt.conf.d/10periodic* needs to be created with the following content:

```
APT::Periodic::Enable "1";
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "5";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::RandomSleep "1800";
```

Also, change the first few lines of */etc/apt/apt.conf.d/50unattended-upgrades* as follows so that only security updates are considered:

```
Unattended-Upgrade::Allowed-Origins {
        "Ubuntu lucid-security";
        "Ubuntu lucid-updates";
};

Unattended-Upgrade::Package-Blacklist {
};

Unattended-Upgrade::Mail "root@localhost";

Unattended-Upgrade::Remove-Unused-Dependencies "false";
Unattended-Upgrade::Automatic-Reboot "false";
```

It is vital to redo these setting after a global upgrade to a new distro release.

If configured correctly the following command should produce this output:

```
$ apt-config shell UnattendedUpgradeInterval APT::Periodic::Unattended-Upgrade
UnattendedUpgradeInterval='1' 
```