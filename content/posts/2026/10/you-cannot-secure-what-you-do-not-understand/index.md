---
title: "You Cannot Secure What You Do Not Understand"
slug: you-cannot-secure-what-you-do-not-understand
date: 2026-10-22
lastmod: 2026-10-22
draft: false
author: "Ronny Roethof"

categories:
  - security-privacy
  - career-sysadmin

tags:
  - php2shell
  - incident-response
  - vulnerability-management
  - php
  - asset-management

summary: "PHP2Shell showed that a security decision is only as good as the technical understanding behind it."

description: "Why security leadership must rely on the engineers who know the infrastructure, understand its dependencies and can turn risk assessments into effective technical controls."
---

# You Cannot Secure What You Do Not Understand

*PHP2Shell showed that a security decision is only as good as the technical understanding behind it.*

The PHP2Shell incident set off a familiar round of questions. Is our inventory accurate? Are the systems patched? Can we restrict access? Should we take the vulnerable services offline? All reasonable questions, and all of them assume that we understand the environment we are trying to protect.

In my [previous article about PHP2Shell](/posts/2026/10/php2shell-the-warning-was-early-the-response-was-more-complicated/) I described how the incident unfolded and why I kept our monitoring service running while restricting its external access. This follow-up deals with the question that response left me with. How much weight should a security decision carry when the people making it have no clear picture of the technology underneath?

## The inventory is a start

Every serious framework treats asset management as the foundation, and rightly so. You cannot patch what you have not identified, and you cannot judge exposure without knowing which services face the internet. But an inventory records what someone wrote down, which is not always what is actually running.

PHP2Shell illustrates the point well. Both flaws sit in PHP core, so "do we run PHP?" is the wrong question. The useful question is where PHP runs, in which version, behind which interface and who can reach it. PHP hides inside third-party applications, management interfaces, monitoring platforms and vendor appliances. Nobody in your organisation may have written a line of PHP, and you still depend on it. The upstream fixes landed in 8.5.12, 8.4.27, 8.3.36 and 8.2.35, but that is only the start of the answer. Every host on another branch, or on an appliance that bundles its own PHP, needed a separate assessment. Distributions and vendors may backport a fix without changing the upstream version number, so a version string alone does not tell you whether a system is exposed. A spreadsheet rarely holds that answer. The engineers who operate the systems usually do.

## The clock was short

The window between disclosure and abuse was very short. According to [NU.nl](https://www.nu.nl/tech/6413995/miljoenen-misbruikpogingen-na-bekendmaking-php-kwetsbaarheden.html), Cloudflare's CEO reported thousands of exploitation attempts in the ten hours before the public announcement. Within 45 minutes of it the number had risen to tens of thousands, within two hours to hundreds of thousands, and by Wednesday evening to millions. Details of the flaws had leaked on social media, which forced the PHP Foundation to bring its announcement forward.

These figures describe exploitation attempts, not confirmed compromises. They show how quickly attackers respond, not how many systems were successfully breached. The Dutch NCSC [told NU.nl](https://www.nu.nl/tech/6413995/miljoenen-misbruikpogingen-na-bekendmaking-php-kwetsbaarheden.html) that it saw no signs yet that attackers had actually gained access to servers. But a window like this leaves no time to find out which systems you own and what depends on them. Whatever you know on the day the clock starts is what you have.

## Who knows what runs where

Corporate security invests in frameworks, policies, risk registers and dashboards. They serve a purpose: accountability, consistent process and informed decisions about risk. They do not replace technical knowledge. The people who run the infrastructure know how services depend on each other, which interfaces are exposed, what can be isolated and what breaks when a control changes. They can tell a mitigation that works on paper from one that works in this environment.

A CISO does not need to know every server or configuration option. The job is to make sure the right expertise informs the decisions and that the people implementing them have a real voice. When leadership cannot say who holds that knowledge, or involves those people only after the decision has been made, the missing inventory is the smaller problem.

## Offline is a decision

On Wednesday 21 October, ahead of the PHP release scheduled for 16:00 Dutch time, a long list of Dutch organisations took services offline as a precaution. [NU.nl listed](https://www.nu.nl/economie/6413901/deze-nederlandse-websites-waren-offline-vanwege-weerloos-php.html) the Tweede Kamer, MijnOverheid, the DigiD website, several hospitals, grid operators, media sites and the NCSC's own website, among many others. I cannot see from the outside why each organisation chose this, and I will not guess.

The default advice was sound. Both flaws allowed remote code execution, no patch existed yet, and attackers were expected to be ready the moment details dropped. If exposure is unknown, the impact is severe and no effective mitigation can be put in place in time, switching the service off may well be the safest option.

Not everyone made the same call, and the differences are instructive. According to [NU.nl](https://www.nu.nl/economie/6413901/deze-nederlandse-websites-waren-offline-vanwege-weerloos-php.html), Picnic kept its website running because customers cannot order on it, and its ordering app and core systems do not run on PHP. An NS spokesperson told the same outlet that contacts with experts had warned the company early, that its teams stood ready and that the flaws had no impact on its services. I cannot judge whether those assessments were right. What they share is that each rested on knowing what runs where. That knowledge lets an organisation depart from the default for a reason, instead of only following it.

Our own case was similar in kind. Our monitoring service could stay up while its external exposure was reduced. We added access restrictions on top of the existing measures, so the service remained available to a narrower audience. That did not patch PHP and it did not close every attack path, and with millions of attempts in the wild that caveat matters. It bought time while the vulnerability response continued. It was only possible because the engineers knew what the service did, who needed access and what the restrictions would break.

The right call depends on the technology, the exposure, the controls available and the consequences of each option. Those are technical questions with business implications, and they need answers grounded in the actual environment.

## Governance needs engineering

I am not arguing against governance. Policies, risk assessments and accountability matter, especially in a larger organisation. My objection is to letting them stand in for engineering. A risk register can document a vulnerability but cannot tell you whether an undocumented service is exposed. A policy can demand patching but cannot resolve a dependency conflict. A dashboard can report compliance while the inventory behind it is incomplete.

The relationship has to run in both directions. Engineers must explain technical risk in terms the business understands. Security leadership must challenge assumptions, set priorities and make sure risks get addressed. Both sides must be able to question a proposed course of action, which takes trust, and it takes security professionals who recognise the limits of their own technical knowledge. I made the same argument about structure in [The Suit Killed the Operator](/posts/the-suit-killed-the-operator/) and about compliance in [Audit Theater](/posts/audit-theater-compliance-without-control/). This article is the incident response version.

## Let the engineers lead

Security is often treated as something that happens above the infrastructure, through policy and oversight. In practice it is implemented in the infrastructure: in configurations, access controls, patching, segmentation and monitoring. The people who own those decisions should shape the response from the first hour, not receive instructions at the end of it.

Governance provides direction and accountability. Engineers explain the environment, find workable controls and verify what those controls actually achieve. My takeaway from PHP2Shell is that the people who understand the technology should lead the technical response. A good CISO does not have to be the best engineer in the room, but knows when to listen, when to challenge and when to hand over the authority to act.

You cannot secure what you do not understand. And no amount of reporting will replace the people who do.

## Sources

- Ellen Vos, "Deze Nederlandse websites waren offline vanwege weerloos PHP", NU.nl (21 October 2026)
- Linda van Beest, "Miljoenen misbruikpogingen na bekendmaking PHP-kwetsbaarheden", NU.nl (22 October 2026)
- The Hacker News, "PHP2Shell: Two Unpatched Critical PHP RCE Flaws (CVSS 9.2) Trigger Emergency Security Alert" (21 October 2026)
- Qualys Threat Research, "PHP Announces Critical Security Release for Two Vulnerabilities" (20 October 2026)