---
title: "Fortinet’s Quiet War on Linux Workstations"
slug: "fortinet-war-on-linux-workstations"
date: 2026-03-12
author: "Ronny Roethof"
draft: false

categories:
- security

tags:
- linux
- fortinet
- enterprise-it
- sysadmin
- infosec
- vendor-lock-in
- it-strategy

summary: "How Fortinet’s licensing changes force Linux engineers into costly VPN workarounds, creating operational risk."
description: "Fortinet removes SSL VPN tunnel mode in FortiOS 7.6.3, forcing Linux users into costly workarounds and increasing operational risk."
---

## Fortinet’s Quiet War on Linux Workstations

FortiOS 7.6.3 kills SSL VPN tunnel mode. IPsec is now mandatory.  
Linux users? They just got hit with a licensing tax. This isn’t a bug. It’s a choice.

Many organizations rely on Linux to run critical infrastructure. Yet when it comes to VPN support, Fortinet clearly draws a line: Windows and macOS get full-featured clients. Linux? You get partial support—and only if you pay extra.

## The FortiClient Divide

* **Windows & macOS:** Standalone client supports both SSL and IPsec.  
* **Linux:** Standalone client supports SSL only.

Yes, IPsec exists for Linux. It’s in the code. But to enable it, you need Fortinet EMS. This isn’t a technical limitation—it’s deliberate product segmentation. A licensing gate.

Linux engineers are now forced into workarounds, often using open-source clients like StrongSwan or OpenFortiVPN. Centralized management evaporates. Workarounds multiply. Operational risk skyrockets.

## The Painful Irony

Linux powers the servers, firewalls, and critical services Fortinet itself runs on. Yet the people keeping these systems secure are treated as second-class citizens. Security and convenience are effectively rationed by the vendor, not by technical necessity.

## Real-World Impact

Engineers under these constraints often get creative:

* **SSH hops and reverse tunnels** to reach restricted networks.  
* **Custom scripts** to automate VPN reconnections.  
* **Alternative VPN clients** that bypass central controls.

These are clever hacks, but they undermine central governance. They reduce visibility, increase auditing gaps, and introduce new security risks—all because of a licensing model.

As [Edwin Ribbers](https://www.linkedin.com/posts/edwinribbers_de-meeste-security-incidenten-ontstaan-niet-ugcPost-7437779936922337280-QOmg) notes, most security incidents don’t start with malicious engineers. They start with policy choices in the boardroom. Forcing Linux users into workarounds is a perfect example.

## The Bottom Line

Fortinet saves a few licensing dollars. Engineering teams pay with operational headaches and security blind spots. When licensing models dictate your OS strategy, your infrastructure has already lost.

## Extra Context: Why Linux Matters

Linux isn’t niche. It powers:

* Servers and cloud infrastructure  
* Network appliances and Fortinet devices themselves  
* Development, CI/CD pipelines, and automation frameworks  

Restricting VPN features on Linux doesn’t make the environment more secure—it encourages engineers to circumvent central controls. Risk increases while licensing revenue does too.

---

### Key Takeaways

#### Vendor-Imposed Segmentation
Segmenting features by OS creates operational risk, not security.

#### Workarounds Are Inevitable
Linux engineers will find ways to connect, often bypassing central policies.

#### Policy Decisions Beat Technical Skills
Security incidents rarely start with engineers—they start with boardroom choices.

#### Licensing vs Operational Risk
A small licensing save can create massive technical debt.

---

**Awareness is the first defense. When vendors force artificial limitations, engineers adapt—but the organization pays the price.**