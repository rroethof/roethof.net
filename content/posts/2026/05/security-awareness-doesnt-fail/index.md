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

I read a [post](https://www.linkedin.com/pulse/security-awareness-een-managementstoring-stop-met-het-edwin-ribbers-zkhze/) by [Edwin Ribbers](https://www.linkedin.com/in/edwinribbers/) describing security awareness as a management failure. He is right, but that is only the surface.

---

## Awareness as a comfortable illusion

Most organisations run security awareness programs. People watch a video, answer a quiz, and earn a certificate. Dashboards turn green, completion rates go up, and from a reporting perspective everything looks fine. From an operational perspective, nothing changes.

The underlying assumption is simple: if people know better, they will behave better. It sounds logical. It isn’t.

---

## A phishing simulation

We tested it. Not with anything sophisticated, but with something ordinary: an email about Christmas gifts—a voucher, a link, a code. The kind of message people see every year and process without thinking too much about it.

Within thirty seconds, a director clicked. Within forty seconds, a senior engineer followed. Both had completed awareness training. Both knew what phishing is. Both understood what they were supposed to look for.

It made no difference.

The usual conclusion is predictable:

> “Users clicked a phishing link.”

That feels like the problem. It isn’t. It is the outcome.

---

## Context beats knowledge

At the same time, something else happened. Other people did not click. Especially not the finance team. They paused, questioned the message, and verified it before doing anything.

That behaviour did not come from training, but from context. Their work deals with irregular requests, financial risk and external pressure. Caution is not optional there.

Elsewhere in the organisation, behaviour develops differently. Speed, responsiveness and confidence are rewarded.

That works.

Until it doesn’t.

---

## When real looks like fake

The email worked exactly as intended—not because people are careless, but because it was good communication. It was relevant, timely, and built on existing trust while offering something of value.

In other words, it behaved exactly like a real business process.

And that is where the model starts to break.

Security awareness assumes that knowledge leads to correct decisions. Reality shows that behaviour is shaped by context. People act under time pressure, interruptions and expectations created by the organisation itself.

Knowledge is part of that. It is rarely the deciding factor.

---

## The gamification interlude

Before treating this as an isolated incident, it is worth looking at what organisations often do next.

They gamify the problem. Leaderboards, points, streaks, progress dashboards. Engagement increases. Completion rates improve. Simulated click rates go down.

On paper, things get better.

In reality, something else happens.

People learn the game.

They recognise templates. They anticipate patterns. They adapt to the simulation, not to real attacks. At one organisation running such a platform, a small group of engineers with access to the underlying database occupied the top positions on the leaderboard for months.

Not because they were more secure.

Because they understood how they were being measured.

We train people to win the game, not to understand risk.

---

## After the simulation

The most revealing part came afterwards.

The discussion was not about security. It was about fairness.

One response acknowledged the phishing attempt and then asked whether the €150 voucher could still be transferred—not as sarcasm, but as a continuation of an expectation that had already been created.

Another admitted the click, but rejected the approach. Too realistic. Too convincing. Not appropriate. “The measure is worse than the problem.”

At that point, the discussion had shifted.

This was no longer about phishing.

It was about trust.

---

The organisation created a situation where the communication looked legitimate, the reward felt real, and the action made sense—only to reveal afterwards that none of it existed.

People did not reject the lesson.

They rejected the premise.

---

## The organisational response

The response followed a familiar pattern: not system change, but reaction management. Supermarket vouchers were introduced. Complaints stopped. The situation stabilised.

The system remained unchanged.

---

## Then everything broke

A year later, a similar email appeared again. Same pattern, different sender: external origin, a link to claim a gift, even credentials included in the message.

Everything people had just been trained not to trust.

This time, people did exactly what the awareness program intended. They ignored it, reported it, and escalated it.

They did not click.

They were wrong.

The email was legitimate. The organisation itself used that pattern.

---

## No stable behaviour

At that point, the model collapses.

Click, and you are wrong.  
Don’t click, and you are wrong.

There is no stable, correct behaviour left.

Security awareness assumes that users can learn a reliable response. In practice, the same pattern can be both legitimate and malicious. From the user’s perspective, that is not decision-making.

It is guessing.

---

## The contradiction

Organisations expect people to act quickly, trust communication and respond without friction, while simultaneously training them to distrust, hesitate and verify everything.

These expectations cannot coexist.

That is why the results never improve in a meaningful way. Behaviour follows the system people operate in, not the training they complete.

---

## The real dependency

“They always get it done.”

“They clicked the link.”

Both describe the same structural problem. In one case, the organisation depends on people compensating for flawed system design. In the other, it blames them when they do not.

---

## Security awareness does not fail

It works exactly as designed. It produces metrics, demonstrates effort and creates the appearance of control.

What it does not do is change the system.

---

## Closing

If your security depends on people consistently making the right decision, you do not have security.

You have probability.

People clicked. People learned. People adapted.

And still, nothing fundamentally changed.

It was never about awareness.

It was about design.