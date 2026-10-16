---
title: 'The ISO 27001 Hallucination: Documenting Your Way to Disaster'
slug: iso-27001-compliance-illusion-resilience-failure
date: 2026-03-09
author: Ronny Roethof
draft: false
categories:
- security-privacy
tags:
- iso-27001
- nis2
- anylinq
- enterprise-failure
- resilience
summary: ISO 27001 documentation can give a false sense of security, leading to compliance
  illusions and enterprise risk.
description: ISO 27001 documentation can give a false sense of security. Learn why
  compliance paperwork alone doesn’t guarantee enterprise resilience.
---

## Trigger: How This Post Started

This article was triggered by a post from my friend and former colleague Edwin Ribbers. He wrote about how much of today’s risk management is treated as a checkbox exercise in Excel, designed to satisfy auditors rather than strengthen real operational resilience. His insights on the limits of abstract scoring and the importance of practical, scenario-driven thinking inspired me to write this piece. You can read his post here: [linkedin.com](https://www.linkedin.com/pulse/risicomanagement-van-een-excel-invuloefening-naar-edwin-ribbers-cr2me/)

## The Auditor’s Absurdity

A few years ago I sat across from an ISO 27001 auditor. I watched him flip through a stack of risk assessments, rows of Excel cells filled with abstract numbers and mitigation strategies. Everyone in the room knew the numbers were fiction.

Then he said something that left me flabbergasted. He explained that under the ISO 27001 framework, you do not actually have to solve a risk. You just have to prove you thought about it. He literally said: "As long as you document that you choose to do nothing and provide a reason, you satisfy the norm. You made a conscious business decision. That is a pass."

In that moment the curtain was pulled back. I realized that information security compliance exists to satisfy auditors, not to keep systems running. It is a paper shield in a world of digital sledgehammers.

## The Conscious Decision to Fail

That logic is the terminal illness of the modern enterprise. It creates a culture where a management sign-off is treated as a substitute for technical resilience.

Throughout my career, from my time at AnyLinQ to various enterprise detachments and projects at the RIVM, I have seen this repeatedly. A CISO identifies a critical vulnerability in a legacy system. The budget is tight. They simply document the "Risk Acceptance." The box is checked. The auditor is satisfied. The certificate stays on the wall.

A ransomware actor does not care about your documented risk acceptance. They do not care that a Vice President signed a PDF stating the legacy database was too expensive to patch. We have traded security for traceability. We replaced the hard work of hardening infrastructure with the bureaucratic exercise of explaining why we didn't.

## The Excel Spreadsheet: A CISO’s Favorite Fiction

Most risk management today is a "moetje" for the auditor. We use standard spreadsheets. We score probability and impact on a scale of 1 to 5. We pretend we did something meaningful.

It is a hallucination.

* Impact is never static. A "3" becomes a "5" the moment a critical national system or an essential public service fails under pressure.
* Probability is a guess. We treat 500-year floods and daily phishing attempts with the same mathematical coldness.
* The Spreadsheet is blind. It does not show the eighty-hour workweeks, the internal sabotage, or the fact that alerts are being ignored because the staff is drowning in operational neglect.

A spreadsheet has never stopped an attack. It only provides a legal trail to blame someone else after the lights go out.

## The Resilience Paradox

We talk about resilience as if it is a buzzword we can buy. It is not. Real resilience is the ability to actually recover when the world is on fire.

ISO 27001 was never meant to guarantee security; it was meant to guarantee governance. Somewhere along the way, organizations started confusing the two. In the trenches of managed services and high-pressure environments, I have seen that foundation built on **quicksand**.

You can claim a 4-hour Recovery Time Objective (RTO) in your Business Continuity Plan. You can print it on glossy paper. But if you have not tested that recovery in a high-stress scenario with an exhausted team, your RTO is a lie. Most enterprises do not have resilience. They have documented hope. They hope the SaaS provider does not go dark. They hope yesterday's ignored reports do not explode today.

## Enter NIS2: The End of the "We Didn't Know" Defense

The days of hiding behind a framed ISO certificate are ending. The NIS2 directive is a direct response to the failure of voluntary compliance. It introduces a hard Duty of Care and personal liability for board members.

Under NIS2, "we chose to do nothing because it was documented" will no longer hold up in court.

The law now demands supply-chain accountability. You can secure your own server room until it is a fortress. But if your core business process relies on a third-party vendor with zero security maturity, you are failing. NIS2 forces us to look at the supply chain blind spot. In the past, we asked vendors for a copy of their ISO certificate. We did not ask about their staff turnover. We did not ask if their engineers were working fifteen hours of overtime a day.

## The Human Cost of Compliance

As a CISO and a team lead, I have seen the toll this takes on the people actually doing the work. The board celebrates a successful audit while technical teams deal with the fallout of "Risk Acceptance" decisions.

High workloads and chronic overwork are the real risks. You will not find them in an ISO 27005 risk assessment. "The only sysadmin who knows the system is on his 7th burnout" does not look good in an Excel cell. Yet that is the reality of enterprise IT. We prioritize the "Vinkje" over the person, and then we wonder why the system collapses when the storm hits.

## Moving from Vinkjes to Verzet

We need to stop being audit-compliant and start being attack-resilient. This requires brutal honesty that most enterprise environments are designed to suppress.

* Stop the abstract scoring. Stop saying "Probability 2." Start saying "We have no idea if the backups work because we haven't tested them since 2019."
* Use scenario-based thinking. Ask the uncomfortable questions. What happens if our primary cloud provider is offline for 48 hours? Not "What is the risk score?", but "What do we literally do on hour 4?"
* Validate the supply chain. Stop accepting certificates as proof of security. Start asking for evidence of scenario testing and RTO validation.
* Acknowledge technical debt. Every documented decision to do nothing is a loan with a thousand-percent interest rate. Eventually the debt collector will come to collect.

## Conclusion

Risk management is not an administrative burden. It is not an exercise in creative writing for auditors. It is the navigation system of your company.

If your risk register is a document that only the auditor sees, you are not managing risk. You are managing an illusion. The next time an auditor tells you that doing nothing is a valid documented decision, remember this: Compliance can explain a failure. Resilience can survive one. Choose carefully which one your organization is investing in.

The hackers do not care about your documentation. They care about your weaknesses. While you were busy writing a reason for your negligence, they were busy exploiting it.

It is time to stop the vinkjes-cultuur. It is time for a reality check.
