---
title: "The Dutch Kill Switch: Kyndryl, Solvinity, and the Sovereignty Mirage"
date: 2025-11-10
draft: false
slug: kyndryl-solvinity-sovereignty-kill-switch
tags: ["Sovereignty", "Cloud Act", "Kyndryl", "Solvinity", "Geopolitics", "National Security", "Digital Identity", "CISO Stress", "SPOF"]
categories: ["Cybersecurity", "Technical Deep Dive", "Opinion", "Geopolitics"]
description: "Kyndryl's acquisition of Solvinity and its subsequent claim of a 'sovereign solution' for the Netherlands puts critical infrastructure, including DigiD, JuBIT3, and the AIVD cloud, potentially under US jurisdiction via the CLOUD Act."
---

Kyndryl, the IBM spin-off, has acquired Dutch cloud provider Solvinity and is already marketing the deal as a "sovereign solution" for the Dutch market. This claim is not just misleading; it's a dangerous fiction. Given Solvinity’s client list, which includes the digital backbone of the Dutch state, this acquisition represents a catastrophic failure of operational foresight and a direct threat to national and European security objectives.

The entrepreneur gets a lucrative exit. The Netherlands gets a structural geopolitical risk.

### The Operational Negligence: Willful Vendor Lock-In

This isn't a simple service upgrade; it's a textbook case of operational neglect. The first rule of system administration is to avoid single points of failure. The Dutch state, however, didn't just put all its eggs in one basket, it handed the entire basket to a third party, which has now been acquired by a US-based entity.

*   **Geopolitical SPOF**: For years, the government consolidated its most sensitive services, including DigiD, the Ministry of Justice, and even AIVD infrastructure, into a single provider. This central cloud has now becomeo a single provider and a geopolitical Single Point of Failure (SPOF). If the controller (Kyndryl) is compelled by US law or experiences an operational failure, the Dutch state’s core functions could grind to a halt.

*   **The Monoculture Irony**: In IT, we fight monocultures in code and hardware to build resilience. Yet, for its national identity and security platforms, our government actively embraced one. It was a foolish and arrogant design.

*   **No Exit Strategy**: True operational resilience demands a feasible exit strategy. This acquisition proves there was none. The Dutch state was already locked in, long before the ink on the deal was dry.

### The CLOUD Act: Jurisdiction is the Kernel

Forget the physical location of the data center. That’s just a file system mount point. The real control lies at the kernel level, the legal entity that owns and operates the system. Location is irrelevant when jurisdiction is absolute.

*   **The US as Root User**: The CLOUD Act grants the US government de facto root access to data held by US-controlled companies, regardless of where that data is stored. This is a non-negotiable legal reality.

*   **Data as a Foreign Asset**: Dutch citizens' data is now a liability under a foreign legal framework. The Dutch state chose the illusion of convenience over the hard work of building true sovereignty and resilience.

*   **A CISO's Nightmare**: As IT professionals, we are tasked with managing risk and enforcing segmentation. This political and commercial decision completely bypasses all technical safeguards. The legal architecture is fundamentally broken.

### The Betrayal of the Security Narrative

The hypocrisy is staggering. For years, Solvinity positioned itself as the trusted, independent Dutch provider for sensitive government services.

*   **The Ultimate Contradiction**: Only months ago, Solvinity co-signed a public letter cautioning the government against "te grote afhankelijkheid van grote buitenlandse (lees: Amerikaanse) cloudbedrijven" (too much dependence on large foreign (read: American) cloud companies). They issued the warning, then became the vector for the very threat they described.

*   **Completing the Loop**: By selling to Kyndryl, Solvinity has delivered the exact dependency it warned against. "Independence" was just a marketing term, now rendered obsolete.

### Critical Infrastructure: Structurally Exposed

Solvinity holds the keys to some of the most sensitive systems in the country. Compromising this single vendor now opens the entire administrative backbone of the Netherlands to foreign legal and political pressure.

The new Kyndryl entity now holds a potential kill switch for:

*   **Digital Identity & Governance**: DigiD, MijnOverheid, Digipoort (Logius).
*   **Security & Justice Systems**: Ministry of Justice (JenV) clouds, including the JuBIT3 access platform and CJIB systems.
*   **Regulatory & Intelligence**: Private clouds for the Kansspelautoriteit (Gaming Authority) and the AIVD (General Intelligence and Security Service).
*   **Local Government**: The City of Amsterdam's supposed "sovereign cloud" is now just another American dependency.

### The Enterprise Disease: Compliance Over Resilience

This is the ultimate example of the enterprise disease: prioritizing check-box compliance over hard-earned operational resilience.

*   **The Illusion of Risk Transfer**: The government may believe it has transferred risk to a vendor, but it has actually transferred control to a foreign power.
*   **The 'Sovereign-ish' Label**: Opting for the easy, Kyndryl-stamped 'sovereign' approximation is a classic case of choosing marketing over the hard work of building truly independent, EuroStack-aligned infrastructure.
*   **Post-Mortem Policy**: Logius and the Ministry of the Interior and Kingdom Relations (BZK) are only now "discussing consequences." Risk assessment is happening *after* the deal is announced, not before. This is a reactive posture that guarantees failure and reminds me of all the ignored incident reports that lead directly to burnout.

We knew this was a high-risk configuration. The alerts were ignored. Now, the system is exposed. Accountability must land squarely on the architects of this fragile design. National data is not a commodity for a convenient entrepreneurial exit; it is a fundamental operational dependency. The Dutch state has failed its citizens on basic system architecture. This isn't just a technical failure; it's a failure of sovereignty itself.
