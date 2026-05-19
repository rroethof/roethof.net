---
title: "DigiD Is Not Sovereign. The Cabinet Knows This and Does Not Care."
slug: "digid-kyndryl-solvinity-cloud-act"
date: "2026-05-19"
lastmod: "2026-05-19"
draft: false
author: "Ronny Roethof"

categories:
- digital-sovereignty
- cybersecurity

tags:
- cloud-act
- identity
- outsourcing
- infrastructure
- procurement
---

On 12 May 2026, a parliamentary committee on Digital Affairs received a petition carrying 196,000 signatures. The subject was the American takeover of DigiD. The cabinet called it standard market dynamics. That answer only works if you don’t look at the system itself.

The transaction is straightforward. Kyndryl acquires Solvinity, the Dutch provider operating infrastructure behind DigiD and MijnOverheid. That stack handles authentication for taxes, UWV, municipalities. Not as a supporting service, but as the entry point.

Formally, very little changes. Data remains in Dutch datacenters. Contracts stay in place. Compliance frameworks still apply. If you stay at that layer, the conclusion holds: nothing material has changed.

You only get a different answer the moment you follow the system instead of the paperwork.

## Where control actually sits

DigiD is a running system. Authentication flows are executed on infrastructure that is continuously updated, patched and redeployed. That process is driven by deployment pipelines, base images and orchestration layers that sit underneath the application itself.

Those mechanisms determine what code runs, under which conditions, and how behaviour evolves over time.

After the acquisition, that operational layer falls under an organisation that ultimately sits inside US jurisdiction. That does not mean the system suddenly behaves differently. It does mean that the legal environment governing how that layer can be influenced has changed.

That distinction matters more than most of the public discussion suggests.

## The runtime layer

The issue is usually framed as a data problem. Where does the data sit, who has access, where are the physical systems located.

That is the wrong level.

DigiD is not sensitive because of storage. It is sensitive because of decision making. Every login is evaluated in real time by software that runs in an environment which is continuously modified around it. In practice, behaviour is shaped not just by application code, but by the surrounding stack that builds it, deploys it and executes it.

That layer is where control resides in modern systems.

If that layer changes ownership, control changes with it.

## The legal environment

Public responses tend to treat foreign jurisdiction as a theoretical risk that requires a concrete trigger.

In practice, it is simply part of the operating context. If an organisation falls under that jurisdiction, it can be compelled to cooperate through mechanisms that do not surface in normal system behaviour. Those mechanisms apply to operational processes just as much as to data access.

That does not imply ongoing interference. It does mean that influence over the system no longer sits exclusively within the original national boundary.

Whether that matters depends on whether you believe contracts and oversight are sufficient to compensate for that shift.

## What this looks like in practice

Nothing breaks. DigiD continues to function, audits continue to pass, availability remains within agreed thresholds. From the outside, it looks like a stable and well-managed system.

The problem is not visible failure. It is the loss of direct observability and control at the layer where behaviour is defined.

If something changes deep in the stack, correctly or incorrectly, detection depends on the same party that operates that stack. Verification becomes indirect.

At that point, the question is no longer whether the system works.

It is whether you can independently prove how it works.

## What the procurement model optimised for

This outcome follows directly from how public sector IT is procured.

The model rewards cost efficiency, compliance and accountability on paper. It does not require retaining independent control over runtime behaviour, because that is difficult to specify and even harder to audit.

So it does not become a deciding factor.

The result is predictable. A capable operator runs the system, improves its quality, and eventually becomes part of a larger corporate structure. The contract remains valid throughout. The technical reality underneath it shifts.

## Why this does not easily reverse

The acquisition itself is not the core issue. It exposes an earlier decision.

For years, critical infrastructure has been externalised under the assumption that specification and governance are enough to retain control. That assumption removed the need to maintain internal engineering capability at the same level.

That is what makes the current situation hard to unwind.

You are no longer just dependent on an external party to operate the system. You are dependent on that party to understand it and to explain it. Reversing that dependency requires rebuilding capability that has been allowed to fade out over time.

## Policy, not an accident

Nothing immediate will fail. The system will continue to meet its targets and pass its audits.

But the combination of external operational control and limited independent verification creates a different risk profile than the one being publicly described.

196,000 people flagged that gap.

The cabinet called it market dynamics.

At this point, continuing down this path isn’t a misunderstanding.

It’s policy.