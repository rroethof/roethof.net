---
title: "The Engineers Know. Management Decides. The Clock Keeps Ticking."
slug: the-engineers-know-management-decides-the-clock-keeps-ticking
date: 2026-10-30
lastmod: 2026-10-30
draft: false
author: "Ronny Roethof"

categories:

- security-privacy
- opinion-reflections

tags:

- incident-response
- iso27001
- iso22301
- php2shell
- nist
---
I regularly read articles by Edwin Ribbers. Edwin is a friend, and someone whose views on information security, risk management and business continuity I value. His recent article, [*Van incident response naar chaos management*](https://www.linkedin.com/pulse/van-incident-response-naar-chaos-management-waarom-plannen-ribbers-49ibe/), raises an interesting point: a technically manageable incident can turn into an organisational crisis when management struggles to make decisions.

I agree with much of his argument, but I disagree with the suggestion that technology stops being the biggest obstacle after the first ten minutes. After more than 25 years working with Linux, infrastructure, networking and information security, my experience tells me something different. Quite often, engineers know something is wrong long before management even knows there is a problem. They understand the infrastructure, recognise abnormal behaviour, know the dependencies and often have a pretty good idea of what needs to happen next.

**What they do not always have is the authority to act. And that is where things get interesting.**

## The crisis does not start in the boardroom

A security incident rarely starts with management declaring a crisis. It starts with monitoring alerts, unusual network traffic, failed authentication attempts, suspicious processes or systems behaving differently than expected. The people operating those systems notice, investigate and start building a picture of what is happening.

Sometimes that takes minutes, sometimes hours. But the people closest to the infrastructure generally have the best technical context to understand what they are looking at. By the time management becomes involved, engineers may already have identified the likely cause, assessed the exposure and prepared containment measures.

Then comes the familiar question: can we actually do this? Can we isolate that server, block that connection, restart that application or restrict external access? Or do we need approval from someone who does not fully understand the technical consequences?

**That is not a technical problem. That is an authority problem.**

## PHP2Shell: we saw this last week

The PHP2Shell vulnerabilities on 21 October provided a very practical example. I already described the events in two earlier articles: [*PHP2Shell: The Warning Was Early. The Response Was More Complicated*](https://roethof.net/posts/2026/10/php2shell-the-warning-was-early-the-response-was-more-complicated/) and [*You Cannot Secure What You Do Not Understand*](https://roethof.net/posts/2026/10/you-cannot-secure-what-you-do-not-understand/).

At 08:18, I formally reported the vulnerabilities through our information security process, including recommendations for identifying affected systems and preparing mitigations. The report was closed, with the explanation that vulnerability information already arrived through central security channels and that similar general notifications were unnecessary. A few hours later, central security leadership requested an inventory of PHP installations and suggested taking internet-facing systems offline.

I cannot establish whether my original warning influenced that later request, but the sequence illustrates something important. Receiving security information is not the same as understanding what that information means for your infrastructure. A threat intelligence feed can tell you that PHP is vulnerable, but it cannot tell you which of your services use PHP, how they are exposed, what depends on them or whether you can safely take them offline.

In our operational environment, I proposed restricting external access through additional Access Control Lists rather than shutting down the entire monitoring service. We limited access to approved customer IP addresses, restricted administration interfaces and maintained the existing reverse proxy protections. The service remained available to authorised customers while its exposure was reduced.

That did not patch PHP or eliminate every possible attack path. It was a temporary containment measure based on the actual environment. When further uncertainty emerged about the patches, I recommended keeping the restrictions in place. Someone asked whether we needed to pull the plug again. My answer was simple:

*The plug is still out. We are just running with a doorman at the front door.*

That was not chaos management. That was engineering, supported by operational cooperation and enough room to implement a practical solution.

## The problem is not always a lack of decisions

Edwin makes a valid argument about the importance of management decisions during a crisis. But we need to distinguish between an organisation where nobody knows who is responsible for making decisions and one where technical specialists know what needs to happen but cannot act without additional approval.

The first requires clearer governance. The second requires governance to stop becoming an obstacle.

Management does not need to understand every Linux kernel parameter, firewall rule or application dependency. That is why organisations employ technical specialists. Management needs to understand the business consequences, determine acceptable risks and establish the boundaries within which engineers can operate.

Once those boundaries are defined, technical teams should be trusted to act within them. If a security engineer needs three management approvals to isolate a compromised system, the incident response process is not mature. It is bureaucratic. And attackers do not wait for the next change advisory board meeting.

## Governance should enable action, not delay it

I have nothing against governance. ISO 27001, ISO 22301, NIST and other frameworks provide useful structures for accountability, risk management and operational resilience. But frameworks are tools, not substitutes for technical understanding.

A risk register cannot patch a server. A business continuity plan cannot restore a database. A policy document cannot tell you whether isolating a network segment will interrupt an entire production environment. And a closed security ticket certainly does not mean the vulnerability has disappeared.

Good governance ensures that the right people have the information, resources and authority to do their work. Poor governance adds approval layers, reporting requirements and meetings while the underlying technical problem remains unresolved. The difference is not the number of procedures, but whether those procedures help people make better decisions.

## Incident response is already more than technical recovery

Another point where I disagree with Edwin is the apparent separation between technical incident response and organisational crisis management. A mature incident response process is not simply a document describing how to restore servers and recover backups. It includes detection, analysis, classification, containment, escalation, communication, recovery and evaluation.

NIST SP 800-61 has long treated incident response as an organisational capability rather than merely a technical repair procedure. If an organisation's incident response plan only describes which engineer restores which server, the problem is not the concept of incident response. The implementation is incomplete.

We already have technical procedures, management policies, continuity plans and security frameworks. What we often lack is the ability to connect them to operational reality. Renaming the problem *chaos management* does not close those gaps.

## Exercise without IT? Sure. But what are you testing?

Edwin suggests conducting a crisis exercise without involving the IT department. I understand the reasoning. Management should be able to function when technical information is unavailable, incomplete or delayed. That is worth testing, but it only tests part of the organisation's resilience.

You can have an excellent boardroom exercise and still discover that your backups cannot be restored. You can agree on a four-hour Recovery Time Objective while the actual infrastructure takes twelve hours to rebuild. You can decide to isolate an environment without understanding which other systems will stop functioning as a result.

Personally, I would rather see exercises where management and engineers work together under realistic conditions: incomplete information, conflicting priorities, technical dependencies, business pressure and decisions with actual operational consequences.

That is where you find out whether governance works. Not when everyone successfully follows a PowerPoint presentation.

## The engineers often warned you already

There is another uncomfortable reality. Many technical risks are known long before they become incidents. Engineers know which systems are outdated, which backups have never been tested and where infrastructure depends on undocumented configurations or unsupported software.

They raise concerns, write recommendations and document risks. Sometimes those warnings disappear into a backlog, a risk register or another management meeting. Until something breaks, and everyone suddenly wants to know why nobody saw it coming.

Quite often, somebody did.

PHP2Shell demonstrated how quickly that disconnect can become visible. An early technical warning was dismissed through the formal process, while the same risk became an organisational priority only hours later. That does not prove malicious intent or incompetence, but it does show why the quality of a security process cannot be measured by how efficiently it closes tickets.

**A warning is not handled simply because someone has acknowledged or dismissed it. It is handled when the underlying risk has been assessed and an informed decision has been made.**

## Management owns the risk. Engineers understand the technical reality.

Management is responsible for business risk. Engineers are responsible for understanding and operating the technical environment. Those responsibilities are different, but inseparable.

An engineer should not independently decide that an entire business operation can remain unavailable for days without considering the consequences. Equally, a manager should not demand that a compromised system be brought back online without understanding the technical implications.

The solution is not to give either side unlimited authority. It is to establish clear responsibilities and predefined mandates. Emergency changes, containment actions and escalation thresholds should be agreed before an incident occurs. Within those boundaries, engineers should be able to act. Outside them, management must make informed decisions with technical specialists at the table, not after the decision has already been made.

That is what effective governance should deliver.

## Trust the people who understand the systems

I agree with Edwin that management needs to take responsibility during a crisis. But taking responsibility does not mean making every decision yourself. Sometimes the most important leadership decision is recognising that somebody else understands the problem better than you do.

Trusting engineers is not abandoning governance. It is making governance useful. Technical professionals must remain accountable, and their decisions should be documented, challenged where appropriate and evaluated afterwards. But adding another management layer does not automatically improve security.

Sometimes it simply increases the time between identifying a problem and doing something about it. And in incident response, time matters.

## Final thoughts

Edwin raises a legitimate concern. Organisations can have excellent technical procedures and still struggle when a serious incident requires difficult business decisions. But I do not believe the answer is to shift the emphasis from incident response to chaos management.

The answer is to connect technical knowledge with decision-making authority. Let management define the risks and boundaries. Let engineers explain the technical reality and lead the technical response. And make sure both sides understand their responsibilities before something goes wrong.

Because engineers may already have detected the problem, understood the consequences and identified how to contain it.

**The real chaos starts when the people who know what needs to be done are not allowed to act, while the people who are allowed to decide do not understand why action is needed now.**

That is not a failure of technology. That is a failure of governance.

And another management framework will not fix it.

---

*This article is a personal response to [Van incident response naar chaos management](https://www.linkedin.com/pulse/van-incident-response-naar-chaos-management-waarom-plannen-ribbers-49ibe/) by Edwin Ribbers. Edwin is a friend whose articles I regularly read and appreciate. We do not have to agree on everything to have a useful discussion. In fact, that is often where the interesting part begins.*
