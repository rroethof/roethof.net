---
title: "113 Was Not Hacked. It Just Never Checked."
slug: "113-privacy-tracking-microsoft-clarity"
date: "2026-05-18"
lastmod: "2026-05-18"
draft: false
author: "Ronny Roethof"

categories:
- digital-sovereignty
- cybersecurity

tags:
- privacy
- gdpr
- healthcare
- tracking
- data-protection
---

On 12 May 2026, BNR reported that Stichting 113 Zelfmoordpreventie forwarded visitor data to Google and Microsoft for years. No valid consent. A Hackedemia analysis showed Microsoft Clarity still running after a user explicitly refused tracking. Not before consent, after refusal. At that point you are not looking at a privacy oversight. The system does something different from what it claims.

## Where it actually fails

Consent is not a banner, it is a runtime condition. Either tracking stops or it does not. If Clarity still fires, the chain is broken. Consent is ignored or never wired into execution. This takes five minutes to check. Open devtools, reject consent, watch the requests. Basic work. Someone could have done this on the day it was built. Someone could have done it any time after.

They did not.

Or they did, saw it, and decided it was not a problem.

## What a DPIA would have meant

People will point at DPIAs now. Files, approvals, checklists. None of that matters if nobody ties it back to runtime behaviour. If your assessment says tracking is controlled, and a simple browser session proves it is not, the assessment is fiction.

So what happened here is not subtle. Either the DPIA never touched the actual system, or it did and someone signed off on it anyway. Both options mean the same thing. The paper mattered more than the system.

## Privacy by declaration

This is the part everyone recognises. Privacy statement, consent banner, careful wording about improving services. Everything looks correct on the surface. Meanwhile the implementation does something else.

And people accept that gap.

Developers ship it. Security signs off. Management looks at the dashboard and moves on. Nobody in that chain stops and says "this does not do what we tell users it does", or they say it and get ignored.

## The stack did not drift by itself

Nothing magical happened here. A CMS, a tag manager, third party scripts. Someone added them. Someone configured them. Someone kept them in place after every update, every change, every discussion about privacy risk.

This is not entropy. This is maintenance.

People made choices, repeatedly, and each time chose not to fix it.

## Why it stayed

Because nothing broke that management cares about. Metrics still came in. Reports still worked. No alarms, no incident, no external pressure. So the easiest decision is to do nothing and let it run.

Until someone outside tests it and writes it down.

## What makes this worse

For a webshop this is sloppy.

Here it means something else. The people who visit 113 at two in the morning are not casual users. They have already negotiated with themselves about whether it is safe to reach out. They clear their history. They use private browsing. They think about whether anyone will know.

The tracker does not know any of that. It fires anyway.

That assumption of anonymity was wrong. Not because of a sophisticated attack. Because the people building and operating this platform never treated it as something that required verification at that level. The users assumed someone had checked. Nobody had.

## Not an incident

This will be framed as a mistake. Tools removed, investigation started, lessons learned. A report will be produced. It will be written carefully, in the passive voice, and it will not name anyone. The people who added these scripts, who signed off on DPIAs without verifying the implementation, who renewed vendor contracts year after year while the AP was publishing guidance that made those contracts untenable on a platform like this, none of them will appear in that report by name. Some of them will help write the recommendations.

That is how this always works. And I am done pretending it is acceptable.

These are not anonymous systemic failures. Somebody added Clarity to this platform. Somebody approved the privacy documentation without verifying the implementation. Somebody decided, repeatedly, that the question of whether the consent mechanism actually worked was not worth answering.

Those people know who they are. The investigation will let them stay anonymous. The rest of us are left with the knowledge that somewhere in the Netherlands, people in crisis reached out for help on a platform that was quietly watching them do it, and nobody responsible for that platform thought it was important enough to check.

That is not a mistake.

That is a choice someone kept making.
