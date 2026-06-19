---
title: "The Commodity IT Fallacy: How We Outsourced Technical Sovereignty"
slug: the-commodity-it-fallacy
date: 2026-06-19
lastmod: 2026-06-19
draft: false
author: "Ronny Roethof"

categories:
- digital-sovereignty
- career-sysadmin

tags:
- infrastructure
- it-culture
- outsourcing
- resilience
- governance
- sysadmin

summary: "We haven't just outsourced our hardware; we've outsourced our technical problem-solving capability. The ultimate sovereignty question: when the system fails, who is allowed to fix it?"
description: "A strategic analysis of how the 'commodity IT' mindset has hollowed out technical depth and created a dangerous dependency on external managed services."
---

### The Commodity IT Fallacy: How We Outsourced Technical Sovereignty

My former colleague Robert van der Meulen recently wrote a sharp piece on *Werf&*: *[We must start investing again in people who understand how infrastructure works](https://www.werf-en.nl/we-moeten-weer-gaan-investeren-in-mensen-die-begrijpen-hoe-infrastructuur-werkt/)*. His plea hits a nerve that goes far beyond recruitment. It exposes a structural decay in our digital foundation.

#### The Leaseweb School (2008-2010)
Between 2008 and 2010, I worked as a Linux System Administrator at Leaseweb. Infrastructure wasn't invisible in those days. You heard failing disks. You watched kernel counters. You tuned TCP stacks. You knew that performance problems rarely solved themselves. It wasn't because engineers were smarter than they are today. It was because the abstractions hadn't yet insulated us from the consequences of failure.

Looking back, what stands out most is the relationship we had with the systems we operated. Infrastructure was something you touched, investigated, and understood. When a machine was slow, you did not start by opening a vendor ticket. You looked at the system. You checked memory pressure, I/O wait, interrupts, process behavior, and network throughput. You followed the problem down the stack until you found the cause. The server was not a black box. It was a system. That mindset created a different kind of engineer. It created someone who did not just operate technology, but understood why it behaved the way it did. That understanding was more than technical expertise. It was a form of sovereignty.

#### The Erosion of Stack Knowledge
The craftsmanship hasn't disappeared. It has increasingly concentrated within hyperscalers and a smaller number of specialized infrastructure teams. Many organizations, however, have transitioned into primarily consuming cloud services. The danger isn't the technology itself. It is the atrophy of the skill sets required to manage systems when the abstraction fails.

When everything is deployed via APIs, infrastructure becomes a black box. Modern cloud engineering often abstracts away the physics of IT. Understanding storage failure domains, network latency in multi-tenant environments, distributed consensus, database replication lag, and scheduler behavior is no longer seen as a prerequisite.

> The Commodity IT Fallacy is the belief that if you outsource the management, you also outsource the risk. You don't. You only outsource the ability to respond to it.

#### The Governance Gap
The C-Suite remains blind to this risk because they view IT through the lens of procurement rather than governance. They optimize for OPEX, CAPEX, and SLA agreements. They ignore the fundamental components of digital resilience:

* **Jurisdictional Risk:** Where is the data? Who is subject to the Cloud Act?
* **Vendor Coercion:** If a provider changes their terms or service levels, what is your exit feasibility?
* **Operational Continuity:** When the system fails, who is allowed to fix it?

#### The Ultimate Sovereignty Test
Sovereignty can be measured with a simple question: **When the system fails, who is allowed to fix it?**

This is not a question about technology. It is a question about ownership. If the answer is "someone outside the organization," then the organization does not fully control that system. Organizations today are increasingly operating on borrowed intelligence and rented infrastructure. They may have data access, but no operational control, no hypervisor authority, no ability to reproduce the environment independently, and no control over the model weights driving their business logic. They are tenants, not owners.

#### The Path to Resilience
Sovereignty does not mean eliminating external dependencies. That is impossible. It means identifying which dependencies are acceptable, which are dangerous, and maintaining the ability to recover when they fail.

1. **Distinguish Builders from Consumers:** Recognize that deploying a container on a managed platform is not the same as engineering a sovereign system. Both are necessary, but they require radically different governance models.
2. **Reclaim the Kernel:** Invest in teams that understand the OS, the networking stack, and the hardware. This knowledge is the only genuine defense against vendor lock-in.
3. **Open-Source Sovereignty:** True resilience comes from owning the stack. If you cannot run it on infrastructure you control, you don't fully control it.

### Conclusion
The outsourcing disease has hollowed out our expertise, turning architects into button-pushers. We have traded our technical autonomy for convenience.

We do not need every engineer to return to the server room. But we do need to bring back the mindset that created those engineers: curiosity, ownership, and the willingness to understand what happens beneath the abstraction layer. It is time to stop being mere consumers of the digital world and rebuild the capability to understand, operate, and control the systems we depend on, especially when they fail.