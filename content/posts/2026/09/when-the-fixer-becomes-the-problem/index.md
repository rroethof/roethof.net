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
description: "A reflection on becoming the single point of failure you spent your career trying to eliminate, and what happened when you tried to fix that yourself."
---

*On single points of failure, sharing the keyboard, and what happens when the fixer starts fixing things that expose the organisation instead.*

## Somewhere along the way, I became the SPOF

There is a particular kind of irony in building a career around infrastructure, security and continuity, around preventing single points of failure, and ending up as one yourself. For years I said the right things. Knowledge should not live in one head. Systems should be reproducible. Documentation should be part of how the work gets done, not an afterthought bolted on at the end. Colleagues should be able to pick things up without me.

And the whole time, the system kept working because I kept making it work. Something broke, I fixed it. An incident happened, I got the call. Something needed building, repairing, automating, securing or untangling, and more often than not I knew what to do with it. There is an uncomfortable truth underneath that: I was not only a victim of that pattern, I benefited from it too. Everyone had my number. I was on speed dial, in the way that flatters you a little more than it should. You become the person who solves the hard things, and it is genuinely satisfying to be able to say, after something complicated finally comes together, that you just sorted it. Pretending otherwise would be dishonest.

So I was part of the problem, not because I set out to become a SPOF, but because I kept saying yes whenever something needed solving, and because the organisation could keep relying on that. In the short term it worked beautifully. That is exactly what made it dangerous in the long run. It is the same pattern I wrote about in [I Always Get It Done (That's the Problem)](https://roethof.net/posts/2026/05/i-always-get-it-done-problem/): the trait that makes you valuable can quietly become the reason an organisation never builds around you.

## The technology was fine, thanks

Every audit tended to land on the same conclusion. Technically, things were in good shape. That was not surprising. The systems worked, the infrastructure held up, the security controls were properly implemented, and there was someone who understood why every choice had been made the way it had. The technical quality was not a story we had to invent, auditors kept confirming it independently.

That is exactly where the paradox sits. An auditor confirming the technology works says nothing about whether the knowledge behind it is properly secured. It says nothing about whether responsibilities are distributed sensibly, or whether someone else could pick up the same system tomorrow without the original builder in the room. It certainly says nothing about whether the organisation has a SPOF. If anything, the better the technology performed, the easier it became to ignore the organisational dependency sitting underneath it. As long as the systems ran, the audits passed well enough, and problems got solved when they appeared, there was little pressure to open up the foundation that dependency was built on. The problem was never really bad engineering. It was depending on one person for knowledge, decisions, context and execution, while the engineering itself looked fine.

## Trying to fix my own SPOF

At a certain point I put together a concrete plan to structurally reduce my own indispensability. Not a request for a bigger title, more authority or a nicer business card. The opposite. The idea was to pull knowledge out of my head and put it into code, documentation and reproducible process: Git as the source of truth, declarative infrastructure, automation, standards, security governance that existed somewhere other than a slide, colleagues who could operate independently, and above all, responsibility and authority that matched each other.

The plan had a clear horizon: stabilise and put governance in place first, then build the platform out further and bring people in, then actually hand over knowledge and day-to-day control. The endpoint was never me becoming more important. It was me becoming less necessary. One of the more telling ideas in that plan was a straightforward absence test: what happens if I am simply not available for thirty days. Not as a thought experiment, but as a genuine check on whether the organisation could actually function without me. My own role was meant to shift toward direction, architecture and quality control, with day-to-day execution carried by the organisation itself, and the SPOF structurally gone.

That proposal went nowhere. What came after it was a different proposal entirely.

## The hardest thing to ask of a fixer

The hardest part of being the fixer is not learning how to solve something. It is learning to let somebody else solve it instead.

There were, in effect, two different tracks on the table for solving the same underlying problem, and on an org chart they can look almost identical: neither wants the organisation depending on one person anymore. But one restricts the person the dependency was built around. The other builds organisational resilience. Those are not the same solution wearing different clothes. My proposal said, in effect, make me less necessary by giving other people the same keyboard. The alternative said, make me less necessary by taking the keyboard away.

That sounds harsh, but for someone whose actual craft is building and improving technology, the difference is not cosmetic. You can still be senior, still advise, still bring your technical knowledge to the table, while the thing that made it your craft, sitting behind the keyboard and actually building, quietly stops being part of the job. Not shared. Taken. And that, for me, was the real distance between the two proposals: not removing the specialist from the technology, but removing the technology's dependency on the specialist, which is a completely different way of solving the same problem.

Accepting my own proposal also meant accepting that someone else might choose a different solution than I would, maybe not my approach, maybe not even the approach I would have picked myself. But if it was reproducible, manageable, secure and demonstrably sound, that was the entire point. Other people needed to sit down next to me, take things over, build their own version, make their own mistakes, take their own responsibility. My knowledge needed to stop being a precondition for keeping the platform running.

Technology is my actual drive. Understanding things, building them, automating them, debugging them, fixing them, and then figuring out how to make them better again, that is where the energy comes from. My instinct has never been to watch from a distance while somebody else does it. My instinct is to sit down and do it myself. That sounds like a minor detail, but for someone who works this way, giving up part of that is close to the hardest thing you can be asked to do. I was prepared to hand over part of the keyboard. I was not prepared to disappear from the craft entirely, and that distinction is easy to miss on paper.

## Two tracks running side by side

Looking back, two separate tracks were running through each other. I had set the first one in motion myself, because I could see that my existing position could not continue indefinitely, and because I had already been the technical linchpin, and by extension the SPOF, for long enough to have warned about it before. A second track ran alongside it from elsewhere in the organisation: a look at a different place for me, an attempt to think ahead and find a way to keep me on board. That is not, in itself, an unreasonable thing to attempt.

The trouble is that the two tracks were answering different questions. My question was how do we make the organisation less dependent on one person. The other question was how do we give this particular person a different place in the organisation. Those questions sit close together, but they are not the same, and the second one does not answer the first no matter how it is phrased.

There was also a quieter layer underneath it. If I did not feel at home in the new direction, the responsibility for the next step drifted back toward me. Not literally told to leave, but offered the polite, organisational version of being asked to draw your own conclusion. That is a different thing entirely from formally stating that an existing function no longer exists, and the difference matters more than it might look on paper.

## Linux, open source, and the fixer back in the box

The same tension showed up in something that looks much smaller at first glance: tooling. The proposed profile assumed standardised, organisation-supported tools, and no individual custom solutions whose knowledge sat with one person. My first reaction was simple: I was not about to give up open source or start using a locked-down standard laptop. That was not a hobby I happened to have on the side, it was how the work itself had been done for years. The wording was then softened, no longer explicitly no open source, just no individual custom solutions.

That was an understandable attempt to make the profile workable. It also exposed an awkward contradiction. A large part of the work I had taken responsibility for consisted precisely of solutions built specifically for the environment they ran in. The actual problem was never custom engineering itself. It was custom engineering that stayed dependent on one person, which is exactly what my own proposal had been trying to solve in the first place.

## What it actually cost

This is the part that gets left out of a tidy reconstruction. It gets filed away as workload, or stress, or a period that was not going particularly well, and none of those words do justice to what it actually cost. I have been through burnout more than once. I have carried real physical pain. Eventually it caught up with me as [a heart attack](https://roethof.net/posts/2026/06/when-your-body-pulls-the-plug/), and afterwards I went through EMDR to work through the psychological aftermath as well. Those are not abstract entries on a risk matrix. That is the bill arriving, eventually, somewhere.

I cannot say with certainty that any single organisational decision or proposal caused those medical events. What I can say is that I got sick during a period when my own room to manoeuvre kept shrinking, while I was actively trying to solve the underlying dependency structurally. That makes the conversation about a healthier role more complicated than it first appears. Working in a healthier way is not only about receiving less responsibility. It also means the conditions you return to actually fit recovery: predictability, less conflicting pressure, fewer interruptions, and a careful, gradual build-up. A role built around tickets, SLAs, daily direction and a manager acting as a filter can be perfectly well organised on paper, and still not be the right shape for someone who is recovering from exactly that way of working in the first place.

## Governance is not a leash

I am not against governance, quite the opposite. ISO 27001, security governance, risk management, compliance, documentation and clear responsibilities have made up a large part of my actual work. But governance and control are not the same thing. Governance makes responsibility clear, makes risk visible, and makes sure decisions land somewhere. Control can mean someone stays accountable for the outcome while steadily losing the authority to actually influence it.

That distinction is where this really turns. An architect without technical or organisational influence ends up writing architecture documents. A security officer without a mandate ends up logging risks. A senior engineer without room to act is mostly a senior title inside a tightly drawn process. It is also why the difference with my own proposal mattered so much to me. I wanted responsibility and authority tied together on purpose. If management chose not to implement a measure, I wanted that risk explicitly recorded, including the reason, the risk owner, and a review date, not because I wanted more power, but because otherwise you create responsibilities that never land anywhere accountable. That connects directly to [Audit Theater: Compliance Without Control](https://roethof.net/posts/2026/05/audit-theater/) and [The ISO 27001 Hallucination: Documenting Your Way to Disaster](https://roethof.net/posts/2026/03/iso-27001-compliance-illusion-resilience-failure/). Compliance only means something if it reflects reality, and an organisation can run technically well and still depend entirely on one person.

Put plainly, the trajectory on offer here goes from an engineer who also carried security governance, to a scoped-down advisor bolted onto a ticket queue, handing recommendations to the very organisation that has, by now, shown in writing that it does not act on the recommendations it already had. That is not a lateral move into something calmer. It is being asked to keep making the diagnosis while losing the authority to prescribe the treatment, for a patient with a documented habit of ignoring the prescription anyway.

## The fixer as mirror

Organisations love fixers, right up until the fixer stops only solving problems and starts making visible where the organisation itself never got around to organising anything. For as long as I kept solving things, the system kept running, and my presence quietly became a kind of infrastructure of its own. Unofficial, undocumented, but entirely real. My phone number had become a technical dependency in its own right.

I helped keep that dependency alive myself, for years, and that is my share of it. But I also spent years saying this needed to change. I asked for collaboration, for people, for knowledge transfer, for structural safeguards, and eventually I built an actual plan that would let my own SPOF disappear. Which is why it feels so bitter, in hindsight, that the eventual response was not primarily aimed at removing the dependency, but at repositioning the person the organisation depended on. You can remove the dependency, or you can remove the person. Those are two entirely different solutions to the same problem.

The real measure of a senior engineer, architect or security specialist should not be how many problems that person can solve. It should be how many keep getting solved after that person is gone. That is the only real test of a resilient organisation: not whether the fixer can make it work, but whether it still works when the fixer is unreachable for thirty days.

And maybe that is the most uncomfortable conclusion of all. I was, in fact, the SPOF. But I was also the one trying to fix that, not by making myself indispensable, but by making sure I no longer needed to be.

## Further reading

A couple more pieces cover the same underlying pattern from angles that did not fit naturally above:

- [The Senior Specialist's Tax: Hands-on or Handcuffed?](https://roethof.net/posts/2026/03/hands-on-or-handcuffed-the-enterprise-paradox/), on what happens to the workload when key people leave and nobody replaces the knowledge, only the title.
- [The Suit Killed the Operator](https://roethof.net/posts/2026/04/the-suit-killed-the-operator/), on the longer arc from technical authority to compliance theatre.
