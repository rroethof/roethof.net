---
title: "Portability Is Not an Exit Strategy"
slug: portability-is-not-an-exit-strategy
date: 2026-09-26
lastmod: 2026-09-26
draft: false
author: "Ronny Roethof"
cover: posts/2026/09/portability-is-not-an-exit-strategy/cover.jpg
 
categories:
- digital-sovereignty
- linux-open-source
 
tags:
- vmware
- vddk
- broadcom
- openvddk
- vendor-lock-in
 
summary: "Broadcom's removal of VMware's VDDK shows why portability, not a paper exit plan, is what real infrastructure sovereignty requires."
description: "A look at Broadcom pulling public VDDK downloads and what it reveals about vendor lock-in, migration tooling, and why open source is the real foundation for infrastructure independence."
---
 
*Why the removal of VMware's VDDK is a lesson in designing your exit before you need one*
 
# Portability Is Not an Exit Strategy
 
Broadcom has removed the public downloads of VMware's Virtual Disk Development Kit, VDDK, with little warning and while organisations were actively using the toolkit for migrations away from VMware to other virtualisation platforms.
 
Broadcom's stated reason is that VDDK was intended for backup and recovery, and that restricting distribution serves security, reliability, and product priorities. In practice, though, VDDK was also the backbone of migration tools that helped organisations move VMware workloads elsewhere. That is where things get interesting: the question is not whether Broadcom has the technical right to change how it distributes an SDK, because of course it does. The real question is what this move means for portability.
 
## Owning your data is not the same as being able to take it with you
 
Digital sovereignty discussions usually focus on where data is stored, who can access it, and which laws apply. But there is another, quieter form of dependency: can you actually move your workload the moment you decide you want something else? A virtual machine can technically be yours. You can hold the files, the backups, even a contractual right to export your data. But if practical migration depends on tooling, SDKs, or interfaces controlled by a single vendor, your independence is not nearly as solid as it looks on paper.
 
## You need to design the exit before you need it
 
That is the biggest lesson here. Designing an exit strategy only once you are already trying to leave VMware is too late; that is precisely the moment you discover which parts of your infrastructure quietly depend on VMware-specific interfaces, drivers, storage integrations, backup software, or migration tooling. And this is not a VMware problem specifically. The same logic applies to storage, networking, databases, public cloud, and almost every other critical infrastructure component. If your infrastructure only works properly inside one vendor's stack, you have not just made a technical choice, you have bought yourself a future dependency.
 
## Open source is the holy grail
 
This is where I fundamentally disagree with the idea that open source is simply one option among many. For me, it is the starting point, not because every open-source solution is automatically well designed, but because open source gives you the ability to remain in control. You can inspect the code, build it yourself, patch it, fork it, switch vendors or keep a project alive after its original maintainer walks away. You are never forced to accept that a single commercial company decides what will still be possible with your own infrastructure tomorrow. That is the real value of open source: not free software, but freedom.
 
## Open standards and open source reinforce each other
 
Open source alone is not enough, since you can build open-source software that is still heavily tied to a closed ecosystem. That is why open standards matter just as much. There is a real difference between a vendor merely providing an export function and an organisation genuinely controlling how it exports its own data and workloads. In the first case you depend on the vendor's goodwill; in the second you have actual technical control. That difference becomes very concrete the moment a vendor decides an API, SDK, driver, or tool is no longer publicly available.
 
## Alternatives are good, but that is not the point
 
Alternatives are already emerging for organisations affected by the VDDK removal: OpenVDDK is being developed as an independent implementation, and migration platforms from companies such as RackWare and Nutanix offer other ways of moving workloads. That is good news, but it also proves the underlying point. When a vendor pulls a component from its distribution channel, the community can build a replacement, not because the vendor allows it, but because the software world does not have to stop at one vendor's decision.
 
## This is why I value portability more than an exit plan
 
Infrastructure sovereignty is not a document explaining how you might one day leave vendor X. It means designing your infrastructure so that you actually can leave: taking your data with you, moving your workloads, changing your hardware, choosing a different hypervisor, all without needing permission from the vendor you are trying to walk away from. Vendor independence should not be a project you start when the contract expires. It should be an architectural decision from day one, and for me, that architecture starts with open source.
 