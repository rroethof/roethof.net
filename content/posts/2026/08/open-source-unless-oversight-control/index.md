---
title: "Open Source, Unless: When Oversight Starts Sounding Like Control"
slug: open-source-unless-oversight-control
date: 2026-08-11
lastmod: 2026-08-11
draft: false
author: "Ronny Roethof"

categories:
- digital-sovereignty
- security-privacy

tags:
- ncsc
- procurement
- vendor-lock-in
- transparency
- oversight

summary: "A response to the NCSC Community piece on 'open source, unless', and why one line about transparency needing a watcher deserves more scrutiny than it got."
description: "Government IT procurement, open source policy, and the line between transparency and oversight, prompted by a NCSC Community discussion on the Dutch 'open source, unless' rule."
---

The Dutch government has run on "open source, unless" for years. Marcel den Hartog wrote a piece for the NCSC Community recently arguing that the "unless" has quietly disappeared from the policy in practice. Choosing open source has become the politically safe default, applied without the serious cost and risk analysis the rule was supposed to require.

He is right about most of it. Licence costs vanish, but support and maintenance do not. Migration costs are real and rarely counted. Open source has its own lock-in when a project depends on one company or one small community that can walk away. All of that holds up.

A former colleague, Chris Dorsman, made a point in a private discussion that I think explains why the "unless" never gets applied in practice. Government does not have the in-house expertise to run a proper assessment on open source in the first place. That is not the same claim as political risk aversion, it sits underneath it. Even a civil servant willing to take the political risk of choosing something other than open source often lacks the technical grounding to build the case. Political safety explains why nobody wants to deviate from the default. Capacity gaps explain why the assessment itself rarely happens even when someone is willing to try. Both keep the "unless" dead on arrival.

But one line in Den Hartog's piece stopped me:

> "Transparency only helps if someone is actually watching and acting on it."

In context, his point is perfectly reasonable. He is talking about security communities failing to catch vulnerabilities such as Log4Shell and Heartbleed for years, despite the code being open for anyone to inspect. But take that sentence outside the immediate security context and you get a much bigger question: **who is that someone?** Because this is where I start to get uncomfortable.

If the answer is "more security professionals", "more independent researchers" or "more people in the community", fine. That is exactly what open source is supposed to enable. But if the answer gradually becomes "a government body", "an appointed supervisor" or "a central authority responsible for determining whether something is sufficiently safe", we have crossed a very different line. That is no longer simply transparency. That is oversight, and oversight has a nasty habit of eventually becoming gatekeeping.

### The government should not become the gatekeeper of openness

The entire point of open source is that there is no single person who gets to decide who may inspect the code. Anyone can look, audit it, fork it, find a vulnerability and publish it, or simply disagree with the people maintaining it. That decentralisation is not a bug in the model, it is one of its greatest strengths.

The moment a government authority becomes the designated watcher, however, you create something fundamentally different: a central point with the authority to decide what is considered safe, what must be reported, what requires remediation and potentially what may be published. Maybe that authority starts with the best intentions, that is almost always how these things start, and that is precisely why I don't trust the model. Not because every civil servant is secretly trying to censor the internet, and not because every security review is a prelude to authoritarianism, but because **power has a tendency to accumulate around whatever mechanism we create to exercise it.**

First it is about security. Then it is about safety. Then it is about societal responsibility. Then it becomes necessary to protect people from misinformation, harmful material, irresponsible software, dangerous communication or whatever the political definition of "harm" happens to be at that moment. The technical mechanism hasn't changed, only the justification has, and suddenly the person who was appointed to watch the code is also in a position to decide what everyone else is allowed to see. That is the part I don't want.

### We have seen this movie before

Look at the European Union. What started as economic cooperation has evolved into an enormous regulatory machine with an ever-expanding reach into areas that were once considered national or individual domains. The problem isn't simply that Brussels makes rules, it is the distance between the people making those rules and the people who have to live with them. Power moves upward, decision-making becomes more centralised, and the justification is invariably reasonable: security, safety, consumer protection, privacy, the environment, harm reduction, digital sovereignty. Because each individual step can be defended on its own merits, nobody notices the direction of travel until the accumulated system has become something entirely different from where it started.

That is why I look at concepts like Chat Control and CBDCs with suspicion as well. Not because I believe every proposal is secretly designed to create a totalitarian state, that would be too easy. The problem is that each proposal creates infrastructure and authority that **can** be used for purposes beyond the original justification. Once the infrastructure exists, the political question is no longer whether it can be used, it is who controls it, what the definition of "necessary" becomes and who gets to decide when the next exception is justified. That is how freedom gets regulated to death, not with one dramatic law announcing the end of democracy, but with a thousand perfectly reasonable measures.

### Open source deserves the opposite

This is why I think the answer to the problems Den Hartog identifies should be almost the opposite of centralised oversight. We need more people looking: more independent researchers, more maintainers, more security professionals, more public scrutiny, more transparency. And yes, government should absolutely participate in that ecosystem, but participation is not ownership. Government should be one of the people looking through the window. It should not become the person standing in front of the window deciding who else is allowed to look.

The same principle applies to procurement. If government wants to know whether open source is the right choice, then perform the damn analysis: calculate the total cost, the migration cost, the support requirements, analyse the community, the security model, the exit strategy. And then do exactly the same thing when the alternative is proprietary software, because proprietary vendors deserve exactly the same scrutiny. The fact that a company sends you an invoice every year does not magically make vendor lock-in disappear. Open source gives you something proprietary software fundamentally does not: the legal and technical possibility to take the code somewhere else. That does not make migration free, it makes migration **possible**, and that distinction matters.

### Transparency doesn't need a gatekeeper

Den Hartog is right that open code nobody ever looks at is not magically secure. But the answer is not to appoint someone who watches on behalf of everyone else, it is to make sure there are enough independent eyes that no single watcher becomes indispensable. Because the moment we decide that transparency needs a gatekeeper, we have already surrendered part of what made transparency valuable in the first place.

**Transparency does not need someone to watch on your behalf. It needs enough people watching that no single one of them gets to decide what the rest of us are allowed to see.**