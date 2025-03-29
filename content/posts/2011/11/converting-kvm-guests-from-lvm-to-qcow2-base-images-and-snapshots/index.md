---
date: '2011-11-18T09:30:29+01:00'
draft: false
title: 'Converting kvm guests from lvm to qcow2, base images and snapshots'
tags: 
  - 'KVM'
  - 'QEMU'
  - 'Virtualization'
  - 'Linux'
  - 'LVM'
  - 'Qcow2'
  - 'Snapshotting'
  - 'Image conversion'
  - 'Guest management'
  - 'System administration'
  - 'Performance optimization'
  - 'Storage management'
categories:
  - Virtualization & Cloud
  - Linux & Open Source
  - Infrastructure & Servers
  - System Management
  - Automation & Scripting
  - Tech & Industry Insights
  - Storage Management
---
lvm based kvm guests are fast but you lose some flexibility, playing with kvm on my desktop I prefer to use file based images. Converting from lvm images to qcow2 isn’t hard but the documentation is sparse.

1. use qemu-img to convert from an lvm to qcow2 format:

```
qemu-img convert -O qcow2 /dev/vg_name/lv_name/ /var/lib/libvirt/images/image_name.qcow2
```
If you want the image compressed add ‘-c’ right after the word convert.

2. edit the xml for the image

```
virsh edit image_name
```
modify the disk stanza, adding a type to the driver line; on the source line change ‘dev’ to ‘file’ and modify the path:

```
driver name='qemu' type='qcow2'
source file='/var/lib/libvirt/images/image_name.qcow2'
```
Creating images from with a base image allows quick rollouts of many boxes based on an single install – for example I have a ‘golden image’ of Ubuntu, I can stop that VM and create 2 servers using the original VM disk as a base file and writing changes to different files.

```
qemu-img create -b original_image.qcow2 -f qcow2 clone_image01.qcow2
qemu-img create -b original_image.qcow2 -f qcow2 clone_image02.qcow2
```
Taking this further I can then snapshot both images so once I start making changes, rolling back to a point in time prior to the changes is very easy:

```
qemu-img snapshot -c snapshot_name vm_image_name.qcow2
```

references:
http://www.linux-kvm.com/content/how-you-can-use-qemukvm-base-images-be-more-productive-part-1