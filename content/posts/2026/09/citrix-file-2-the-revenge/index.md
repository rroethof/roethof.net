---
title: "Citrix-file 2: The Revenge?"
slug: citrix-file-2-the-revenge
date: 2026-09-28
lastmod: 2026-09-28
draft: false
author: "Ronny Roethof"
cover: posts/2026/09/citrix-file-2-the-revenge/cover.jpg
summary: "Two NetScaler zero-days have Dutch hospitals and government taking their remote access offline, six years after the first Citrix-file. The patch is the easy part. The real question is why one appliance can hurt this much."
description: "CVE-2026-88771 and CVE-2026-88772 are being exploited in Citrix NetScaler. A look at what happened, why patching is not enough, and what the second Citrix-file says about single points of failure."
categories:
  - security-privacy
  - digital-sovereignty
tags:
  - citrix
  - netscaler
  - cve-2026-88771
  - remote-access
  - vendor-lock-in
---

# Citrix-file 2: The Revenge?

*Six years after the first Citrix-file, we are closing the same front door again.*

Sometimes history has a sense of timing. In early 2020 a vulnerability in Citrix NetScaler gave the Netherlands a new word: the Citrix-file. In Dutch, a *file* is a traffic jam, and that is exactly what it became. Organisations shut down their Citrix environments, and people who normally worked from home had to travel to the office, straight into the morning rush hour. It was not only an IT problem. It became a societal one, with more cars on the road, more pressure on office space, and a lot of organisations discovering how much they depended on a single digital front door.

Six years later we are in a similar situation.

## Eight vulnerabilities, two zero-days

On Sunday Citrix published a [security bulletin](https://support.citrix.com/external/article/CTX697096/citrix-netscaler-adc-and-citrix-netscale.html) covering eight vulnerabilities in NetScaler ADC and NetScaler Gateway. Two of them are critical, and both were exploited before a fix existed. CVE-2026-88771 is the one that matters most. It can be abused remotely, without authentication, on every deployment in its default configuration, and it allows an attacker to execute commands on the appliance. CVE-2026-88772 is a memory overflow that can lead to code execution or a crash. It requires DTLS to be enabled, which it is by default on VPN virtual servers.

The Dutch [NCSC advises](https://www.ncsc.nl/alerts/kwetsbaarheden-in-citrix-netscaler-adc-en-netscaler-gateway-update-nu) installing the updates as soon as possible (the full list of CVEs is in the [NCSC advisory](https://advisories.ncsc.nl/2026/ncsc-2026-0394.html)). It also asks organisations to secure a memory dump and at least one month of logs before patching, and to keep monitoring the appliance afterwards. That advice is worth reading twice. A patch tells you the hole is closed. It does not tell you whether someone walked through it yesterday.

## The front door

NetScaler Gateway is not a random application server. For many organisations it is the way employees reach their work environment from the outside, and that is exactly where the problem sits. If you can no longer trust the front door, you cannot simply switch it off and carry on, because thousands of people are behind it trying to do their jobs.

[Several Dutch hospitals](https://www.bnr.nl/nieuws/nieuws-politiek/10611179/ziekenhuizen-halen-systemen-offline-na-waarschuwing-voor-nieuwe-kritieke-kwetsbaarheden) took their vulnerable systems offline as a precaution, which [left patients unable to reach their records](https://tweakers.net/nieuws/252664/patienten-kunnen-niet-bij-ziekenhuisdossiers-vanwege-citrix-kwetsbaarheden.html). The hospitals were clear that this was not a hack, and that is precisely the point: taking the door away was the rational decision, and it still disrupted care. The [national government also took systems offline](https://www.techzine.eu/news/security/144591/new-citrix-vulnerability-affects-hospitals-and-government/). A CVE turned into an availability problem, and then into a continuity problem.

This morning I sent a former colleague a message asking whether he had suffered from the Citrix-file today. His answer was "Definitely", followed by the observation that even internally things were barely working. That proves nothing about the state of the country, but it illustrates the problem well. For the security team NetScaler is an appliance, for the administrator it is infrastructure, and for the user it either works or it does not.

## What did we learn?

That is the part of this story I find most interesting. Not the CVSS score, and not even the exploit, but what we took from 2020. We saw then what happens when a central access facility disappears. Six years later organisations are again closing their digital front door because the door itself has become the risk.

The lesson of 2020 apparently was not to make sure we can carry on without this door. Too often it seems to have been to make the door even more important. That is an architecture choice.

## This is not an open source argument

Before anyone concludes that I want everybody to replace Citrix with an open source alternative: no. Open source is not a magic security layer. It has vulnerabilities, it can be misconfigured, and it can fail too.

My concern is dependency. When everyone uses the same supplier, the same product and the same architecture, we create one enormous shared failure domain. One product, one vulnerability, one exploit, and suddenly a large number of organisations have the same problem on the same weekend. That is not an argument against commercial software. It is an argument against blind trust in a single component, and against having the front door of Dutch healthcare and government rest on one American vendor's product.

## Operational lock-in

Vendor lock-in is usually discussed in terms of cost and migration. Can we leave, what would it cost, how long would it take, and who would we move to? There is another form that gets less attention: operational lock-in. Technically you might be able to switch, but your organisation has become so dependent on one product that switching it off is practically impossible.

A system you cannot do without is part of your business continuity, and it has to be designed as such. That becomes harder when the same component handles authentication, external access, VPN, application delivery and access to a large part of the internal infrastructure. A vulnerability in that one component is then automatically a problem for the whole organisation, and the bigger the failure domain, the bigger the impact when it goes wrong.

## Patching is necessary, not sufficient

Of course vulnerable NetScalers must be patched. Of course logs must be examined, indicators of compromise checked, and credentials and secrets rotated where there is reason to. None of that is up for debate.

But after the incident comes the question organisations prefer to skip. Not "why did the patch procedure fail?", but "why could one component hit such a large part of our organisation?" That one hurts, because there is often no technical quick fix. Sometimes the honest answer is that the architecture needs another look.

## Design for the outage

Security is not only about preventing mistakes. It is also about learning from the ones already made. So ask what happens if this appliance has to be switched off completely tomorrow. Can people still work? Can administrators still reach the infrastructure? Can critical processes continue, and is there an alternative access route? How long can we stay operational?

If the answer to those questions is no, then we may not have a patching problem. We have an architecture problem.

## Citrix-file 2

Perhaps the impact will turn out to be limited. Perhaps most organisations were quick enough and most systems were not compromised. That would be good news. But the warning is there, the exploits are there, and so are the first operational consequences. That is why I find "Citrix-file 2" a fitting name. Not because Citrix is bad by definition, and not because open source is automatically better, but because a large part of our digital economy and government again depends on the same front door.

The real lesson should not be "patch faster". It should be to make sure your organisation stays standing when this component is gone tomorrow. A mature infrastructure is not one where everything works as long as everything works. It keeps functioning when a critical component fails.

The Dutch have a saying that a donkey does not hit the same stone twice. If we still have not learned that after 2020, we may be the donkey. Let us at least remember, this time, what we ran into.

## Sources

* NCSC-NL, [Kwetsbaarheden in Citrix NetScaler ADC en NetScaler Gateway: update nu](https://www.ncsc.nl/alerts/kwetsbaarheden-in-citrix-netscaler-adc-en-netscaler-gateway-update-nu)
* NCSC-NL, [Advisory NCSC-2026-0394](https://advisories.ncsc.nl/2026/ncsc-2026-0394.html)
* Citrix, [Security bulletin CTX697096](https://support.citrix.com/external/article/CTX697096/citrix-netscaler-adc-and-citrix-netscale.html)
* Tweakers, [Patiënten kunnen niet bij ziekenhuisdossiers vanwege Citrix-kwetsbaarheden](https://tweakers.net/nieuws/252664/patienten-kunnen-niet-bij-ziekenhuisdossiers-vanwege-citrix-kwetsbaarheden.html)
* BNR, [Ziekenhuizen halen systemen offline, na waarschuwing voor nieuwe kritieke kwetsbaarheden](https://www.bnr.nl/nieuws/nieuws-politiek/10611179/ziekenhuizen-halen-systemen-offline-na-waarschuwing-voor-nieuwe-kritieke-kwetsbaarheden)
* Techzine, [New Citrix vulnerability affects hospitals and government](https://www.techzine.eu/news/security/144591/new-citrix-vulnerability-affects-hospitals-and-government/)