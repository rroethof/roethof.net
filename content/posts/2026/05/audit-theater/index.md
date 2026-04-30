---
title: "Audit Theater: Compliance Without Control"
slug: audit-theater
date: 2026-05-01
lastmod: 2026-05-01
draft: false
author: "Ronny Roethof"
categories:
- security-privacy
- career-sysadmin
tags:
- iso27001
- nis2
- continuous-monitoring
- isms
- governance
summary: "The audit passed. The certificate is on the wall. And your security posture is still held together with duct tape and good intentions."
description: "On the gap between ISO 27001 compliance and actual security and what happens when management treats the Security Officer role as optional overhead."
---

[Edwin Ribbers](https://www.linkedin.com/in/edwinribbers/) published a piece on LinkedIn last week that I recognised from the first sentence. His core argument: an ISO 27001 certificate proves you know the rules of the game, not that you are actually playing it. He is right. But he writes for the boardroom. I write from the engine room, because that is where you see the difference most clearly.

---

## The three weeks before the audit

You know the pattern. Eleven months the infrastructure just runs. Patches get rolled out, backups run, Zabbix throws alerts nobody acts on, because thresholds are too high and "we will fix that later." No malicious intent. It is just what happens when security is a department instead of a discipline.

Then the auditor calls.

Suddenly there is time. Suddenly log files get reviewed. Suddenly it turns out the Q3 risk meeting was never documented, even though you know the conversation happened, somewhere in a Teams chat nobody archived. Evidence is not collected. It is reconstructed.

The auditor comes. Checks the boxes. Everyone breathes out.

That is not security. That is deadline-driven paperwork.

---

## The filing cabinet is not a metaphor

Edwin uses the filing cabinet as a metaphor. In my experience it is just literally true. A folder on SharePoint, or sometimes an actual folder in a drawer. "Audit 2024." "Audit 2025." A fresh one every year, the same ritual every year.

The problem is not the systems. The systems do their job. Zabbix monitors. The SIEM logs. The vulnerability scanner reports. But if nobody looks at that output on an ordinary Tuesday morning in November, you do not have continuous monitoring. You have expensive tooling that produces one screenshot per year for the auditor.

ISO 27001:2022 Annex 9.1 is clear on this: the effectiveness of controls must be monitored and measured continuously. Not annually. Continuously. But the practical interpretation is consistent: "we documented the process" counts as compliance. Whether you actually live the process is a different question.

---

## What happens when you pull the role

I know an organisation, not large, not small, that was ISO 27001 certified and intended to stay that way. There was a Security Officer. The SO knew the ISMS, managed the documentation, followed up on non-conformities from the external audit. The system worked, not perfectly, but it worked.

Then came a migration. Reorganisation, new structure, new reporting lines. In the chaos the SO role was revoked. Access rights removed. Not because anyone decided security mattered less, nobody said that out loud, but because it simply did not get sorted in the noise. The role ended up in the bottom drawer, together with the two open non-conformities from the last external audit.

Months later: internal audit.

The opening page of the audit report contained five fundamental questions. Four of them scored "no."

- Is the system effectively implemented and maintained? **No.**
- Do documented procedures match actual practice? **No.**
- Is everyone aware of the procedure content? **No.**
- Does execution conform to the standard? **No.**

The systems were running. Nobody had switched anything off. The infrastructure was fine. What failed was everything around it.

---

Digging deeper, the picture got worse. No information security objectives had been set for the year. No plan with concrete actions existed. The risk assessment had been reduced to a threat analysis, the full risk treatment required by ISO 27001 sections 6.1.2, 6.1.3 and 8.2 was simply missing. Findings from a previous external audit had not been picked up. Multiple versions of the same policy documents existed side by side, inconsistent with each other, nobody quite sure which one was current.

And then the detail that stopped me: the SO role had been reassigned on paper, but the access rights that came with it had not been restored. Which meant the Security Officer could not demonstrably show what they had done in the systems that mattered. The role existed. The accountability existed. The ability to exercise either did not.

The SO is not a cost centre. The SO is the reason the certificate means anything.

The auditor noted it plainly: the ambiguity in role fulfillment and responsibilities had directly caused the open non-conformities to go unaddressed. The recommendation was equally plain: restore the SO role properly, with full rights and make it work. Not as a paper exercise. As a function.

Then came the management response.

"We could bring in an external consultant for two or three months. Clean everything up. Maybe fifteen thousand euros, done."

The engineers in the room had one question: "And then what? Who keeps the systems running after that? Who monitors it day to day? Who picks it up when something actually goes wrong?"

Silence.

That exchange tells you everything about how some organisations think about security. The consultant is a project. A project has an end date. Security does not.

A consultant delivers documentation. They do not leave behind awareness, hands-on knowledge, or the institutional reflex to handle the next incident correctly. On the day they walk out the door, the organisation is formally compliant and operationally blind.

Security fails in the gaps between governance, operations and ownership. This is what that looks like in practice.

It was not just the attention that disappeared. The role disappeared. The rights disappeared. The ownership disappeared. And the bill landed on the next auditor's table, in full.

Tooling is necessary. Processes make it repeatable. Ownership makes it work. But without someone carrying that ownership every day, not once a year and with the actual rights to do so, you just have a more expensive filing cabinet.

---

## NIS2 is going to break this open

Edwin is careful about the Dutch Cybersecurity Act. I am not.

Organisations still playing audit theater right now are going to feel it. The NIS2 duty of care is not a checkbox. The regulator is not coming to see whether you wrote a nice policy document. They are coming to see whether your daily operation demonstrably works. The word is *demonstrably*. Not retrospectively. At the moment of supervision.

If your answer at that point is "the backups run but we do not actively test them," and your RTO is four hours, you have a problem that your certificate does not solve.

This is not theory. I see it weekly in the environments I work in. Awareness is growing, but the reflex to treat security as an annual project runs deep. That reflex is cheaper in the short term. Until it is not.

---

## Continuous monitoring is not a product

One misconception worth killing directly: continuous monitoring is not something you buy.

You can procure a SIEM, deploy an EDR, license a vulnerability management platform and still have zero meaningful resilience if there is no culture of looking daily, following up actively and holding yourself accountable for findings rather than the auditor.

The question Edwin puts to management is the right one: not "do we have the certificate yet?" but "what does our dashboard tell us today?" I will add one for the engineers in the room:

*If I open your SIEM tomorrow, what will I see? And who looked at it yesterday?*

If the answer to that second question is "nobody," you know what needs fixing. Not for the auditor. For yourself.

---

## Read Edwin's piece

This post is largely a response to an article by [Edwin Ribbers](https://www.linkedin.com/in/edwinribbers/), IT/OT Security Consultant, published on LinkedIn on 29 April 2026. His angle is the governance side: how do you bring leadership along in a shift from point-in-time compliance to continuous monitoring. Worth reading, especially if you are having those conversations with management.

My angle is the other side of the table. The engineers who run the tooling and know what is actually in it.

The certificate on the wall proves you know the rules. A dashboard running 24/7 proves you are actually playing the game.

But only if someone checked it today.