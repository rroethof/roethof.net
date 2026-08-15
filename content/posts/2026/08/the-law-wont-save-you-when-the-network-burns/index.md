---
title: "The Law Won’t Save You When the Network Burns"
slug: the-law-wont-save-you-when-the-network-burns
date: 2026-08-15
draft: false
author: "Ronny Roethof"

categories:
- security-privacy
- opinion-reflections

tags:
- nis2
- iso27001
- open-source
- security-engineering
- cyberbeveiligingswet

summary: "Compliance is not security. The Cybersecurity Act should strengthen resilience, not put engineers in handcuffs."
description: "The Dutch Cybersecurity Act is now in force. But compliance does not equal security, and excessive controls can actively work against security and productivity."
---

# The Law Won’t Save You When the Network Burns

Today, 15 August 2026, the Dutch Cybersecurity Act and the Wwke enter into force.

The NCSC has announced it, and my old colleague and friend Edwin Ribbers wrote a good piece about what this means for IT, OT and security resilience.

[**NCSC: Cbw en Wwke zijn vandaag in werking getreden**](https://digitaltrustcommunity.nl/cbw-nis2/f/forum/2320/cbw-en-wwke-zijn-vandaag-in-werking-getreden)

[**Edwin Ribbers: Morgen treedt de Cyberbeveiligingswet in werking**](https://www.linkedin.com/pulse/morgen-treedt-de-cyberbeveiligingswet-werking-wat-er-vanaf-ribbers-35q1e/)

Edwin is right, and I fully agree with him: security has to be about resilience, not about ticking boxes for an auditor. Compliance is too often a paper tiger. It looks solid until something actually happens.

That distinction matters because compliance and security are not the same thing. In fact, sometimes compliance actively works against security.

I've seen organisations where an engineer needs multiple approvals, tickets and change windows to make a security-related change. Everything is controlled. Everything is documented. Everything is auditable.

And when something is actually happening, the engineer is sitting there waiting for approval.

That is not necessarily security.

Sometimes it is simply an engineer with handcuffs around their wrists.

A security control that prevents your security engineer from responding quickly to an incident can become a security problem itself. The same applies to productivity. When every administrative process becomes a control, people eventually stop working with the controls and start working around them.

That is how you get shadow IT. Shared accounts. Unapproved tools. Workarounds. Emergency exceptions that become permanent. People keeping local copies of things because getting access through the official process takes three weeks.

The organisation then congratulates itself because everything is "compliant".

Compliant does not mean secure.

Compliant often means that you have demonstrated that you follow a defined process. Whether that process is actually sensible is another question.

This is one of the reasons I am sceptical about the way large organisations approach security. Give them a security problem and they often respond by adding another layer of process. More policies. More approvals. More segregation of duties. More dashboards. More evidence.

Eventually the engineer who actually understands the infrastructure spends more time proving that they are allowed to fix something than actually fixing it.

Meanwhile, the underlying problems remain.

Old privileged accounts. Flat networks. Systems nobody understands. Third-party remote access. Backups that have never been properly restored. Monitoring that generates more noise than useful information. Critical infrastructure dependent on a single person who happens to be unavailable when things go wrong.

But the documentation is immaculate.

That is not the kind of security I care about.

I care whether we can see what is happening. Whether privileged access is actually controlled. Whether the network is really segmented. Whether compromised systems can be isolated. Whether logs can be trusted. Whether backups are isolated and restorable. Whether we can rebuild identity. Whether we know what is actually running in our environment.

And I care about whether the engineer is actually allowed to do something about it.

Security engineering is still engineering. You need people who understand the systems and are trusted to make decisions. You need guardrails, not handcuffs.

This is also where open source fits into my view of security.

Open source does not automatically make anything secure. It does, however, give you something proprietary systems often don't: control.

You can inspect it. You can fix it. You can maintain it. You can keep running it when a vendor disappears. You can build around it instead of waiting for a vendor to decide whether your problem fits their roadmap.

But that requires engineers who actually understand the technology.

You cannot outsource all your technical competence and then claim sovereignty because the software happens to have an open licence.

The same applies to supply-chain security. Sending a supplier another questionnaire and collecting another certificate is not the same as understanding what happens when that supplier is compromised or disappears.

The real question is always what happens when the assumptions fail.

Your identity provider is compromised. Your backup system is unavailable. Your primary supplier is offline. Your monitoring cannot be trusted. Your production environment is compromised.

Can your engineers still act?

Can they isolate systems?

Can they rebuild?

Can they recover?

Or do they first need to open a ticket and wait for somebody from compliance to approve the emergency procedure?

That last question is deliberately provocative, but it is an important one.

There is a point where controls stop reducing risk and start creating it.

The Cybersecurity Act can force organisations to take responsibility. Fine.

But no law can give you competent engineers, good architecture or operational discipline.

Those still have to come from somewhere.

And that is exactly where I hope we don't fuck this up.

Don't turn the Cybersecurity Act into another industry dedicated to proving that organisations are secure.

Use it as a reason to finally fix the things everybody already knows are broken.

Because when the network burns, nobody is going to care how many boxes were green in the last audit.

Someone will have to rebuild it.