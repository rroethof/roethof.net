---
title: Converting KVM Guests from LVM to QCOW2, Base Images and Snapshots
slug: converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots
date: 2011-11-18
lastmod: 2011-11-18
draft: false
author: Ronny Roethof
categories:
- devops-infrastructure
tags:
- kvm
- qemu
- virtualization
- linux
- lvm
cover: posts/2011/11/converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots/cover.png
summary: How to convert KVM guests from LVM to QCOW2 format, use base images, and
  manage snapshots for better flexibility and performance.
description: Step-by-step guide for converting LVM-based KVM guests to QCOW2, editing
  VM XML, using base images, and creating snapshots for faster deployments.
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