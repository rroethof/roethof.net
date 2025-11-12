---
title: "NCSC's Late-Stage Panic: BYOD Is Risky? No Shit."
date: 2025-05-28
draft: false
slug: "ncsc-byod-late-panic-rant"
description: "The Dutch NCSC finally discovered that BYOD and session cookies are a risk. Meanwhile, actual IT professionals have been dealing with this for over a decade. Here's a dose of reality, unfiltered."
categories: ["Security", "Rant"]
tags: ["BYOD", "Session Cookies", "Security Theatre", "Endpoint Security", "Policy Failures", "Zero Trust"]
---

Let me set the scene: The Dutch NCSC just dropped an “urgent” advisory about the horrifying risk of letting people access company resources on their own devices ,  you know, **BYOD**. And the terrifying threat they’ve identified? Wait for it...
([NCSC adviseert tegen Bring-Your-Own-Device, voor beheer van sessiecookies](https://www.security.nl/posting/889778/NCSC+adviseert+tegen+Bring-Your-Own-Device%2C+voor+beheer+van+sessiecookies))

**Session. Fucking. Cookies.**

Welcome to cybersecurity, circa 2006.

## Bureaucrats Discover Fire, Call Press Conference

Apparently, using your own phone or laptop, the one you also use for doomscrolling, torrenting obscure anime, and paying bills, **might** have security implications when it’s also used to access corporate systems. Wow. Groundbreaking stuff. Someone alert DARPA.
The real kicker? Their "mitigations" are a highlight reel of useless bullshit that completely ignores how actual IT operates. Spoiler alert: none of it tackles the real threats. Instead, it all shoves responsibility back onto end-users, just so management can pat themselves on the back for "doing something."

## BYOD: Not The Enemy ,  Unless You’re Clueless

Let's be clear: **BYOD isn’t the enemy.** Stupid, inflexible and frankly, insulting policies are. There's a Grand Canyon of difference between giving some clueless intern full, unrestricted network access on their malware-infested Windows laptop, and allowing seasoned sysadmins, SREs, security engineers, and developers the goddamn flexibility to use their own meticulously maintained, often far superior, equipment.

You know, **the people who understand how Linux works**, how to manage SSH keys, how to firewall, monitor, sandbox, and harden their systems. Hell, most of us run better security at home than many orgs do in production.

And don’t even get me started on the **BSD crowd**, those people would rather pour bleach in their eyes than let an unsigned binary touch their disk. They live for paranoia. You want to ban *them* from managing their own hardware because Karen in Finance might click on a phishing link? Get fucked.

This whole "user is the weakest link" dogma is convenient for selling more restrictive tools, but it’s fundamentally flawed. Remember my old Director? Not tech-savvy, but teach him one simple, effective step – forward suspicious emails *as attachments* – and he became an active part of the defense. He wasn't a liability; he was empowered ([More on that here](https://roethof.net/posts/2025/04/human-factor-liability-or-asset/)). Are we really going to ignore that potential just to push more top-down, one-size-fits-all bullshit?

## Cookie Hysteria: While the Real House Burns

Let’s talk about cookies. Yes, session cookies can be compromised. Yes, they can persist across tabs and devices. But if your entire security model collapses because a session token gets jacked, **you’ve already failed**.

Where’s the outrage over:
- OAuth token reuse?
- Browser-in-the-Middle (BiTM) attacks?
- Malicious browser extensions stealing everything in plain sight?
- Endpoints compromised by off-the-shelf info stealers?

But no, let’s all lose our minds over cookies. Because those are easy targets for angry, pointless bulletins.

## Reality Check: IT Departments Already Know This

We – the people actually doing the work – have been building compensating controls for this shit for years. MFA, idle timeouts, short-lived tokens, device attestation, IP range restrictions, behavior-based analytics, proper network segmentation... you name it, we've probably implemented it, or at least argued for the budget to do so. **This isn't news. This is table stakes for any competent IT department.**

But hey, it’s far easier for bureaucrats to wag their fingers at sysadmins using their personal XPS's or meticulously configured Thinkbooks than it is for organizations to actually invest in infrastructure that doesn’t implode the second someone forgets to click "logout" or uses a browser that's five minutes out of date.

And don’t even get me started on the “just enforce MDM” fantasy on personal devices. What part of **Bring Your OWN Device** do these people not understand? Nobody in their right mind, especially not technically proficient staff, wants corporate spyware infesting their devices, whether personal or company-issued. We know *exactly* what kind of intrusive shit those MDM agents can see and do, and the answer is "too fucking much." It's a one-way ticket to employee frustration and a hunt for workarounds, which, paradoxically, often creates *more* security holes than the "risk" they were trying to mitigate. This isn't security; it's an exercise in alienating your most capable people.

It's a fucking joke, really. Even when they *do* shove a company laptop down your throat, the approach is often just as idiotic. Instead of a sane policy acknowledging that, yes, humans might occasionally check personal email on a work device, and building a security model around *that* reality – a concept I’ve screamed into the void about before ([Company Laptops & Personal Use: Finding the Security Balance](/posts/2025/03/company-laptops-personal-use-security-balance/)) – they just double down on the lockdown. It’s the same distrust, the same control-freakery, just on hardware they paid for. So, this NCSC pearl of wisdom about BYOD? It’s just another symptom of the same disease: a fundamental inability to treat technical professionals like adults.

## "Just Ban BYOD" – A Fantasy for Control Freaks

So, the NCSC's brilliant "solution" is to just ban BYOD? Force everyone onto corporate-issued shackles? Go right ahead. Then sit back and enjoy the show as morale disintegrates, attrition rates skyrocket, and your most skilled engineers – the ones who actually build and fix your broken shit – stampede for the fucking exit.

And don't think for a second that forcing us onto your "approved" hardware is any better if it comes with the same iron fist of control. This isn't theoretical whining; I've lived this nightmare, and heard the same damn horror stories from countless peers. A company, high on its own "security enhancement" fumes, rolls out shiny new locked-down laptops. Suddenly, the very engineers once trusted with the keys to the kingdom – direct production access, sensitive client data, the whole nine yards – are reduced to begging like children for basic admin rights just to update a development tool or configure a goddamn VM.

Worse, these corporate "gifts" often come pre-infested with 'endpoint detection and response' (EDR) software that should be renamed 'Employee Distrust and Resentment' (EDR) software. Typically undisclosed, utterly unconfigurable, and constantly snitching back to Big Brother, it leaves your staff feeling perpetually spied on, deeply uneasy, and longing for the days when they weren't treated like potential criminals in their own digital workspace. This isn't a minor inconvenience; it's a direct assault on morale. The unspoken, yet deafening, message? "We trust you with our multi-million dollar systems, but not with the laptop you use to access them." The inevitable result? Trust is annihilated. Resentment festers. And these so-called "security enhancements" become the single biggest roadblock to getting any actual work done, breeding a deep, burning contempt for corporate IT "security" theatre.

Most of us – the techies in your midst – don’t want your locked-down, corporate-imaged machines, even if they come with a modern processor and a decent amount of RAM. If we can't configure our own shit, install the tools we actually need, or escape your mandated, bloated OS build, it's still a gilded cage that stifles productivity and treats us like we don't know how to manage a system. And they *are* walking. I've seen it: skilled engineers, tired of being infantilized and hamstrung by policies that hinder more than they help, are leaving in droves. Competitors who value talent and offer sensible, flexible working conditions are welcoming them with open arms and, crucially, more open policies.

We want hardware we control. We want tools that *actually* work. We demand the freedom to configure our environments the way we need to ,  because, newsflash, **that’s how we keep your goddamn systems running.**

You think shackling a senior engineer's machine makes you secure? Think again. It just makes your most valuable technical staff despise you and view "security" as the enemy – a bureaucratic boot stamping on their neck. And trust me, they *will* find a dozen ingenious ways to slip those chains and bypass your idiotic, counterproductive policies just to do their fucking jobs. That "shadow IT" you're so terrified of? You're practically breeding it with every new layer of restrictive, poorly understood and insulting security crap you roll out. This is the beautiful paradox of your control-freak security: the tighter you try to pull the chains, the more creative (and often, hilariously, less secure in the grand scheme) the escape routes become.

## Build Real Defenses or GTFO

If your risk model depends entirely on trust boundaries that crumble the second someone closes a browser tab the wrong way, **you don’t have a security model, you have hope and duct tape**.

Want to actually do security right for a change?

- Implement real Zero Trust, not just a slide deck.
- Authenticate at the data and app level, not the device.
- Stop treating your sysadmins and other technical staff like untrustworthy children. They are your first, and often best, line of defense if you'd just fucking listen to them and give them the tools and autonomy they need.
- Segment access based on roles and context, not hardware ownership.
- Build resilience, not rigidity.

## Final Word

The NCSC’s “advisory” is late, timid, and utterly disconnected from the operational realities of modern IT and the actual capabilities of technical professionals. BYOD isn’t going away, and for many of us, it damn well shouldn't. For technical users, having control over our tools and environment isn't some cushy luxury; it’s often **a bare-knuckle necessity** for peak performance and, yes, even for implementing robust personal security that frequently puts corporate mandates to shame. We’re not the problem here. We’re the ones keeping your lights on, often in spite of policies that seem deliberately designed to make our lives a living hell.

So before you start waving policy papers around like holy scripture, ask yourself this:

**Are you protecting your data, or just creating the illusion of control?**

If your answer is the latter, then congratulations ,  you’ve successfully turned security into a pathetic stage play. Now please, for the love of God, step aside and let the actual professionals work.
