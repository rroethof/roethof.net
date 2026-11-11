---
title: "Stop Patching Your Servers? You're Just Moving the Problem."
slug: "stop-patching-servers-moving-the-problem"
date: 2026-11-12
lastmod: 2026-11-12
draft: false
author: "Ronny Roethof"
categories:
  - linux-open-source
  - security-privacy
  - opinion-reflections
tags:
  - patch-management
  - immutable-infrastructure
  - infrastructure-as-code
  - automation
  - linux
summary: "Replacing servers instead of patching them sounds attractive, but immutable infrastructure doesn't eliminate patch management. It moves the responsibility elsewhere."
description: "Why cattle-not-pets, immutable infrastructure and automated rebuilds are valuable strategies, but don't eliminate the need for patching, lifecycle management or operational responsibility."
---

*Immutable infrastructure doesn't eliminate patch management. It changes where and how you perform it.*

Recently, I came across a LinkedIn post by [Chad P.](https://www.linkedin.com/in/cprey/) that opened with a rather provocative statement: "Patching your servers is a waste of time." His argument was that organizations running Linux, bare metal, virtual machines or containers could achieve better stability and security by replacing systems instead of patching them, using the familiar cattle-not-pets approach.

I understand the reasoning, and to a certain extent, I agree with the underlying philosophy. Reproducible infrastructure, automated deployments and disposable compute resources are all excellent concepts. I've spent enough years working with Linux and infrastructure automation to appreciate the advantages of being able to rebuild a machine rather than spending hours troubleshooting configuration drift or recovering from a failed upgrade.

However, claiming that patching servers is a waste of time overlooks something fundamental. Replacing a vulnerable system with a newly deployed system doesn't automatically make the vulnerability disappear. Somewhere in your infrastructure lifecycle, software still needs to be updated, security fixes still need to be incorporated and compatibility still needs to be validated.

**You're not eliminating patch management. You're moving it somewhere else.**

And depending on the environment, that might be exactly the right thing to do. But presenting it as a universal solution for everything from containers to bare-metal infrastructure is where the argument starts falling apart.

## Cattle, Pets and the Reality of Infrastructure

The cattle-not-pets philosophy has been around for years. Instead of treating every server as a unique machine that must be carefully maintained throughout its lifetime, infrastructure is designed around replaceable instances. When something fails or requires an update, you deploy a replacement rather than repairing the existing system.

In a properly designed environment, this approach offers significant advantages. Configuration drift becomes less of a concern, deployments are reproducible and recovery procedures become easier to automate. When combined with Infrastructure as Code, version-controlled configuration and reliable deployment pipelines, rebuilding infrastructure can become a routine operation rather than an exceptional event.

For stateless workloads, this model works particularly well. A web application running across multiple containers or virtual machines can often be updated by deploying new instances, verifying their health and gradually removing the old ones. Kubernetes and other orchestration platforms have made this approach increasingly accessible, particularly when applications have been designed around horizontal scaling and disposable compute resources.

But infrastructure doesn't consist entirely of stateless applications. Beneath those containers are operating systems, hypervisors, storage platforms, network devices and physical servers. Some components can be replaced almost effortlessly, while others contain state, maintain complex dependencies or provide services that cannot simply be moved without careful coordination.

The cattle-not-pets philosophy is an architectural approach, not a magic trick that makes every infrastructure component disposable.

## Someone Still Has to Maintain the Image

One of the more interesting objections in the LinkedIn discussion concerned the images used to deploy replacement systems. If you're replacing servers with newly built instances, those instances need to come from somewhere. Whether you're using a golden image, a container image, an automated operating system installation or a declarative configuration, the software being deployed must still be maintained.

Consider a Linux virtual machine deployed from an image containing an outdated OpenSSL library or a vulnerable version of the kernel. Replacing the existing VM with another instance created from that same image achieves very little from a security perspective. You have successfully automated the deployment of the same vulnerability.

To avoid that, the source image must be updated, rebuilt, tested and approved. The same principle applies to container images, where vulnerable packages and dependencies can remain embedded in application layers long after the original image was created.

A proper immutable infrastructure pipeline therefore needs dependency tracking, vulnerability scanning, updated base images, automated builds, validation and controlled deployment procedures. It also needs a mechanism to identify which running workloads were built from outdated components and replace them when security updates become available.

That sounds remarkably similar to patch management, doesn't it?

The difference is that you're applying updates during the build process rather than directly modifying running production systems. That's a perfectly valid approach, and in many environments, it's preferable. But calling it zero patching is misleading.

The work hasn't disappeared. It has moved into the software supply chain and deployment lifecycle.

## My Approach: Rebuild Everything, but Understand What You're Rebuilding

In my own infrastructure automation work, I prefer reproducible operating system installations over manually maintained server images. With Debian preseed, I can deploy a fresh operating system using a defined installation configuration, including partitioning, networking and initial system settings.

From there, Ansible applies the baseline configuration, security hardening, user management and additional roles required for the server's intended purpose. OpenTofu can handle the provisioning of virtual machines within Proxmox, allowing the infrastructure itself to be defined and deployed through code.

This gives me a repeatable process for creating systems without depending on a manually maintained golden image. It also makes it considerably easier to understand how a server was configured, because the installation and configuration logic can be reviewed, version-controlled and reproduced.

However, I would never claim that this eliminates patch management.

The Debian repositories still need to provide security updates. My Ansible roles need maintenance as software versions and configuration requirements change. The installation process needs to be tested against new Debian releases, and the resulting systems must be validated before they become part of a production environment.

Even when every virtual machine can be rebuilt from scratch, the applications and services running on those machines still have their own lifecycle requirements. Reproducibility solves an important operational problem, but it doesn't remove the responsibility to maintain the software being deployed.

In fact, automation makes that responsibility more important. A mistake in a manually maintained server might affect one system. A mistake in an automated deployment pipeline can reproduce the same vulnerability or configuration error across an entire environment.

**Automation doesn't automatically make infrastructure secure. It makes infrastructure consistent, including its mistakes.**

## The Hypervisor Doesn't Magically Disappear

Another interesting question raised in the discussion concerned the underlying hypervisor and host operating system. It's relatively straightforward to replace Kubernetes worker nodes when they run as virtual machines or cloud instances. You provision new nodes, migrate the workloads and remove the old ones.

But what happens underneath those virtual machines?

Somewhere, a physical server is running a hypervisor. That hypervisor has a kernel, drivers, management services and dependencies that require maintenance. The physical machine has firmware, storage controllers, network interfaces and potentially specialized hardware such as GPUs or locally attached storage.

Those components also receive security updates.

You can certainly automate hypervisor replacement or perform rolling maintenance across a properly designed cluster. In sufficiently redundant environments, workloads can be migrated away from individual hosts while maintenance takes place. Some organizations even automate complete bare-metal provisioning, including firmware updates and operating system deployment.

But none of that means the underlying maintenance has disappeared. You're still updating software, validating hardware compatibility and managing the risk associated with changes to critical infrastructure components.

And not every organization has unlimited spare capacity available to evacuate physical hosts whenever a security update becomes necessary.

In a Proxmox cluster, for example, you might migrate virtual machines to another node before performing maintenance. That works well when sufficient capacity exists and the workloads support migration. But if you're dealing with local storage, hardware passthrough, limited cluster capacity or specific availability requirements, the process becomes considerably more complicated.

The same principle applies to physical network infrastructure, storage appliances and other components that form the foundation of the environment.

At some point, you reach a layer where replacing a component requires more than deploying another container.

## Stateful Systems Are a Different Story

The discussion becomes even more interesting when databases enter the picture. Stateless application servers are relatively easy to replace because their persistent data lives elsewhere. Databases, on the other hand, are responsible for maintaining state, consistency and durability.

Consider a production database cluster processing continuous transactions. Replacing a database node isn't necessarily difficult, but safely reintegrating it into the cluster can require significant coordination. Depending on the database technology, dataset size and replication architecture, synchronization may generate substantial I/O, network traffic and additional load on the remaining nodes.

I've worked with enough database infrastructure to know that high availability doesn't automatically mean maintenance without consequences. A cluster can appear healthy while still containing operational weaknesses that only become visible during failover, synchronization or recovery.

With technologies such as Galera, PostgreSQL replication or other clustered database architectures, you need to understand quorum, replication behaviour, transaction consistency and the consequences of removing individual nodes. A rolling replacement strategy may be entirely appropriate, but it needs to account for the actual behaviour of the database rather than assuming every node is disposable.

And what happens when the replacement node requires hours to synchronize? What if the remaining nodes are already under significant load? What if the cluster loses quorum during the procedure, or the application depends on behaviour that changes between software versions?

These are not theoretical objections to automation. They're operational realities that need to be understood before automation can be trusted.

A traditional patch-and-reboot procedure might sometimes be faster and less disruptive than rebuilding and resynchronizing an entire database node. In other situations, replacing the node might provide a safer and more predictable result. The correct approach depends on the architecture, the workload and the operational requirements.

There is no universal answer.

## Immutable Doesn't Mean Invulnerable

Another misconception worth addressing is the relationship between immutability and security. Immutable infrastructure can significantly reduce configuration drift and make unauthorized changes harder to persist. It also improves recovery by allowing systems to be recreated from known configurations.

But an immutable system can still be vulnerable.

If the deployed image contains an exploitable library, the vulnerability remains present until a corrected image is built and deployed. If an application has insecure configuration defaults, rebuilding it from the same configuration simply reproduces the problem. If credentials are exposed through the deployment pipeline, replacing the server doesn't resolve the underlying security incident.

The same applies to vulnerabilities in container runtimes, hypervisors, firmware and the orchestration platforms themselves. These components exist outside the application image and require their own maintenance processes.

Security also depends on how quickly vulnerable components can be identified and replaced. A sophisticated immutable deployment pipeline that takes several weeks to deliver a critical security update isn't necessarily safer than a conventional patch management process capable of deploying the same fix within hours.

What matters is the outcome: how quickly vulnerabilities are remediated, how reliably changes are validated and how effectively the organization can recover when something goes wrong.

Whether the remediation happens through an in-place update or a complete system replacement is an implementation decision.

## Rebuilding Is Not the Same as Recovering

One of the strongest arguments for immutable infrastructure is that failed deployments can be handled by simply retaining the previous version. If the new instance doesn't pass validation, don't put it into production. Continue using the existing system while investigating the problem.

For stateless workloads, that can be an excellent strategy. Blue-green deployments, rolling replacements and canary releases provide opportunities to validate new versions before exposing all users to them.

However, this approach becomes more complicated when applications modify persistent data or introduce changes that aren't backward compatible. A database schema migration, for example, may prevent an older application version from functioning correctly. Reverting the application image doesn't automatically reverse changes already made to the database.

Similarly, replacing a failed server doesn't guarantee recovery if the problem involves corrupted data, compromised credentials or an underlying storage failure.

Backups, disaster recovery procedures, tested restoration processes and clearly defined recovery objectives remain essential. Immutable infrastructure can improve the recovery process, but it doesn't replace those controls.

The ability to rebuild a server in five minutes is impressive. The ability to restore a business-critical service with consistent data and verified functionality is what actually matters.

## Stop Selling Architecture as a Universal Solution

What bothers me most about statements like "patching your servers is a waste of time" isn't the underlying technology. I strongly support automation, reproducible infrastructure and reducing unnecessary manual maintenance.

The problem is presenting an architectural preference as a universal solution without acknowledging the conditions required to make it work.

A cloud-native application designed around disposable compute resources has very different operational requirements from a legacy database, a physical storage platform or a hypervisor cluster running business-critical workloads. Trying to force every system into the same operational model can introduce complexity rather than eliminate it.

There's also a financial aspect that often gets overlooked. Building reliable immutable infrastructure requires investment in automation, deployment pipelines, testing environments, monitoring and the expertise needed to maintain them. Those investments can absolutely pay off, particularly at scale, but the return depends on the environment.

For an organization managing thousands of similar workloads, automated replacement may offer substantial efficiency improvements. For a smaller environment with a handful of specialized systems, a well-designed automated patching process may be more economical and equally reliable.

The objective should never be to follow an architectural trend simply because it sounds modern. It should be to choose the approach that delivers the best combination of security, reliability, maintainability and operational efficiency.

Sometimes that means replacing a server. Sometimes it means patching it. And sometimes it means redesigning the application because neither approach adequately addresses the underlying problem.

## Patch Management Is a Responsibility, Not a Command

Perhaps the biggest misunderstanding in this entire discussion is treating patch management as if it were synonymous with running a package manager on a production server.

Patch management is much broader than executing `apt upgrade`, `dnf upgrade` or installing the latest operating system updates. It involves understanding vulnerabilities, evaluating their impact, identifying affected systems, testing remediation, deploying changes and verifying that the risks have actually been addressed.

Those responsibilities exist regardless of whether the affected software runs inside a container, virtual machine, physical server or immutable image.

In an immutable environment, remediation might involve updating a base image, rebuilding an application, validating the result and deploying replacement instances. In a traditional environment, it might involve applying security updates directly to existing systems through Ansible or another automation platform.

Both approaches require planning, testing, monitoring and accountability. Both can be automated, and both can fail when poorly implemented.

The important distinction is between **patching as a technical procedure** and **patch management as an operational responsibility**.

You can eliminate the need to patch individual running servers without eliminating the need to manage software vulnerabilities. Confusing those two concepts creates a false sense of security.

## The Real Goal Is Reproducible, Maintainable Infrastructure

I would much rather rebuild a poorly configured Linux server from a known baseline than spend hours trying to understand years of undocumented manual changes. I also prefer infrastructure that can be recreated through automation instead of depending on individual administrators remembering how everything was originally installed.

That's why I invest time in Debian preseed, Ansible, OpenTofu and reproducible infrastructure configurations. These tools make deployments predictable, reduce configuration drift and provide a foundation for controlled changes.

But I also recognize that some systems require careful in-place maintenance, particularly when dealing with persistent data, specialized hardware or applications that cannot easily be replaced. The challenge is knowing which approach is appropriate and designing the operational procedures accordingly.

We should absolutely move away from manually maintained servers that nobody dares to touch because nobody knows what will break. We should automate repetitive tasks, eliminate unnecessary configuration differences and make rebuilding infrastructure a routine capability.

What we shouldn't do is pretend that replacing servers somehow removes the need to maintain the software running on them.

**Patching your servers isn't necessarily a waste of time. Patching them manually, inconsistently and without a reproducible process often is.**

Immutable infrastructure can be a significant improvement, but it doesn't make vulnerabilities disappear. It changes how we deliver fixes, how we manage risk and where the responsibility for maintenance resides.

And if your newly deployed server contains the same vulnerabilities as the one you just destroyed, congratulations.

**You've successfully automated the deployment of outdated software.**

*Ronny Roethof*