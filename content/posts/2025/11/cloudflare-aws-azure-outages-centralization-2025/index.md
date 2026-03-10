---
title: "Cloudflare Fell Over And Everyone Built on Top of It Too"
slug: "cloudflare-aws-azure-outages-centralization-2025"
date: 2025-11-19
description: "Cloudflare sneezed, AWS and Azure wobbled, and once again we learned that 'distributed' often means 'we stuffed everything behind one vendor and hoped for the best'."
tags: ["cloudflare", "aws", "azure", "outage", "centralization", "resilience", "vendor-lock-in", "infrastructure", "AI", "cloud"]
categories: ["infrastructure", "opinions"]
draft: false
---

Another week, another outage, Cloudflare this time, but let’s not forget AWS ([see my post](https://roethof.net/posts/2025/10/when-the-cloud-falls-the-world-trembles/)) and Azure in Europe, which went down due to a “thermal event” ([Techzine EU](https://www.techzine.eu/news/privacy-compliance/136407/aws-azure-and-google-cloud-under-scrutiny-by-eu-after-series-of-outages/)).  
And just like clockwork, the internet reacted with shock, panic, and LinkedIn posts about distributed systems from people whose production environments collapse the moment one vendor sneezes.

Let’s be honest, the Cloudflare meltdown wasn’t interesting because something broke.  
It was interesting because it exposed again how fragile our supposedly “resilient” cloud ecosystem really is.  
Spoiler, it isn’t resilient. It is centralized, painfully, stupidly, predictably centralized.

And I’ve written about this before:

- [When the Cloud Falls, the World Trembles (AWS)](https://roethof.net/posts/2025/10/when-the-cloud-falls-the-world-trembles/), one provider goes down, and the ripple is global  
- [The Sovereignty Kill Switch](https://roethof.net/posts/2025/11/kyndryl-solvinity-sovereignty-kill-switch/), when one party controls enough infrastructure to pull the plug on your digital sovereignty  
- [The Exit That Never Was](https://roethof.net/posts/2025/11/the-exit-that-never-was-iso27001-dutch-government-solvinity-panic/), where ISO27001 and governance theater cannot save you  
- [VMware Is Dead](https://roethof.net/posts/2025/11/vmware-is-dead-broadcom-killed-operational-trust/), consolidation and vendor dominance kill operational trust

Different stories, same disease, single-vendor dependence dressed as strategy.

---

## 1. Distributed, They Said

Cloudflare exists to distribute traffic globally.  
Yet the outage proved what marketing slides never mention.

> The global internet runs on a handful of centralized choke points.

Cloudflare blinks, DNS breaks, CDNs break, APIs stall, dashboards fail, auth flows collapse, applications stop.  
Not a chain reaction, a vertical drop through every layer built on top of one vendor.

This pattern isn’t new. When AWS or Azure goes down, the ripple is huge, it is not just “my cloud is unavailable,” it is our entire stack trembling.

---

## 2. The Timeline That Reads Like a Slow-Motion Car Crash

Cloudflare’s own status updates read like a tragicomic map of global dependency:

- 11:48 UTC, internal service degradation, something is very wrong  
- 12:03–12:53 UTC, investigating, some customers experience intermittent errors  
- 13:04 UTC, WARP access disabled in London, fix one problem, break another  
- 13:09 UTC, root cause identified, remedial work begins  
- 13:13–13:58 UTC, partial recovery, but errors persist  
- 14:22–14:57 UTC, application services being restored  
- 15:40–16:46 UTC, mitigations deployed, monitoring, clearing errors  
- 17:14–17:44 UTC, latency and error rates gradually improve  
- 19:28 UTC, incident marked resolved, systems nominal for now

Affected, Access, WARP, Firewall, CDN/Cache, Workers, Bot Management, Dashboard, Network.  
One vendor, global blast radius.  
This was not a “small bug,” it was a reminder, live and loud.

---

## 3. Most Organizations Don’t Have Control, They Have Dependencies

Control, real control, not just the illusion of it.  
When Amazon, Microsoft, or Cloudflare hiccup, do you have a fallback, or do you just cross your fingers and hope your SLA saves you?

Hope didn’t help when AWS stumbled ([roethof.net](https://roethof.net/posts/2025/10/when-the-cloud-falls-the-world-trembles/)) and it certainly didn’t protect services when Azure’s data center cooling took a thermal dive ([Techzine EU](https://www.techzine.eu/news/privacy-compliance/136407/aws-azure-and-google-cloud-under-scrutiny-by-eu-after-series-of-outages/)).  

True resilience means designing for failure, not pretending it can’t happen.

---

## 4. Compliance Is Not Resilience

> ISO27001? Risk registers? SLA clauses? Certificates?  
> Ah yes, everyone was so brutally in love with these, weren’t they?

None of it kept dashboards, WARP, CDNs, or AI pipelines alive.  
Compliance is for auditors and board decks.  
Resilience is for when those decks catch fire.

---

## 5. Vendor Trust Is Not an Architecture

Cloudflare, AWS, Azure, they are all good, very good, but good doesn’t mean infallible.  
When you lean too hard on one of them, you are building on quicksand.  
And when the ground shifts, your entire stack feels the tremor.

---

## 6. The Way Forward, Stop Playing Cloud Roulette

If all these outages, Cloudflare, AWS, Azure, didn’t raise red flags, then what will?  
The internet isn’t decentralized, it is a brittle pyramid.

Here’s how to survive the next one:

- Map your dependencies, know which provider powers what and where your risk lies  
- Multi-CDN, multi-DNS, multi-region, multi-provider, redundancy is not a luxury  
- Treat status pages and incident runbooks like real infrastructure, they are not just for show  
- Include AI workflows in your resilience strategy, cloud hiccups mess with your models just as badly as your website  
- Use open source wherever possible, it gives you exits, exit strategies aren’t for show

---

## 7. Open Source Resilience, A Proxmox Example

And yes, I know what some of you will say, “But Ronny, you preach Proxmox, what if they suddenly stop?”

Fair. I didn’t pick Proxmox for popularity, I picked it because I know it.  
Here’s why it matters for this argument:

1. Proxmox runs on KVM and LXC, open, standardized layers, not some proprietary black box  
2. If Proxmox disappears, either the community forks or you lift the underlying KVM/LXC into another hypervisor

That’s what open source gives you, exit options built into your base layer, not promises from a vendor.

---

## 8. The Irony of Over-Engineering

Even if you do everything right, the universe still finds a way to mess things up.  
Case in point, [NIKHEF](https://tweakers.net/reviews/14052/een-minuut-uitval-bij-nikhef-ontregelde-odidos-mobiele-netwerk-urenlang.html): one single minute of downtime, and a huge chunk of the Netherlands went offline.  
KPN, Odido, Euronet, and countless others collapsed like dominos.

Redundancy? Check. Failovers tested? Check. Everything engineered to perfection? Check.  
And yet, "overmacht", sheer force majeure.  
Even perfect engineering cannot fight gravity, Murphy’s Law, or a little bit of cosmic mischief. Recognize it, recover fast, and accept that sometimes you are simply at the mercy of forces beyond your control.

---

## The Irony Department


Before anyone points it out, yes, this weblog is also behind Cloudflare.  
Meaning that when Cloudflare had a bad day, *you* probably couldn’t read my previous posts about why centralizing everything behind one vendor is a terrible idea.  

Delicious irony.  
And also a reminder that I, too, have some housekeeping to do.

---

## Closing

This wasn’t just a Cloudflare outage.  
It was a symptom of a bigger disease, overreliance on a tiny number of providers.  
AWS, Azure, Cloudflare, they are all part of the same fragile infrastructure web.

If we keep building on that web without a plan B, we’ll keep getting burned.  
Regie isn’t something you outsource.  
Resilience isn’t something you buy, it is something you engineer.

Let’s stop acting surprised when giant pieces of the internet fall over.  
Time to build something that doesn’t.
