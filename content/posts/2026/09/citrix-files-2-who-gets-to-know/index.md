---
title: "Citrix Files 2: The Revenge? Who Gets to Know"
slug: "citrix-files-2-who-gets-to-know"
date: 2026-09-29
lastmod: 2026-09-29
draft: true
author: "Ronny"
cover: ""
categories: ["security-privacy", "digital-sovereignty"]
tags: ["citrix", "netscaler", "ncsc", "cyberbeveiligingswet", "tlp"]
summary: "The NetScaler zero-days raise a question that reaches beyond Citrix: when a national CSIRT warns some organisations before others, who decides who is worth protecting first?"
description: "Actively exploited NetScaler zero-days and a reported NCSC pre-notification raise an uncomfortable question about national cyber resilience: protection that depends on who is on the distribution list."
---

*What does "national cyber resilience" mean when protection depends on who happens to be on the distribution list during a crisis?*

In my previous article I wrote about the new Citrix NetScaler vulnerabilities and a problem that I believe reaches beyond Citrix: what happens when an organisation can no longer simply shut its digital front door? Since then a second question has emerged. **Who tells you that someone is trying to get through that door?**

Over the past few days the NetScaler zero-days sparked a discussion that worries me more than the vulnerabilities themselves. Jan Guldentops made a related point on LinkedIn about vendor communication, and that post prompted me to write this piece. My focus is different. It is not about Citrix, and it is not about exploitation. It is about information. Who gets warned, when, and through which channel? And above all: **who decides who gets to know?**

## The Information Gap

This is not a theoretical question. Citrix has fixed eight vulnerabilities in NetScaler ADC and Gateway, and the NCSC confirms that two of them are being actively exploited, including a flaw that allows an unauthenticated attacker to execute commands remotely. Patches are available. The public NCSC advisory, labelled TLP:WHITE, was published on 27 September.

But before that public moment, information was already circulating in limited circles. Tenable describes reports of a Dutch NCSC pre-notification that was reportedly distributed under TLP:AMBER+STRICT, and it states explicitly that it could not independently verify the content of that notification. I want to be careful here. I do not know what was in it, and I do not know who received it. That is exactly the problem. Neither do the organisations that are now wondering whether they should have been told.

## National Cyber Resilience

The NCSC does not hold an arbitrary role. Since 15 August 2026 the Cyberbeveiligingswet, the Dutch implementation of NIS2, has been in force, and the NCSC is designated as the national CSIRT. Its statutory tasks include early warning of organisations, distributing information about risks and incidents, and informing and advising on threats.

That is a promise, and a promise has consequences. **If you are the national CSIRT, you do not get to decide who deserves to be protected first.** I have no problem with an exploit not being thrown onto the street, and I have no problem with operational details being embargoed. As an administrator I do not need to know which threat actor is behind an attack, and I do not need exploit code or a full set of TTPs. But if my organisation runs a vulnerable NetScaler and there are strong indications that a remote code execution flaw is being exploited, I need to know. That is not secret intelligence. It is the information I need to assess my own risk, and if you withhold it, you are making that risk decision for me.

## Embargoes Expire

Staged disclosure has a logic. While a patch is still being written and nobody is exploiting the flaw, limiting who knows can buy time. I understand that. But the logic expires the moment exploitation has started. From that point secrecy protects nobody except the attacker, who is already in, and what remains is a choice about who finds out in time and who finds out from the news.

Information leaks anyway. Reddit, dark web forums and security circles were already discussing these vulnerabilities before any official statement. So the risk of a leak is not an argument for a narrow distribution list, because it applies equally to everyone already on it. The only thing a narrow list reliably achieves is that the organisations outside it learn about the danger last.

## Critical to Whom?

Then comes the question of who counts as critical. Triage belongs in an emergency room because beds, surgeons and time are scarce. Information is not scarce. Warning a small company costs nothing extra and takes nothing away from the hospital that was warned first. If organisations were ranked by how critical they are, and if the smaller ones were left out because of that ranking, then someone decided who may carry the damage.

To a ministry, "critical" is a category in a policy document. To the owner of a company of fifty people it is the business he built over twenty years, and the salaries of everyone who works there. If exploitation ruins that company, it was critical enough. A NetScaler does not know whether it sits in front of a ministry, a hospital, a multinational or a small business, and the attacker does not care either. So why would our warnings make that distinction?

## The MSP Multiplier

Nobody has to get the same information at the same second for this to work. There is a practical way to reach far more organisations without publishing an exploit: inform the MSPs. One trustworthy MSP can reach hundreds of organisations, many of which have no idea how dependent they are on a product like NetScaler. Use TLP, use NDAs, use secure channels, but **make sure the information reaches the people who actually run the systems.** Otherwise we end up with a peculiar form of resilience. The government knows there is a fire, part of the country gets a phone call, another part gets nothing, and then everyone is expected to protect themselves.

## Judge It Afterwards

Perhaps the risk assessment was entirely defensible. Perhaps broad communication would genuinely have been more dangerous at that moment, and perhaps there were good operational reasons for a narrow distribution. We should be able to judge that afterwards, and that is precisely the point. I do not believe every government decision should be public. But trust does not arise because an institution says it made the right call. It arises when people can understand **why** the call was made, and which criteria decided who was told first.

So the NCSC should publish those criteria. Who is on a pre-notification list, who decides that, and can an MSP or a smaller organisation ever get on it? If the answers are reasonable, publishing them costs nothing. If they are not, we need to know that before the next crisis, not after.

## Who Is on the List?

The NetScaler vulnerabilities have been patched, but the discussion is far from over. The next zero-day will not wait for the policy processes to finish, the next attacker will not wait for a press release, and the next MSP will again have hundreds of customers, with nobody knowing how many depend on a particular product.

So perhaps we should stop asking only **when we may make information public**, and start asking **who needs to know, at a minimum, that they are in danger**. That is a very different question, and probably a more important one. If the NCSC wants to be the security service for everyone, one principle belongs to it: **if you place the responsibility for self-protection on organisations, you must also give them the information they need to carry it.**

Otherwise we are not protecting the Netherlands. We are protecting a distribution list.

## Sources

- NCSC, "Kwetsbaarheden in Citrix NetScaler ADC en NetScaler Gateway: update nu": https://www.ncsc.nl/alerts/kwetsbaarheden-in-citrix-netscaler-adc-en-netscaler-gateway-update-nu
- NCSC Security Advisory NCSC-2026-0394, 27 September 2026: https://advisories.ncsc.nl/2026/ncsc-2026-0394-0.pdf
- Tenable, "Frequently Asked Questions About Reported Citrix NetScaler Zero-Day Vulnerabilities": https://www.tenable.com/blog/frequently-asked-questions-about-reported-citrix-netscaler-zero-day-vulnerabilities
- CyberScoop, on the delayed disclosure of the Citrix zero-days: https://cyberscoop.com/citrix-zero-days-delayed-disclosure/
- Jan Guldentops, "Zonlicht is het beste ontsmettingsmiddel" (LinkedIn): https://www.linkedin.com/posts/janguldentops_zonlicht-is-het-beste-ontsmettingsmiddel-share-7510559482754547713-vWLP/