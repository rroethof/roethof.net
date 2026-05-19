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

On 12 May 2026, BNR reported that Stichting 113 Zelfmoordpreventie forwarded visitor data to Google and Microsoft for years. No valid consent. A Hackedemia analysis showed Microsoft Clarity still running after a user explicitly refused tracking. That last part matters. Not before consent. After refusal. At that point you’re not looking at a privacy oversight. The system simply does something different from what it claims to do.

## Where it actually fails

Consent is not a banner, it is a runtime condition. Either tracking stops after refusal or it does not. If Clarity still fires, something in that chain is broken. The consent state is ignored or never actually controls execution. Both point to the same thing: nobody verified behaviour in a real session. Not in a browser, not on network level, not after deployment. If someone had, this would have shown up immediately.

## What a DPIA would have caught

People point at DPIAs as if they solve this. They don’t, unless they are tied to reality. If you assess tools like Analytics or Clarity and never check what they actually do in your environment, you’re documenting intent, not behaviour. Either the analysis missed that tracking continues after refusal, or nobody looked at that layer at all. Both happen more often than anyone admits.

## Privacy by declaration

This pattern is everywhere. A privacy statement, a consent banner, language about improving the service. Everything needed to explain compliance is present. What’s missing is verification. Privacy statements don’t enforce anything. Consent flows don’t enforce anything unless they are wired into execution and tested under real conditions. If that link is weak, the system behaves differently from what is documented. That is exactly what happened here.

## The standard stack problem

Nothing here is exotic. A CMS, a tag manager, a few external scripts layered on top. Each component works individually. The combination is rarely tested end to end. Timing differences, fallback behaviour, scripts firing earlier than expected. That’s where issues live. Not in obvious misconfigurations, but in interactions nobody checks. The result is a system that looks fine on paper and behaves differently in production.

## Why this keeps happening

Because the decision is framed as “we want better insight”. So analytics gets added. Then something else. Nothing gets removed because nothing looks broken. And nobody owns runtime behaviour as a whole. Until someone external tests it.

## What makes this different

For most sites this is just bad practice. Here it isn’t. People use 113 assuming anonymity, not as a preference but as a condition. The system doesn’t know that. It just runs the scripts it was given. Once requests leave the browser towards third parties, control is gone. You don’t know what is stored, how long, or what happens next. That uncertainty is exactly what these users try to avoid.

## Not an incident

This will be treated as something that went wrong and has now been fixed. Technically, nothing unusual happened. This is what you get when you run a standard analytics stack and assume the consent layer works because it exists. 113 didn’t behave unexpectedly. It behaved exactly the way it was configured.