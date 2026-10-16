---
title: Converting KVM Guests from LVM to QCOW2, Base Images and Snapshots
slug: converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots
date: 2011-11-18
lastmod: 2011-11-18
draft: false
author: Ronny Roethof
cover: posts/2011/11/converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots/cover.jpg
categories:
- devops-infrastructure
- linux-open-source
tags:
- kvm
- qemu
- virtualization
- lvm
- qcow2
summary: Guide on converting LVM-based KVM guests to QCOW2, creating base images and
  snapshots for flexible virtualization management.
description: Step-by-step instructions for converting KVM guests from LVM to QCOW2,
  using base images, snapshots, and improving virtualization workflows.
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