---
title: "Open Source, Until the Governance Committee Arrives"
slug: open-source-until-the-governance-committee-arrives
date: 2026-08-17
lastmod: 2026-08-17
draft: false
author: "Ronny Roethof"
cover: posts/2026/08/open-source-until-the-governance-committee-arrives/cover.jpg
categories:
  - linux-open-source
  - opinion-reflections
tags:
  - nixpkgs
  - governance
  - communityrule
  - iso27001
  - digital-sovereignty
summary: "Open source needs governance, but governance should protect the people who ship, not replace them."
description: "The Nixpkgs Core Team disbanding raises an uncomfortable question: when governments and institutions bring governance into open source, are they making communities more sustainable or simply making them more controllable?"
---

# Open Source, Until the Governance Committee Arrives

*On two wolves, benevolent dictators, and why governance is not the same thing as control.*

Something happened this weekend that is about as exciting to the average Dutch citizen as a leadership change at the local pigeon racing club: the Nixpkgs Core Team disbanded. For people who care about Linux, open source and digital sovereignty, that is considerably more interesting, not only because Nixpkgs is an important part of the Nix ecosystem, but because it exposes an uncomfortable question. What happens when an open-source project becomes important enough that someone decides it needs to be governed?

I am not exactly neutral on this subject. Professionally I am a BISO. Governance, risk, continuity, accountability and control are words I deal with every working day. But if I am honest, my nature is a different story, and I might as well say it plainly: I am, at heart, anti-governance. It limits too much. It looks over my shoulder while I work. It narrows the solutions I am allowed to reach for before I have even reached for them. Like most Linux people I know, I have a streak of the anarchist in me, and governance is exactly the thing that streak pushes back against. So there are two sides of me having an uncomfortable conversation. One does governance for a living. The other would rather not be governed at all.

The BISO in me says: "Nice project. Who is going to maintain this five years from now?" The anarchist in me replies: "Fair question. But if we need a steering committee, governance framework, RACI, SLA and quarterly reporting before anyone is allowed to merge a pull request, there may be nobody left to maintain it five years from now."

## The two wolves

Ruben van der Linde described the situation rather nicely in his recent piece: "In every public open-source project, there are two wolves. Feed the wolf that ships." One wolf delivers, the other governs. Neither wolf is inherently bad, they simply have very different definitions of success. The delivery wolf looks at a problem and asks: can I fix this today? The governance wolf looks at the same problem and asks: who has the mandate to decide this? One thinks in code, releases, bugs, users and solutions. The other thinks in accountability, continuity, risk, public money and predictability. All perfectly reasonable, until the second wolf starts trying to organise the first as if it were a government programme. An open-source community is not a steering committee with some software attached.

## Governance is not the problem

Let me get this out of the way first. I am, by nature, suspicious of governance. It limits too much. It looks over my shoulder. It narrows the solutions I am allowed to reach for before I have even had the chance to explore them. That is an awkward thing to admit for someone who does governance professionally, but it is also why I think I have something useful to say about it. I don't dislike governance because I don't understand it. I dislike bad governance precisely because I understand what it does. And yet governance is necessary, especially when governments depend on open-source projects. You need to know how decisions are made, you need to understand responsibilities, you need mechanisms for resolving conflicts, and you need to know what happens when a maintainer leaves. Necessary is not the same thing as something I enjoy. It is something I have learned to accept, the way you accept a seatbelt.

This is one reason I find [CommunityRule](https://communityrule.info/) interesting, and it sets up the contrast that runs through the rest of this piece. Nixpkgs gives us a useful example of what can happen when governance starts competing with the people doing the actual work. CommunityRule starts from the opposite premise: governance exists to help a community organise itself. Its premise is not that governance is bad, quite the opposite: communities need explicit rules for decision-making, power distribution and participation. That is fundamentally different from using governance as an external control mechanism. There is an important distinction here, and it might be the central idea of this whole piece: **governance of a community is not the same thing as governance over a community.** The first can make a community stronger. The second can suffocate it.

## The benevolent dictator

There is a very reasonable counterargument to all of this: "Sure, Ronny. But without governance you just end up with a benevolent dictator for life and complete chaos." Yes, you can. But here is the uncomfortable part: you can get exactly the same situation with governance.

I have actually seen it happen, not in an open-source project but in an organisation. When people who understand a system leave, knowledge does not magically redistribute itself. If one person keeps solving the problems, making the decisions and carrying the historical knowledge of the system, something strange happens. Nobody formally appoints that person as dictator. There is no decree, no hostile takeover. It just happens. Everybody knows Ronny knows how this works, so Ronny does it. Until Ronny doesn't.

## A single point of failure with a human face

That may be one of the most dangerous forms of technical dependency. You can build a system with redundant servers, multiple databases, monitoring, backups and failover, and still be completely single-threaded at the organisational level. If only one person knows why the system works, how to recover it, and why certain decisions were made, you do not have redundancy. You have a single point of failure with a human face.

I have been on the wrong side of that equation myself. There have been situations where a business-critical monitoring platform failed while I was ill, and there simply was not enough knowledge elsewhere to restore it independently. I ended up restoring databases during a burnout and working through the night because nobody else could. At the time it felt like taking responsibility. Looking back, I see it differently: that wasn't continuity, it was a workaround, and a workaround only works as long as somebody is willing to sacrifice themselves to keep it alive. And if your continuity plan depends on the person who is unavailable becoming available, you don't have a continuity plan. You have a dependency.

## "We've still got Ronny"

Organisations do not always recognise this as a risk. As long as the system keeps running, everything looks fine. No incident, no audit finding, no red dashboard. The person who knows the system simply keeps fixing things. That creates a dangerous illusion: if it works, it must be under control. But having an expert available is not a continuity strategy, and knowledge that exists only inside one person's head is not knowledge management. It is dependency.

This is also where governance and security become the same conversation. A technically redundant environment can still be organisationally fragile. Four servers, three databases and two datacentres do not help much if only one person knows why any of them are there.

## The government does the same thing, at scale

And this brings us back to open source. What happens when a government discovers a successful open-source project? First comes enthusiasm. It works, it is open, it reduces vendor lock-in, it contributes to digital sovereignty. Then it becomes important, and once something becomes important, we want certainty. So we introduce agreements, governance, steering committees, responsibilities, SLAs, funding, KPIs and risk assessments. All of that is understandable. But somewhere along the way we can forget what made the project successful in the first place: people who actually build things, fix bugs, review code, write documentation, make releases, and who suddenly think on a Tuesday evening, "I can make this better." Those people are not the implementation department of the governance structure. They are the community.

## Nixpkgs is more interesting than "governance failed"

This is why the Nixpkgs story deserves more nuance than simply saying governance doesn't work. The Nixpkgs Core Team was created in 2025 specifically to strengthen governance around the project. The intention was a relatively lightweight structure that would not unnecessarily interfere with technical contribution and bottom-up decision-making. In August 2026, the Core Team disbanded, not because governance was conclusively proven to be bad, and not because there was one evil dictator. The reality seems more interesting: the people responsible for governance were also active technical contributors, which created a tension between governing the project and doing the technical work itself. That combination made the role hard to sustain, and there was not enough willingness within the team to take it over.

That matters, because governance ultimately competes for the same scarce resource as open-source development: the time and energy of people who actually know how to do the work. Every meeting, every committee and every additional governance responsibility takes time away from code, reviews, releases and community. Governance has a cost, and it is not just financial. It is human.

## Governance over a community works differently

This is where CommunityRule becomes an interesting counterweight. The idea that governance should be explicit is healthy. A community should not depend on hidden power, accidental hierarchy or one person who has happened to run everything for ten years. But governance should emerge from the community and help it function, not the other way around. A useful governance model should answer how we make it possible for more people to contribute, decide and take responsibility, not how we make the community controllable by the organisation funding it. Those sound like small differences. They are not.

## And then there is money

Another common argument in open-source discussions is that the problem isn't open source, the problem is free. There is some truth there. Open source isn't free: the license may be free, but the people aren't, infrastructure isn't, support isn't, security isn't, and continuity definitely isn't. If a government depends on an open-source project, it is entirely reasonable to invest in it. But investing is not the same as owning, and paying for something does not automatically give you the right to control its community. You can fund an ecosystem without colonising it. Perhaps governments need to become much more comfortable with that idea.

## The real question

Maybe we should stop asking how we govern this open-source project, and start asking what makes this project technically and socially healthy, and how we make sure we don't destroy that. Governance should follow the needs of the community, not define them in advance. Good governance should prevent a project from becoming dependent on one person. It should distribute knowledge, make succession possible, make conflicts manageable, and help new contributors find their way in. Most importantly, it should help the people who ship keep shipping.

## The BISO in me still finds this annoying

Because of course I want to know who is responsible. I want to know how vulnerabilities are handled, how dependencies are managed, and how the build environment is secured. I want to know what happens when the most important maintainer walks away tomorrow. But the open-source guy in me then asks an inconvenient follow-up question: does this actually make the system safer and better? That is perhaps the question we should ask more often, not only about open source, but about security, compliance and digital sovereignty in general, because it is remarkably easy to confuse control with security, and governance with continuity.

## Feed the wolf that ships

So the lesson I take from Nixpkgs is not that governance is bad. Quite the opposite: governance has a purpose, and that purpose is not to maximise controllability, it is to make a community sustainable. Good governance makes sure a project does not depend on one person. But if governance becomes so heavy that the people doing the actual work leave, you have recreated the exact same problem. It just has a different name. It isn't called a single point of failure anymore. It is called a governance model. And that may be the greatest irony of all.

Governance should protect the wolf that ships. It should never replace it.

And maybe that is the real thread running through all of this. You cannot govern away a lack of people who actually do the work. That is true for Nixpkgs. It is true for open source in general. And, unfortunately, it is just as true for a great deal of enterprise IT.

## Sources

Ruben van der Linde, "In elk publiek opensourceproject leven twee wolven. Voer de wolf die levert," [LinkedIn](https://www.linkedin.com/posts/rubenlinde_dit-weekend-hief-het-nixpkgs-core-team-zichzelf-ugcPost-7492884614475321344-Q8Du/?utm_source=chatgpt.com).

Nixpkgs Core Team, "The Nixpkgs core team has disbanded," [NixOS Discourse](https://discourse.nixos.org/t/the-nixpkgs-core-team-has-disbanded/79413?utm_source=chatgpt.com).

Nixpkgs, "Establishing the Nixpkgs core team," [GitHub](https://github.com/NixOS/nixpkgs/issues/445849?utm_source=chatgpt.com).

CommunityRule, governance for communities and open-source projects, [communityrule.info](https://communityrule.info/?utm_source=chatgpt.com).