---
title: "The Compliance Mirage: 350GB of EU Silence"
slug: the-compliance-mirage-350gb-eu-silence
date: 2026-03-31
lastmod: 2026-03-31
draft: false
author: "Ronny Roethof"
categories:
- security-privacy
- digital-sovereignty
tags:
- shinyhunters
- aws
- nis2
- dkim
- compliance
summary: "The European Commission ran its infrastructure on AWS while writing sovereignty frameworks for everyone else. Now 350GB is gone. This was not a surprise."
description: "The European Commission ran its infrastructure on AWS while writing sovereignty frameworks for everyone else. Now 350GB is gone. This was not a surprise."
---

> **Compliance creates the illusion of control. Sovereignty demands proof.**

## The Incident

ShinyHunters has claimed the hack of the European Commission. 350GB of data is circulating on a dark web forum, [first reported by BNR Nieuwsradio](https://www.bnr.nl/nieuws/tech-innovatie/10597209/cyberbende-shinyhunters-eist-hack-europese-commissie-op).

I wrote this in [We Did This To Ourselves](https://roethof.net/posts/2026/03/we-did-this-to-ourselves-sovereignty-failure/) two weeks ago: "Handing keys to an unelected Commission in Brussels is the same mistake made with AWS and Microsoft, just dressed in the colours of the EU flag."

That was the argument. This is the proof.

What was taken: emails and attachments, a full SSO user directory, DKIM signing keys, AWS configuration snapshots, internal admin URLs. Those DKIM keys are the part that should get attention. With them, attackers can send mail that passes every authentication check, from official EC domains. A precise instrument for spear-phishing EU member states, national governments, critical infrastructure operators.

The Commission says no internal systems were hit. That sounds reassuring until you realise how little it actually says. If the data is out, arguing about where it lived is a distraction.

This is also the second incident this year. In February, attackers breached the Commission's mobile infrastructure and took staff contact data.

There was no ransom demand. That shifts the story. This is not about money. It is about exposure, pressure, signalling. That makes it significantly harder to contain.

## The Detail That Changes Everything

The attackers came in through the Commission's AWS environment. AWS has stated its platform experienced no security incident of its own. That means compromised credentials or a misconfiguration. Not a zero-day, not a sophisticated nation-state technique. A key left in the wrong place.

That is where this stops being a technical story and becomes a political one.

The institution that writes NIS2. That enforces DORA. That has spent years instructing member states on digital sovereignty and the risks of cloud dependency. That institution ran its own infrastructure on AWS.

It turned out to be more literal than intended. The Commission had its keys at AWS. In an AWS configuration snapshot that is now sitting on a forum.

## Compliance Was Never the Answer

In [The ISO 27001 Hallucination](https://roethof.net/posts/2026/03/iso-27001-compliance-illusion-resilience-failure/) I described how compliance culture operates: document that you consciously chose to do nothing, the auditor is satisfied. The certificate stays on the wall. The vulnerability stays in the system.

NIS2 and DORA are the European version of the same pattern, scaled to continental level. Frameworks that define requirements, describe controls, encourage organisations to report that they comply. What they do not do is verify that systems actually function as documented.

The Commission was likely compliant with its own standards. Yet 350GB is outside.

This is not surprising. It is exactly what happens when you confuse compliance with security. The checkboxes look fine. The keys were in the wrong place.

## The EU Was Never the Answer

I have been saying this for a while. This incident makes it more concrete than I expected.

In [Digital Vassals](https://roethof.net/posts/2026/01/digital-vassals-eu-suicide-note/) I wrote about how Europe runs sovereignty rhetoric while parking its infrastructure at American hyperscalers. The Commission is not an exception to that pattern. It is the example.

Anyone who thought Brussels was the answer to AWS and Microsoft dependency had it wrong. Delegated control is delegated control, regardless of whether the logo on the invoice belongs to Amazon or the EU. The accountability deficit is identical. The Commission is now a victim of precisely the infrastructure choices it discourages others from making. That is not irony. It is confirmation.

[The Digital Trump Moment](https://roethof.net/posts/2026/01/digital-trump-moment-sovereignty-bill-due/) covered what happens when the external pressure becomes real. This incident shows that you do not even need external pressure. The dependency itself is the vulnerability. It was always going to surface.

## What Sovereignty Actually Requires

If you want to know what is happening in your systems, you need to be able to see it. Not what they are supposed to do. What they actually do.

Closed systems and outsourced infrastructure make that structurally harder. You depend on what a vendor tells you, on what they choose to expose, on when they decide to fix something. You remain accountable but you are not in control. That combination does not hold under pressure.

Open source shifts that balance. Not because it is automatically more secure, but because it makes verification possible. You can inspect behaviour, test assumptions, adapt when needed. That is a fundamentally different position to operate from.

Denmark's Road Traffic Authority understands this. Their migration to [NixOS](https://nixos.org/) is not an ideology project. It is an operational decision: declarative, auditable, reproducible without vendor dependency. If upstream changes or political pressure lands, you redeploy on hardware you control. The rest of Europe is still arguing about the curtains.

This requires more: knowledge, ownership, the willingness to look deeper than a dashboard. If sovereignty is the goal, I do not see an alternative.

## What This Incident Actually Says

350GB is not a rounding error. It is a detailed map of how an organisation operates. Contracts, communications, internal processes, signing keys. Exactly the material you want if the goal is not just access but understanding.

If this can happen to the Commission, the institution that writes the standards, it is worth being honest about your own environment.

Not Brussels. Not AWS. Not a framework written by people who store their own data on someone else's infrastructure. Your stack. Your hardware. Your country.

Not in theory. Not in a report. In real time.

Would you see it happening?

---

*Related: [We Did This To Ourselves](https://roethof.net/posts/2026/03/we-did-this-to-ourselves-sovereignty-failure/) | [The ISO 27001 Hallucination](https://roethof.net/posts/2026/03/iso-27001-compliance-illusion-resilience-failure/) | [Digital Vassals](https://roethof.net/posts/2026/01/digital-vassals-eu-suicide-note/) | [The Digital Trump Moment](https://roethof.net/posts/2026/01/digital-trump-moment-sovereignty-bill-due/)*