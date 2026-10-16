---
title: "Security Awareness Doesn't Fail (It Was Never the Fix)"
slug: "security-awareness-doesnt-fail"
date: "2026-05-22"
lastmod: "2026-05-22"
draft: false
author: "Ronny Roethof"
categories:
  - career-sysadmin
  - opinion-reflections
tags:
  - security
  - awareness
  - operational-risk
  - human-factor
  - architecture
description: "Security awareness training assumes that knowledge leads to safer behaviour. In practice, behaviour is shaped by context, incentives and system design."
summary: "A phishing simulation showed that even when people know what to do, there is often no correct decision to make. Organisations respond by managing reactions instead of fixing the conditions that caused the problem."
---

I read a [post](https://www.linkedin.com/pulse/security-awareness-een-managementstoring-stop-met-het-edwin-ribbers-zkhze/) by [Edwin Ribbers](https://www.linkedin.com/in/edwinribbers/) describing security awareness as a management failure.
He is right.
But that is only the surface.

---

## Awareness as a comfortable illusion

Most organisations run security awareness programs.
People watch a video, answer a quiz, and earn a certificate. Dashboards turn green, completion rates go up, and from a reporting perspective everything looks fine.
But from an operational perspective, nothing actually changes.

The underlying assumption is simple: if people know better, they will behave better.
It sounds logical.
It isn't.

## A phishing simulation

We tested it.

The pretext was a Christmas package benefit. Convincing enough, timely enough, and delivered with enough brand polish that it felt entirely plausible. Within thirty seconds, a director had clicked the link. Within forty seconds, a senior network engineer followed. The people the organisation would nominally rely on to model good behaviour.

Meanwhile, the finance team did something different. They stopped. They questioned it. They asked each other whether it was real before doing anything.

That result was not celebrated as a win for the finance team. It was not analysed as evidence that context and peer culture matter more than individual training. It was processed as an incident, because the overall click rate was embarrassing and because the people who were supposed to know better demonstrably did not behave as if they did.

The response from the organisation was not to examine why a well-crafted, well-timed pretext worked so effectively on people who had completed their training modules. The response was to compensate everyone for the discomfort. Six months of supermarket vouchers, roughly 150 euros per month, distributed across the organisation. Not to fix the problem. To settle the reaction.

The security posture was unchanged. The liability had simply been managed.

## The gamification interlude

Before dismissing that example as an outlier, consider what the alternative looks like in practice.

Platforms that gamify security awareness have become popular precisely because they produce metrics that look better. Completion rates climb. Simulated click rates decline over time. Leaderboards and streaks create engagement. From a reporting perspective, the numbers improve.

From an operational perspective, the improvement is largely an artefact of familiarity. People learn to recognise the simulation vendor's templates. They learn which pretexts the platform favours. At one organisation running a gamified awareness platform, a small group of technical staff who had access to the underlying database found themselves occupying the top positions in the leaderboard for several consecutive months. Not because their security behaviour was exemplary, but because they understood the system they were being measured against.

We train people to win the game, not to understand the risk.

The following year, at a different organisation, a nearly identical Christmas package campaign ran under a different name. Everyone who remembered the previous incident treated it with suspicion and did not click. Reported as an improvement. Logged as evidence that awareness training was working.

What had actually happened was that institutional memory had substituted for genuine understanding. The people who did not click that year would have clicked a different pretext, delivered through a different channel, during a period when they were not primed to be cautious. The underlying vulnerability was intact.

## The decision environment nobody designed

This is the part that awareness programs do not address, because addressing it would require organisations to look at themselves rather than at their users.

People make decisions inside a context they did not build. That context includes the tools they are given, the workflows they are expected to follow, the speed at which they are expected to operate, and the social cost of slowing down or pushing back.

When a user receives an email that looks like it might be phishing, the correct action is to verify before acting. In practice, verification means opening a separate channel, finding the right contact, waiting for a response, and potentially delaying something that someone senior is waiting for. In an organisation that treats interruption as inefficiency and caution as obstruction, that cost is not theoretical.

What awareness training communicates, intentionally or not, is that the user bears personal responsibility for a systemic problem. If they click, it is their fault. If they do not click, the system continues exactly as it was, with the same ambiguous emails, the same tooling that cannot reliably distinguish legitimate from malicious, and the same pressure to keep moving.

The training transfers liability. It does not transfer capability.

## What would actually reduce risk

Awareness training is not worthless. People who understand the threat model make better decisions at the margin. But it functions as a last line of defence being treated as a primary control, and that inversion is where the failure lives.

The controls that actually reduce phishing risk are structural. Strong email authentication through properly configured SPF, DKIM and DMARC removes a category of spoofed senders before any human ever sees the message. Consistent sender identification in mail clients removes the ambiguity that makes social engineering effective. Reducing email as a mechanism for transmitting credentials or initiating sensitive actions removes the attack surface entirely for a class of attempts.

Beyond email specifically, the broader principle is that the burden of security decisions should sit as close as possible to the layer where those decisions can be made reliably. A human deciding whether to click a link in a high-volume, high-pressure context is an unreliable control. A mail gateway evaluating authentication headers is not subject to fatigue, social pressure, or a tight deadline.

This requires investment in architecture, not in dashboard completion rates. It requires organisations to treat security as an engineering problem rather than a training budget line item.

Most organisations find that considerably less comfortable than sending another module.

## Managing appearances

What tends to happen instead is a version of what I described at the start: the simulation runs, the click rate is reported, the training cycle repeats, and the metrics improve. Completion rates approach a hundred percent. Simulated click rates decline, partly because people learn to recognise the internal simulation vendor's templates.

Meanwhile the actual attack surface is unchanged. The email authentication configuration has the same gaps. The tooling still cannot distinguish a vendor notification from a credential-harvesting page with any reliability. The workflows still create the conditions where a user under pressure makes a fast decision without adequate information.

The organisation has not become more secure. It has become better at demonstrating, on paper, that it takes security seriously.

Edwin called this a management failure. That is accurate. But I would extend it: it is a failure of organisational honesty. Awareness programs persist not because they work, but because they are visible, measurable, and keep the liability pointed at the user rather than at the conditions the organisation itself created.

If an organisation genuinely wanted to reduce risk, it would start by auditing the environment it expects its users to navigate. It would ask what decision a reasonable person could actually make with the information and tools available, at the speed the organisation demands, under the social conditions that govern daily work.

In most cases, the honest answer is: not a very good one.

That is not a training problem.
That is a design problem.
And design problems require someone in a position of authority to decide that fixing the system matters more than explaining why the user failed it.
