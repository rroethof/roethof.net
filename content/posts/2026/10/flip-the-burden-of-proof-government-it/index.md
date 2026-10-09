---
title: "Flip the Burden of Proof"
slug: "flip-the-burden-of-proof-government-it"
date: 2026-10-09
lastmod: 2026-10-09
draft: false
author: "Ronny Roethof"
categories: ["digital-sovereignty", "linux-open-source"]
tags: ["cloud-and-ai-development-act", "vng", "open-standards", "vendor-lock-in", "exit-strategy"]
summary: "VNG and IPO want open source requirements in public procurement to count as justified by default. A good step, but only if the law makes it stick."
description: "VNG and IPO want to shift the burden of proof in public procurement. Why that needs a binding legal basis, and what a real exit strategy looks like."
---

*VNG and IPO want open source requirements in public procurement to count as justified by default. Without a binding legal basis, this becomes one more "unless".*

## Years of "unless"

The Netherlands has had "open source, unless" for years. I wrote about [how that principle gets stretched](/posts/2026/08/open-source-unless-oversight-control/) and [how governance can smother it](/posts/2026/08/open-source-until-the-governance-committee-arrives/). The policy exists. Then it gets set aside, quietly, one procurement at a time.

Nobody has to break a rule to do this. The word "unless" is the rule. Whoever buys the software decides whether the exception applies, and it applies often enough that the principle stops meaning anything. That is how a decade of [Dutch digital sovereignty slipped away through procurement](/posts/2026/03/we-did-this-to-ourselves-sovereignty-failure/).

## What VNG and IPO are asking

According to Binnenlands Bestuur's reporting on their joint position paper on the proposed Cloud and AI Development Act (CADA), the Association of Dutch Municipalities (VNG) and the Association of Provinces (IPO) want procurement requirements for open source software and open standards to be considered objectively justified by default.

Today, an established supplier can challenge such a requirement if the contracting authority cannot adequately justify it. VNG and IPO want to shift that burden of proof.

That matters. Procurement is where autonomy is won or lost. A buyer who has to build a legal defence for every open source requirement will eventually stop bothering. The incumbent supplier does not have to win the argument. It just has to make choosing an alternative sufficiently difficult.

## A principle that is up for debate is a preference

A government cannot claim digital autonomy while it is allowed to decide, in every tender, that autonomy does not matter this time. A principle that is renegotiated in every procurement is a preference, not a requirement.

That is why I support the direction but do not trust it yet. A position paper is not law. CADA is still a proposal. If the shift in the burden of proof ends up as guidance or another policy statement, we will have rebuilt "open source, unless" under a nicer name.

The Commission's own text shows how real that risk is. Legal analyses of the proposal describe an "open source first" principle in Article 41, but what it asks of public bodies is to take measures that encourage the use of open source and open standards. Encouraging is not requiring. It is the same soft wording that has let "open source, unless" be set aside for years, now in a legislative proposal. A presumption that favours open source requirements in a tender would be worth far more than a principle that authorities are merely asked to promote.

VNG and IPO also want a framework that leaves governments little room to ignore sovereignty requirements. Their concerns about the proposed assurance levels point to another problem. Only Union Assurance Level 4 explicitly rules out control by a third country or a legal entity established there. For levels 2 and 3, it remains unclear whether foreign legal influence is sufficiently excluded. That leaves a serious question over whether these levels offer the protection critical public services actually need.

Then there is the migration period. The proposal allows up to twelve months when a risk assessment shows that an organisation needs to move to a higher sovereignty level. Anyone who has migrated a real environment knows what that touches: contracts, architecture, integrations, data and the people who have to keep everything running.

A deadline does not make a migration happen. Without realistic transition periods, funding and workable exceptions, you get paper compliance: a document that says you moved and a system that did not.

There is another catch. A government that lacks the knowledge to assess and manage open source software itself is not suddenly going to enforce a presumption in its favour. Changing the rules is one thing. Having the people and technical capability to use them is another.

Dependency is rarely decided in one go. It accumulates through choices that each look defensible, until nobody can operate without the supplier.

## European is not an exit strategy

European suppliers are not automatically a guarantee against vendor lock-in. I have argued the same from the infrastructure side: [portability is not an exit strategy](/posts/2026/09/portability-is-not-an-exit-strategy/) when it only exists on paper. And [nobody does everything themselves](/posts/2026/10/nobody-does-everything-themselves/), so the question is not whether you use a supplier. It is whether you can replace one.

The same applies to the push for more data centres in Europe. VNG and IPO point out that building more capacity on European soil does not automatically give Europe more control over it.

Ownership is only part of the equation. Who operates the infrastructure? Who controls the software? Which legal obligations apply? And can the customer actually move away?

A European address does not answer those questions. Neither does a European logo on a cloud contract. If the infrastructure, software and operational knowledge remain outside your control, you have changed the location of your dependency, not removed it.

## Exit by design

Erwin Beets of integration platform provider WeAreFrank! raised the practical questions in a LinkedIn post. Can another party take over the management? Are interfaces and configurations portable? Can one system be replaced without rebuilding the whole chain?

These are the right questions. But asking a supplier to describe an exit strategy is not enough. Suppliers are very good at describing things.

I would make exit a demonstrable requirement in every government IT tender. Not "describe your exit strategy" but "show me".

Hand over a working configuration to a second party. Restore a service from open formats in a clean environment. Replace one component while the rest keeps running. Show that the documentation is sufficient for someone who did not build the system to take it over.

If a supplier cannot demonstrate that, it has not designed for exit. It has designed for dependency, whatever the brochure says.

Open source helps, but it is not magic. You still need open standards, documentation that a stranger can follow, and someone who is paid to maintain it. You also need the skills to operate what you have chosen.

Open source gives you the right to leave. The work of making leaving possible still has to be done, by design, from day one.

## Sources

- Sjoerd Hartholt, [VNG en provincies vrezen gaten in Europese eisen voor soevereine cloud](https://www.binnenlandsbestuur.nl/digitaal/vng-en-provincies-vrezen-gaten-in-europese-cloud), Binnenlands Bestuur, 7 October 2026.
- VNG, [EU-voorstel voor cloud en AI moet scherper](https://vng.nl/nieuws/eu-voorstel-voor-cloud-en-ai-moet-scherper), 6 October 2026, with the [position paper (pdf, English)](https://vng.nl/sites/default/files/2026-10/position_paper_cloud_and_al_development_act_cada_0.pdf).
- European Commission, [Proposal for the Cloud and AI Development Act (CADA)](https://digital-strategy.ec.europa.eu/en/library/proposal-cloud-and-ai-development-act-cada), COM(2026) 502, 3 June 2026.
- Covington, [The EU Cloud and AI Development Act in depth](https://www.insideglobaltech.com/2026/06/11/the-eu-cloud-and-ai-development-act-in-depth/), 11 June 2026, on the "open source first" principle.
- Erwin Beets, LinkedIn post on the burden of proof and exit requirements in government IT. **Direct URL still to be added before publication.**