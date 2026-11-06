---
title: "When the Fixer Becomes the Problem"
slug: when-the-fixer-becomes-the-problem
date: 2026-09-02
lastmod: 2026-09-03
draft: true
author: Ronny Roethof
categories: ["career-sysadmin", "opinion-reflections"]
tags: ["single-point-of-failure"]
summary: "You do not fix a SPOF by making the fixer smaller. You fix it by removing the dependency on the fixer."
description: "A reflection on becoming a single point of failure, sharing technical knowledge, and the difference between building resilience and restricting the fixer."
---

*On single points of failure, sharing the keyboard, and confusing control over a person with resilience in an organisation.*

## Somewhere along the way, I became the SPOF

There is a particular kind of irony in building a career around infrastructure, security and continuity, around preventing single points of failure, and ending up as one yourself. For years I said the right things. Knowledge should not live in one head. Systems should be reproducible. Documentation should be part of how the work gets done, not an afterthought bolted on at the end. Colleagues should be able to pick things up without me.

And the whole time, the system kept working because I kept making it work. Something broke, I fixed it. An incident happened, I got the call. Something needed building, repairing, automating, securing or untangling, and more often than not I knew what to do with it. There is an uncomfortable truth underneath that: I helped sustain that pattern, and I benefited from it too. Everyone had my number. I was on speed dial, in the way that flatters you a little more than it should. You become the person who solves the hard things, and it is genuinely satisfying to be able to say, after something complicated finally comes together, that you just sorted it. Pretending otherwise would be dishonest.

So I was part of the problem, not because I set out to become a SPOF, but because I kept saying yes whenever something needed solving, and because the organisation could keep relying on that. In the short term it worked beautifully. That is exactly what made it dangerous in the long run. It is the same pattern I wrote about in [I Always Get It Done (That's the Problem)](https://roethof.net/posts/2026/05/i-always-get-it-done-problem/): the trait that makes you valuable can quietly become the reason an organisation never builds around you.

## The technology was fine, thanks

The technology can be in excellent shape while the organisation around it remains fragile. Systems work, infrastructure holds up, security controls do what they should, and someone understands why every choice was made. There may be plenty of evidence that the engineering is sound.

But technical quality alone does not tell you whether someone else could pick up the same system tomorrow without the original builder in the room. It does not tell you whether knowledge is accessible, decisions are shared, or people have had enough practice to work independently. The better the technology performs, the easier it can become to overlook the dependency underneath it. If every problem gets solved, there is little immediate pressure to ask why solving it still requires the same person.

That is the paradox I recognise from my own working habits. Making the system reliable can hide how much it relies on you. Your competence becomes part of the infrastructure, without anyone having designed it that way.

## Trying to fix my own SPOF

Recognising my own part in that pattern meant consciously trying to reduce the dependency. I wanted knowledge out of my head and available through documentation, reproducible processes and working alongside colleagues. The aim was for other people to understand the systems, make decisions and carry the work forward independently.

That takes more than writing instructions. People need time to work through unfamiliar problems, ask questions and develop their own judgement. They need a real say in how the work is done. If every difficult decision still comes back to me, I have shared information without really sharing responsibility.

The endpoint I wanted was simple: my involvement should become a choice rather than a requirement. I could keep contributing without being the condition that made everyone else's contribution possible.

## The hardest thing to ask of a fixer

The hardest part of being the fixer is not learning how to solve something. It is learning to let somebody else solve it instead.

There are two tempting ways to approach that dependency. Give more people the knowledge, confidence and room to do the work, or restrict the involvement of the person everyone relies on. Restricting one person may change who is allowed to act. It does not, by itself, give anyone else the ability to take over. That is the distinction that matters to me when I talk about sharing the keyboard.

For someone whose craft is building and improving technology, that difference matters. You can still advise and bring technical knowledge to the table while having much less opportunity to build anything yourself. For me, losing that connection would mean losing a large part of what gives the work its meaning.

Reducing my own indispensability also meant accepting that someone else might choose a different solution than I would. But if it was reproducible, manageable, secure and demonstrably sound, that was the entire point. Other people needed to sit down next to me, take things over, build their own version, make their own mistakes, take their own responsibility. My knowledge needed to stop being a precondition for keeping the platform running.

Technology is my actual drive. Understanding things, building them, automating them, debugging them, fixing them, and then figuring out how to make them better again, that is where the energy comes from. My instinct has never been to watch from a distance while somebody else does it. My instinct is to sit down and do it myself. Sharing that work means resisting the urge to do everything myself, even when I know I could finish it faster. That is difficult enough without treating technical involvement itself as the problem. I want others to have the same opportunity to build, rather than making room for them depend on my giving up the craft entirely.

## Less autonomy is not less dependency

Making an organisation less dependent on someone and giving that person less autonomy can look deceptively similar. In both cases, the fixer may become less involved in day-to-day work. The difference is what everyone else can do afterwards.

If colleagues can understand the systems, make informed decisions and deal with unfamiliar failures, the organisation has gained something. If the same questions still need the same person's answers, but getting those answers now requires more permission, the dependency has acquired an extra step.

This is where the frustration sits for me. Being needed for your knowledge while having less room to use it is a poor substitute for sharing that knowledge properly. A sustainable way of working needs to make expertise available to more people and give them the opportunity to exercise it.

## Tools need shared understanding too

Linux and open source are part of how I think about technical work: understanding how something works, being able to inspect it, adapting it and sharing what you learn. That also means accepting that other people should be able to understand and change what you build.

There is a reasonable need for tools that colleagues can support and maintain. Custom engineering has to meet that need too. The useful questions are whether a solution can be understood, reproduced and maintained by others, and whether the knowledge is available to them.

Standardisation can help. So can documentation, automation and working together. But a standard tool still depends on one person if nobody else knows how it has been configured or why. The continuity problem lives in the dependency, and changing the tool alone does not necessarily remove it.

## Being available has a cost

I learned that being the person everyone relies on can become unhealthy. Always being able to fix something is not the same as being able to keep doing it indefinitely.

A sustainable working life needs predictability, fewer conflicting demands and the ability to step away without wondering what will stop working. For the fixer, learning to leave space for others is part of that. For the organisation, so is giving those people the time, trust and support to take responsibility.

I still find it difficult to resist stepping in when I know I can solve something quickly. But every immediate rescue has to be weighed against the opportunity for someone else to learn. That tension does not disappear just because you understand it.

## Governance is not a leash

I am not against governance, quite the opposite. Clear responsibilities, shared decisions and an honest understanding of risk are essential to sustainable technical work. People need to know what they are responsible for, which decisions they can make, and where to turn when something needs wider agreement. Governance gives people a framework within which they can act independently. Micromanagement keeps pulling those decisions back into someone else’s hands. Shared responsibility needs room to exercise judgement.

For an experienced engineer, being asked to contribute expertise while having little influence over what happens next can be difficult. Responsibility needs to be shared in a way that also gives people room to act. When a recommendation cannot be taken forward, there needs to be a common understanding of the choice and its consequences. Otherwise, it becomes hard to know who can actually move the work forward.

That connects to the broader questions in [Audit Theater: Compliance Without Control](https://roethof.net/posts/2026/05/audit-theater/) and [The ISO 27001 Hallucination: Documenting Your Way to Disaster](https://roethof.net/posts/2026/03/iso-27001-compliance-illusion-resilience-failure/). Compliance only means something if it reflects reality, and an organisation can run technically well while still depending heavily on one person.

Recommendations mean very little when an organisation lacks the willingness or structure to turn them into action. Asking a technical specialist to keep identifying problems while steadily reducing their influence over the work can leave everyone stuck: advice keeps arriving, the same obstacles remain, and others still lack what they need to carry the work independently.

## The fixer as mirror

A fixer can make gaps in shared knowledge and responsibility difficult to see. Solving the immediate problem takes the pressure off addressing the dependency. Trying to share the work brings those gaps into view again. For as long as I kept solving things, the system kept running, and my presence quietly became a kind of infrastructure of its own. Unofficial, undocumented, but entirely real. My phone number had become a technical dependency in its own right.

I helped keep that dependency alive myself, for years, and that is my share of it. Wanting to change it meant accepting that other people needed room to learn, decide and build without me stepping in. The frustration is that restricting the fixer can look like progress even when nobody else has become more capable. A person may be easier to manage while the systems remain just as dependent on their knowledge.

A useful test cuts through that ambiguity: can the organisation function if its usual problem-solver is unreachable for thirty days? Can people find the information, make the decisions and handle something unexpected? The answer tells you more about resilience than how tightly anyone's work is supervised.

The real measure of a technical specialist should not be how many problems that person can solve. It should be how many keep getting solved after that person is gone. That means giving others enough understanding and experience to keep working when the familiar answer is no longer a phone call away.

I was, in fact, the SPOF. I also wanted to stop being one. I wanted to share what I knew and keep practising the craft I loved, with colleagues who could do the same independently.

You don't eliminate a single point of failure by taking away the keyboard. You eliminate it by making sure someone else can use it.

## Further reading

A couple more pieces cover the same underlying pattern from angles that did not fit naturally above:

- [The Senior Specialist's Tax: Hands-on or Handcuffed?](https://roethof.net/posts/2026/03/hands-on-or-handcuffed-the-enterprise-paradox/), on what happens to the workload when key people leave and nobody replaces the knowledge, only the title.
- [The Suit Killed the Operator](https://roethof.net/posts/2026/04/the-suit-killed-the-operator/), on the longer arc from technical authority to compliance theatre.
