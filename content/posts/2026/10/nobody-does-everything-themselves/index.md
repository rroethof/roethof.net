---
title: "Nobody Does Everything Themselves"
slug: "nobody-does-everything-themselves"
date: 2026-10-04
lastmod: 2026-10-04
draft: false
author: "Ronny Roethof"
categories: ["digital-sovereignty", "devops-infrastructure"]
tags: ["proxmox", "colocation", "dark-fibre", "exit-strategy", "datacentre"]
summary: "An Italian AI startup claims it depends on no one. Nobody can say that. Sovereignty is a choice made layer by layer, with a way out on every layer."
description: "Digital sovereignty is not an on/off switch. A practical look at owned hardware, colocation, a leased fibre ring and the question of which dependencies you choose on purpose."
---

*Digital sovereignty is not a switch. It is a choice per layer, with an exit.*

A few days ago I came across a LinkedIn post from XFERENCE, an Italian AI startup. It showed new storage drives being racked in their own facility, with a clear message: the machines are theirs, only they can touch them, and they depend on no one. My first reaction was yes, exactly. My second reaction was no, not quite.

## What they get right

The core of that post is strong. Cloud has become a dangerously vague word. We talk about capacity and cost, and far too little about who can physically reach the machines and who can switch them off. If you do not know where your data and your models physically run, no contract will fix that for you.

I run three Dell PowerEdge servers in a clustered Proxmox setup in a datacentre, and I recommend on-prem to anyone who will listen, preferably across more than one site. Hardware in your own hands is a better starting point than someone else's hardware. Cloud is, after all, just another person's computer.

## What they get wrong

Nobody does everything themselves. The drives come from a manufacturer, the firmware from a vendor, the power from a grid operator and the glass from a carrier. Even companies that build their own datacentres buy their GPUs from Nvidia and have their chips made by TSMC. "We depend on no one" is a slogan, not a description of reality.

The honest version is less catchy. You choose on which layers you accept a dependency, and you make sure there is a way out on each of them.

## Where the top of the scale sits

I have spent part of my career at companies where running the datacentre is the business, including eBay and Leaseweb. That is the far end of the scale. The buildings, the power, the cooling, the carrier connections and the people who keep it all running around the clock are the product, not a supporting function. When I say "full control", that is the benchmark I have in mind. I wrote about what happens to that kind of operational knowledge in [The Suit Killed the Operator](/posts/2026/04/the-suit-killed-the-operator/).

Almost nobody else works like that, and almost nobody should try. Most organisations run IT to support something else. That changes what a good setup looks like.

## What a good setup looked like

The best setup I have seen for an organisation whose core business is not running datacentres was at a Dutch municipality. A municipality is not a datacentre operator. It exists to serve its residents, and its IT supports that task. Even so, it had two server rooms in two separate buildings: one in the town hall and one in an office building elsewhere in the city. Each room held twenty racks and had its own uplinks. On top of that, there was a private rack at Iron Mountain, about fifteen minutes away by car. All three sites were connected through the same dark-fibre ring.

That gave us three separate failure domains. Two rooms in our own buildings carried the daily workload. The third site sat outside municipal buildings and municipal power, and it could serve as the third vote for quorum as well as a place for offsite data. Because everything was within one city, I could get in a car and be on site within minutes when something broke. Remote hands is a fine service, but a fifteen-minute drive is a different level of control.

Even so, it was not "nobody but us", and it was certainly not a purpose-built datacentre like the environments I had worked with at Leaseweb. The two server rooms were inside buildings designed for other purposes. They were built and equipped as well as that constraint allowed, but they were still municipal buildings first and datacentre facilities second. The ring was managed by EuroFiber, and the redundancy was written into the SLA. That is a contractual promise, not technical proof. The fibre was leased, the building at Iron Mountain belonged to Iron Mountain, and the last stretch of cable into each building belonged to someone else again.

We owned the servers, the data and the management. Everything else was a dependency we knew about, could test, and could replace if we had to. For an organisation of that type, that is about as good as it gets.

## My own cluster today

My current setup sits lower on the scale. Three PowerEdge servers in a datacentre is colocation. The building, the cooling, the power and the network belong to someone else. I am fine with that, but I do not call it "only we can access it". I made the choice deliberately. I gave up some convenience in exchange for control over my data and my stack, and I know exactly which layers I have outsourced.

## Four questions per layer

Take every layer of your infrastructure and ask the same four questions. Can I leave if this goes wrong, and what would it cost in time? Who can reach my data, including indirectly through management tooling, firmware or a supplier? Who is allowed and able to fix it when it breaks? And have I ever tested it, or is my failover an assumption?

I wrote about the last two in [The Commodity IT Fallacy](/posts/2026/06/the-commodity-it-fallacy/), and about the first in [Portability Is Not an Exit Strategy](/posts/2026/09/portability-is-not-an-exit-strategy/). The answers differ per layer, and that is exactly the point. A single yes or no for "are we sovereign?" hides more than it shows.

## Know what you outsource

I am not against cloud. I am against dependencies that nobody chose on purpose. Owned hardware, a rented rack and a ring from a carrier can all be defensible choices, as long as you know what you give up and what you get back.

On-prem does ask for people who can run it, patch it and recover it. Without that knowledge, it is not sovereignty. It is a continuity risk with a nice label.

So ask the question XFERENCE ends its post with, but make it more honest. Not "do you know where your data lives?", but "do you know which layers you depend on, on whom, and what your way out is?"