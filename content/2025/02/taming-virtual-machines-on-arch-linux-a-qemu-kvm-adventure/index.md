---
date: '2025-02-25T08:13:02+01:00'
draft: false
title: 'Taming Virtual Machines on Arch Linux: A QEMU-KVM Adventure'
tags: 
  - 'arch linux'
  - 'virtualization'
  - 'kvm'
  - 'quemu'
  - 'arch'
  - 'linux'
categories:
  - 'tutorials'
  - 'arch linux'
  - 'security'
---

So, you're ready to dive into the world of virtualization on Arch Linux? Awesome!  This guide will walk you through setting up QEMU-KVM, turning your machine into a virtual playground.  We'll keep things simple and focus on the essentials.

## Checking if Your Rig is Up for the Task

First, let's make sure your CPU has the necessary virtualization features.  Run this command:

    lscpu | grep -i Virtualization

Look for _VT-x_ (Intel) or _AMD-Vi_ (AMD) in the output.  If you see either of these, you're good to go!

## Kernel Checkup

Next, we need to ensure the KVM modules are loaded in your kernel.  A quick check:

    zgrep CONFIG_KVM /proc/config.gz

    If the output shows _y_ (yes), you're all set.  If it's _m_ (module), it means the modules are loadable, which is also fine.

## Installing the Virtualization Toolkit

Now, let's grab the tools we need:
    
    sudo pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf dnsmasq swtpm guestfs-tools libosinfo tuned

Here's a breakdown of what each package does:

 * _qemu-full_: The KVM emulator itself.
 * _qemu-img_: For managing disk images (creating, converting, etc.).
 * _libvirt_: The management layer for our VMs.
 * _virt-install_: A command-line tool for creating VMs.
 * _virt-manager_: A graphical tool for managing VMs (because GUIs are nice).
 * _virt-viewer_: For connecting to your running VMs.
 * _edk2-ovmf_: UEFI support for VMs (for modern operating systems).
 * _dnsmasq_: A lightweight DNS and DHCP server.
 * _swtpm_: A TPM emulator (for security features in VMs).
 * _guestfs-tools_: Tools for managing guest disk images.
 * _libosinfo_: A library for OS information (helps with VM creation).
 * _tuned_: For optimizing the host system for virtualization.

 ## Windows Guests? Grab Some Drivers!

If you plan on running Windows VMs, you'll need the VirtIO drivers.  Head over to the (Fedora People repository [https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/]) and download the _virtio-win.iso_ file.  You'll need to attach this ISO to your Windows VM during installation.

## Enabling the Libvirt Daemon

Libvirt needs to be running to manage your VMs.  You have two options: _modular_ or _monolithic_.  The _modular_ approach is generally recommended.

### Option 1 (Modular - Recommended):

    for drv in qemu interface network nodedev nwfilter secret storage; do
        sudo systemctl enable virt${drv}d.service;
        sudo systemctl enable virt${drv}d{,-ro,-admin}.socket;
    done

### Option 2 (Monolithic):

    sudo systemctl enable libvirtd.service

After enabling, reboot your system.

## Verifying Virtualization

Let's make sure everything is working as expected:

    sudo virt-host-validate qemu

Address any warnings you see and re-run the command until everything checks out.

## Nested Virtualization (Optional, But Cool)

If you want to run VMs inside other VMs (nested virtualization), you'll need to enable it.

### For the current session:

 * Intel:

    sudo modprobe -r kvm_intel
    sudo modprobe kvm_intel nested=1

 * AMD:

    sudo modprobe -r kvm_amd
    sudo modprobe kvm_amd nested=1

## Persistently:

 * Intel:

    echo "options kvm_intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf

 * AMD:

    echo "options kvm_amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf

## Optimizing with TuneD

Let's optimize our host for virtualization using TuneD.

 Enable TuneD:

    sudo systemctl enable --now tuned.service

Set the profile:

    sudo tuned-adm profile virtual-host

Verify:

    sudo tuned-adm active
    sudo tuned-adm verify

## KVM Networking

TODO: _By default, VMs use NAT networking. For LAN access, you need a bridge.  (This section is quite involved, so I'll summarize.  You'll need to create a bridge interface using _nmcli_ and then configure a bridge network with _virsh_.  The original guide has the detailed steps.)_

## Libvirt Connection Modes
Libvirt can connect in _session_ (per-user) or _system_ (system-wide) mode.  _system_ mode is generally preferred for more control.  (The guide outlines how to switch to system mode and grant your user access.)

## Setting ACLs for Image Directory

Let's secure our VM image directory:

    sudo setfacl -R -b /var/lib/libvirt/images/
    sudo setfacl -R -m "u:${USER}:rwX" /var/lib/libvirt/images/
    sudo setfacl -m "d:u:${USER}:rwx" /var/lib/libvirt/images/

This gives your user appropriate permissions.

TODO:

The _libvirt_ Group:  Adding a user to the _libvirt_ group is the most crucial step.  This grants the user the necessary permissions to interact with libvirt, which underlies QEMU, virt-manager, and virt-viewer.

    sudo usermod -aG libvirt $USER

You'll need to log out and back in (or reboot) for this group change to take effect.

System Mode for Libvirt (Recommended):  While the previous guide mentioned session vs. system mode, it's worth reiterating.  For broader access and control (especially if you want to manage network bridges or other system-level resources), using the system mode for libvirt is recommended.  You've already likely done this, but here's the reminder:

    echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' >> ~/.zshrc  # Add to zshrc
    source ~/.zshrc # Apply the change to current shell

Verify: After completing these steps, verify the following:

Group Membership, the following command should list libvirt.

    groups $USER
 
Libvirt URI: virsh uri should output qemu:///system.
Image Directory Permissions: getfacl /var/lib/libvirt/images/ should show your user with rwx permissions.
Using virt-manager and virt-viewer: Once the above is set up correctly, the user should be able to launch virt-manager and virt-viewer without any issues.  They will be able to create, manage, and view VMs.

yay -S virtio-win

That's it! You've now got a powerful virtualization setup on your Arch Linux machine.  Go forth and create some VMs!