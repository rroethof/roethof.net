---
title: "The Breach After the Breach"
slug: the-breach-after-the-breach
date: 2026-06-08
draft: true
author: "Ronny Roethof"

categories:
- security-privacy
- opinion-reflections

tags:
- dns
- microsoft-365
- email
- data-breach
- sidn

summary: "The Odido breach did not end when the systems were patched. It continued wherever abandoned domains, forgotten mailflows, and expired infrastructure were still trusted."

description: "How expired domains and abandoned Microsoft 365 infrastructure turned the Odido breach into a second-order security risk, exposing sensitive financial and medical correspondence through unmonitored legacy mailflows."
---

In early June 2026, ethical hacker Wesley Neelen published the results of a quiet experiment that should make every IT manager in the Netherlands deeply uncomfortable.

Starting from the Odido data breach, a leak that most people had mentally filed away as someone else's problem, he extracted the e-mail addresses of customers who had listed their financial guardian as their contact. A financial guardian is a court-appointed administrator who manages finances on behalf of people unable to do so themselves.

He then checked whether those guardians' domains were still active.

Many were not.

He registered a handful of expired domains, configured mail reception, and waited.

Within weeks, 258 complete financial dossiers arrived in his inbox. Unsolicited. Automatically. Without a single line of exploit code.

Tax documents. Salary slips. Medical requests. Debt collection summonses. Bailiff notices. Overdue invoices with full call logs attached. In some cases, wills and death certificates. The private financial wreckage of people who were already struggling, handed to whoever registered a domain a former financial guardian had abandoned to save a negligible amount of money.

Neelen closed the mailboxes and reported his findings to RTL Nieuws, who published [a full account of the investigation](https://www.rtl.nl/nieuws/tech/artikel/5608386/bewindvoerder-datalek-schulden-gegevens-op-straat).

He behaved as an ethical researcher should.

The next person who runs this same query, and there will be a next person, may not.

---

## The cascade nobody models

The standard incident response playbook treats a data breach as a contained event. Credentials are rotated, affected users are notified, a post-mortem is written, and the ticket is closed.

What that playbook does not account for is the second-order use of leaked data as reconnaissance material for an entirely separate attack surface.

The breach provided e-mail addresses. Those e-mail addresses pointed to domains. Those domains were unmonitored.

The attack surface was not created by the original breach.

It existed independently.

The breach merely made it findable.

Sandra D., an information security consultant who commented on Neelen's post, described it correctly as a failure of chain security rather than a single incident. The financial guardians did not suffer a breach in the conventional sense. No credentials were stolen. No perimeter was bypassed. A domain expired, ownership changed hands, and incoming mail could then be accepted by whoever registered the domain next.

Wouter Huese offered a similar example in the same discussion: he once registered a .nl domain and started receiving sensitive healthcare correspondence meant for the matching .com address. No breach required. Just a domain mismatch and an absent postmaster.

The pattern is structural, not coincidental.

---

## I recognised the pattern immediately

This failure mode is not hypothetical to me.

During a corporate rebranding and domain migration at a employer, management wanted to decommission the legacy domain and shut down the associated Microsoft 365 tenancy as soon as the migration project was marked complete.

The reasoning was predictable: the migration was finished, maintaining the legacy environment cost money, and supposedly nobody used the old addresses anymore.

Nobody was visibly using them anymore.

That is a very different thing entirely.

I blocked the decommission.

Not because the migration had failed, but because migrations do not erase history. Old supplier records, forgotten SaaS registrations, customer contact databases, mailing lists, cached address books, automated notifications, and years of human habit continue targeting legacy addresses long after a rebrand is officially complete.

Management saw an unused domain and an unnecessary Microsoft 365 tenant.

I saw an abandoned trust relationship waiting to happen.

I renewed the domain myself and configured mail forwarding so that anything still arriving at the old addresses remained visible instead of disappearing silently or ending up in the inbox of whoever might eventually register the domain in the future.

That distinction matters.

An organisation does not stop receiving e-mail when it abandons a domain.

It merely loses control over where that e-mail goes.

The problem is not necessarily incompetence as much as abstraction. To management, a domain often looks like a subscription that can simply be cancelled once the migration project closes. To anyone who understands mail infrastructure, it is closer to abandoning a building while leaving the mail slot active.

Finance departments see cost reduction.

Attackers see unmonitored trust relationships.

---

## Domain lifecycle is not a checkbox

The uncomfortable reality is that many organisations treat domain management as an administrative task rather than a security boundary.

Domains survive mergers. They survive acquisitions. They survive rebranding projects. They survive outsourcing exercises and failed migration documentation. The mail keeps flowing long after the project board marks a transition as complete.

Ronald Eygendaal made the precise regulatory comparison: telephone numbers in the Netherlands carry a mandatory cooling-down period after release. You cannot immediately reassign a recently cancelled number because the risk of misdirection is understood.

Domain names carry no equivalent protection.

SIDN does operate warning systems for sensitive expiring domains, and researchers such as Moritz Müller have spent years drawing attention to this category of risk. The warnings exist.

They are still routinely ignored.

And that is the real issue here.

The technical barrier is almost nonexistent. The operational mitigations are trivial. The problem persists because abandoned infrastructure tends to disappear from budgets before it disappears from reality.

---

## The people at the end of this

The people actually affected by this are worth naming clearly.

Financial guardians manage the affairs of people who can no longer do so themselves due to debt, cognitive disability, or a combination of both. Hundreds of thousands of people in the Netherlands depend on these structures.

They did not choose to have their tax records, medical correspondence, and debt histories routed through poorly maintained domain infrastructure. They had no visibility into whether that infrastructure was still controlled, monitored, or even owned by the original organisation.

And unlike corporations, they do not have legal departments, incident response teams, or cyber insurance waiting in reserve once things go wrong.

That asymmetry is what makes stories like this so uncomfortable.

Not because the attack technique is sophisticated.

But because it is banal.

No malware. No zero-day. No nation-state capability.

Just a forgotten domain and the assumption that nobody would notice.

---

## What this actually costs to prevent

Domain renewal costs almost nothing.

Following up on expiry warnings costs nothing.

Writing a lifecycle policy for domains and mail infrastructure costs an afternoon and perhaps a mildly uncomfortable meeting with management.

The savings from decommissioning old infrastructure are measurable, visible, and easy to justify on a spreadsheet.

The risks created by abandoning trust relationships are delayed, invisible, and usually assigned to someone else.

That is why this keeps happening.

Wesley Neelen acted responsibly.

The next person may not.

The infrastructure conditions that enabled this exposure did not depend on ethical behaviour to exist.

Every organisation that has migrated, merged, rebranded, outsourced, or quietly disappeared over the last decade likely left dormant infrastructure behind somewhere.

And for the cost of a lunch and a free afternoon, anyone can discover what still arrives there.