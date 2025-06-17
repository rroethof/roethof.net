---
date: '2025-10-28T12:00:00+01:00'
draft: false
title: 'When the Cloud Falls, the World Trembles'
tags:
  - 'cloud'
  - 'aws'
  - 'outage'
  - 'mainframe'
  - 'resilience'
  - 'private cloud'
  - 'hybrid cloud'
  - 'proxmox'
  - 'control'
  - 'digital sovereignty'
  - 'infrastructure'
categories:
  - 'Cloud Computing'
  - 'IT Infrastructure'
  - 'Technology & Society'
  - 'Hybrid Cloud'
  - 'Security & Privacy'
description: "A recent AWS outage highlights the critical dependency on public cloud providers, contrasting their fragility with the enduring resilience of mainframes and advocating for balanced hybrid and private cloud strategies."
slug: "when-the-cloud-falls-the-world-trembles"
---

But the Mainframe and Private Infrastructure Keep Running.

So, Amazon Web Services (AWS) took a nosedive today, suffering one of its largest outages in recent years.
A failure in the DynamoDB data service in the Northern Virginia region triggered a global chain reaction that disrupted platforms, banks, and applications worldwide.

Millions of users and companies were left waiting as part of the internet’s backbone faltered.
Apps like Snapchat, Duolingo, and Signal went offline for hours, and several financial services across Europe and the United States reported instability.

And what do the "experts" say? That this is a stark reminder of how dependent we have become on a handful of public cloud providers. No kidding. When one of them trips over a cable, millions of digital operations collapse with it. It’s the fragile reality of the [digital sovereignty we pretend to have](/posts/2025/05/dutch-gov-sovereign-cloud-paper-tiger/).

## The Cloud Isn’t a Magic Bullet

Public cloud is often promoted as the ultimate solution for flexibility, scalability, and innovation.
And in many cases, it delivers. But there’s a hidden cost: overreliance.

When critical workloads exist entirely in one cloud environment, they are vulnerable to failures outside your control.
Even so-called “multi-cloud” or “hybrid cloud” strategies are often less resilient than they appear on a PowerPoint slide.

Why? Because moving data between clouds or from cloud to your own infrastructure is rarely seamless.
APIs differ, storage formats are incompatible, and bandwidth or latency can make large-scale migration impractical.
In other words, it’s easy to claim “multi-cloud” on paper, but actually achieving true portability is hard, expensive, and often overlooked.

> High availability in the cloud does not guarantee true resilience.
> Resilience requires control, redundancy, and predictability, not just blind faith in a third-party provider’s infrastructure.

## Lessons from the Mainframe

Meanwhile, the mainframe quietly continues to demonstrate what resilience really means.
For more than fifty years, IBM z/OS systems have powered the world’s most critical services with stability, precision, and near-perfect uptime.
Its architecture is designed to absorb failures, maintain transactional integrity, and recover quickly. It's a blueprint for what reliability actually looks like.

This isn't nostalgia. It's a reminder that true stability comes from ownership, architecture, and redundancy, not marketing promises.

## Private Clouds and Hybrid Models: A Safer Approach

If you are serious about reliability, relying solely on public cloud is risky.
Private cloud platforms, like the [Proxmox clusters I'm so fond of](/posts/2025/03/favorite-tech-tools-2025/), provide many cloud benefits: virtualization, snapshots, high availability, and clustering, all while keeping your infrastructure under your control.

A properly designed private cloud or hybrid model can:

 * Spread critical workloads across multiple nodes or locations.

 * Enable fast failover without depending on a vendor’s regional infrastructure.

 * Keep sensitive or business-critical systems under your control.

 * Allow predictable and compatible data migration between clusters, something public clouds rarely make easy.

In other words, you get agility without the fragility, and portability without vendor lock-in.

## The Real Takeaway

The future is not about blindly chasing cloud hype or adopting “multi-cloud” for marketing points.
It is about intentional design, hybrid thinking, and [taking back control over your data](/posts/2025/04/oss-security-platform-blueprint/).

Clouds are amazing for rapid development and global reach, but they are not infallible.
Relying on a single provider, or assuming that multi-cloud magically solves the problem, leaves you exposed.
True resilience comes from diversifying infrastructure, maintaining control over critical systems, and planning for failure across both cloud and local environments.

> Because not everything new is stable, and not everything old is outdated.

Sometimes, the smartest move is to bring some of the cloud home and design it in a way that your data actually moves where you need it to go.
