---
title: "I Love FreeBSD. I Admire NixOS. I Still Choose Debian."
slug: i-love-freebsd-i-admire-nixos-i-still-choose-debian
date: 2026-06-28
lastmod: 2026-06-28
draft: false
author: "Ronny Roethof"
cover: posts/2026/06/i-love-freebsd-i-admire-nixos-i-still-choose-debian/cover.jpg

categories:
- linux-open-source
- career-sysadmin

tags:
- freebsd
- nixos
- debian
- rhel
- bus-factor

summary: "The hardest infrastructure decisions are not technical. They are operational."
description: "The most elegant solution is rarely the one that survives the longest. Why I prioritize Debian over the siren call of perfection."
---

The most elegant solution is rarely the one that survives the longest.

I love FreeBSD. I admire NixOS. I still choose Debian.

Not because Debian is perfect, but because infrastructure is not built for the person who creates it; it is built for the people who inherit it.

Dávid Pap published a post on LinkedIn this week that occupied my thoughts longer than most. He built his homelab as a fully declarative platform, utilizing Terraform and Terragrunt for the Proxmox LXC layer, NixOS per container with Nix Flakes for service configuration, SOPS for secrets management and custom HTTPS routing. Everything in one repository. Reproducible. Modular. His description: ["behaves much more like a real platform."](https://www.linkedin.com/posts/papdawin_i-built-my-home-server-as-a-fully-declarative-share-7474899675167244289-lbI4/)

He is right. And yet, it is exactly what I will never deploy in production.

### The trap of perfection

Emotionally, the answer is FreeBSD. Always has been. FreeBSD remains, to me, one of the most coherent operating systems ever built. The documentation, the ports tree, jails and ZFS integration all feel like they belong together. It represents a unified philosophy from kernel to userland, built by people who viewed an operating system as a single, coherent project rather than a collection of disparate packages glued together. That philosophy is one of the reasons organizations such as Netflix and the PlayStation Network have built critical infrastructure on top of it.

If I were designing infrastructure purely for engineering elegance, I would choose NixOS. What Dávid describes is the promise of NixOS in practice. Configuration drift disappears, rollbacks are built in and infrastructure becomes truly deterministic. 

I do not deploy NixOS, however. Not because I do not want to, but because I am not an island. If I were the sole architect and had full control over the hiring pipeline, I would seriously consider mandating NixOS and investing in the necessary training. The technical advantages of NixOS for declarative infrastructure are undeniable. But infrastructure decisions do not exist in a vacuum. They exist inside organizations, teams and operational realities. In the current market, finding engineers with deep Nix expertise is still uncommon. Introducing that level of specialization into a team that is predominantly RHEL-certified or Debian-minded creates a significant operational dependency. Adopting NixOS today would effectively turn me into a single point of failure and create a barrier for every colleague who needs to understand or maintain the system. I refuse to build an environment where the technology itself becomes the limiting factor in collaboration.

### The Debian paradox

The industry has entered into a silent covenant. That covenant is Debian. It has become the common language of Linux infrastructure. Almost every administrator understands it, almost every automation workflow already knows how to deal with it and almost every problem has already been solved by someone else. 

It is boring, but boring is a feature. Ubuntu is Debian with a corporate agenda layered on top. It trades simplicity for convenience: more defaults, more tooling, more opinions and more moving parts. Snap is a perfect example of this approach: solving problems by adding yet another abstraction layer. That may be a good trade-off for desktops, but for infrastructure, I prefer fewer decisions made on my behalf.

RHEL, by contrast, is often a masterclass in operational friction. It is a bloated ecosystem designed to keep you trapped in a cycle of vendor-locked compliance and subscription management, allowing middle management to offload their responsibility to a support ticket. When production is burning at 3:00 AM, the last thing you want is a RHEL-specific quirk, a broken repository subscription, or an SELinux policy acting as a gatekeeper against your own recovery efforts.

> Infrastructure is not a solo project, even if you are the only one working on it.

The Bus Factor is not an abstract metric. It is the question: if I am gone tomorrow, can someone else continue? With FreeBSD or NixOS, the answer is often no. With RHEL, the answer is a complicated "maybe, if they have a support contract." With Debian, the answer is a weary but affirmative "yes."

### Conclusion

Dávid built something I am genuinely jealous of. Not the setup itself, but the context that makes it possible—an environment where he is the only administrator.

There is a profound difference between building beautiful systems and building sustainable systems. The former earns admiration, but the latter survives staff turnover, acquisitions, reorganizations and the inevitable 3:00 AM incident. In production, sustainability wins. 

Your choices determine whether the system survives your departure. I choose Debian. Every single time. Not because it is the most elegant solution. For declarative infrastructure, NixOS has a stronger story. I choose Debian because infrastructure is not just about what can be built. It is about what can be understood, maintained and handed to the next person.