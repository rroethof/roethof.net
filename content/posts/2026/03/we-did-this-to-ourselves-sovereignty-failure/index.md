---
title: "We Did This To Ourselves"
slug: we-did-this-to-ourselves-sovereignty-failure
date: 2026-03-18
lastmod: 2026-03-18
draft: false
author: "Ronny Roethof"
categories:
  - digital-sovereignty
  - security-privacy
tags:
  - cloud-act
  - microsoft-365
  - azure
  - huawei
  - sidn
summary: "A decade of Dutch digital sovereignty surrendered through procurement. From the failed Rijkscloud to the CLOUD Act: how we ignored every warning sign."
description: "Analysis of the systemic failure in Dutch IT policy, highlighting the legal and physical dependencies on US and Chinese infrastructure despite years of expert warnings."
---

Microsoft stood before the French Senate last week and confirmed, under oath, that it cannot guarantee European data will never be disclosed to US authorities.

The room should have erupted. It did not. Because anyone who has been paying attention already knew this. The CLOUD Act has been law since 2018. Not a revelation. A confession of something we collectively decided to ignore for eight years while signing multi-year Microsoft 365 contracts, migrating government infrastructure to Azure, and telling ourselves that a Data Processing Agreement was the same thing as protection.

It is not. It never was. And we did this to ourselves.

### How We Got Here: A Timeline of Self-Inflicted Wounds

Not a story of sophisticated adversaries outmanoeuvring a vigilant defence. A story of warnings ignored, budgets withheld, and decisions made by people who treated digital infrastructure as a procurement exercise rather than a sovereignty question.

* **2011 — The Dutch government launches the Rijkscloud initiative.** Sovereign cloud infrastructure for public administration, under Dutch control, on Dutch terms. It dies quietly within two years. No budget. No political will. No follow-through. The first domino falls without anyone noticing.
* **2017 — China enacts the National Intelligence Law.** Every Chinese company and citizen is now legally obligated to “support, assist and cooperate with national intelligence work.” Dutch enterprises and government bodies continue procuring Huawei equipment without a single procurement policy change.
* **2018 — The US CLOUD Act becomes law.** American authorities can now compel US-based companies to produce data regardless of where it is stored. Frankfurt, Amsterdam, Dublin: does not matter. Dutch government accelerates its Microsoft 365 rollout. Nobody connects the dots.
* **2018 — Bloomberg reports hardware backdoors in Supermicro motherboards.** The story is disputed but never fully resolved. Dutch datacenters conduct no documented audit of their hardware supply chains. The servers stay in the racks.
* **2021 — Telecommunications Huawei ban.** The Dutch government pressures providers to remove Huawei from 5G cores. Simultaneously, Huawei equipment continues to be installed in Dutch hospitals, care facilities, justice institutions, and datacenters. Policy applied to one sector and ignored everywhere else.
* **2023 — Bert Hubert presents Cloud Kootwijk to the Tweede Kamer.** Sovereign infrastructure for email, chat, and file sharing. Not a moon shot. A working minimum. The Kamer passes supportive motions. No budget is allocated. Nothing is built. The 2011 script repeats verbatim.
* **2024 — SIDN migrates to Amazon Web Services.** The foundation responsible for .nl moves to AWS because it is "cheaper and easier." The Tweede Kamer votes to block it. SIDN, a private foundation, ignores them. The registration system stays on AWS.
* **2025 — The Belastingdienst migrates to Microsoft 365.** The organization holding financial records on every person and business in the Netherlands runs its daily communications on servers subject to US law. Approved at the highest level. Celebrated as modernisation.
* **2026 — Microsoft confirms under oath what has been true since 2018.** It is reported as news.

### The Actual Danger: Concrete, Not Theoretical

The sovereignty conversation tends to stay abstract. Here it is concrete:

* **Financial Records:** The Belastingdienst knows your income, assets, business structure, and debts. All of it now lives in Microsoft's infrastructure. US authorities can compel access. The tax authority of a sovereign nation is operationally dependent on infrastructure a foreign government can reach into.
* **Parliamentary Function:** The Tweede Kamer has moved its communications to Microsoft 365. There is now a red button in America. Press it, and Dutch parliamentary function grinds to a halt.
* **Judicial & Medical Infrastructure:** Dutch Ministry of Justice locations and hospitals (BovenIJ, Tjongerschans) run on Huawei hardware. Judicial data and patient records are processed on hardware from a company with a statutory obligation to cooperate with Chinese state intelligence.
* **Physical Layer:** Amsterdam is dominated by Equinix and Digital Realty (American, CLOUD Act). Dutch-owned alternatives like EvoSwitch were sold to Americans. Serverius was sold to Scandinavian private equity. The physical layer of the Dutch internet is not Dutch.

### The Engineers Were Right. Nobody Listened.

Bert Hubert explained it. The people who tried to build the Rijkscloud in 2011 knew. The security architects who flagged the CLOUD Act in 2018 knew. 

In every case, the response was the same: too expensive, too difficult, not now, the vendor's assurances are sufficient. Sign the contract. The knowledge was present in the room and overruled by managers who did not understand the technical consequences.

The people who made these decisions will not bear the consequences. The procurement manager who signed the M365 contract will not be in the room if Dutch tax data surfaces under a CLOUD Act request. Risk exported downward. Convenience flowing up.

### The Unpopular Truth

Nobody wants to talk about Washington. Microsoft, AWS, and Google are US companies subject to US law. The CLOUD Act requires no hostile intent; it requires a lawyer and a business day. A trade dispute or a political calculation in Washington can become a legal instrument pointed at European data.

The panic about Huawei pushed European enterprises toward American hyperscalers. Out of one jurisdictional dependency and into another, this time with better marketing and a friendlier flag on the invoice.

### The Next Set of Keys

The European digital sovereignty agenda (GAIA-X, Data Act, NIS2) is presented as the solution. But who controls the European layer? 

Handing keys to an unelected Commission in Brussels is the same mistake made with AWS and Microsoft, just dressed in the colours of the EU flag. Sovereignty concentrated in Brussels is not Dutch sovereignty. The accountability deficit is the same.

### We Are Fucked. And It Is Our Own Fault.

The Dutch government had a Rijkscloud in 2011. It chose not to build it. It had eight years to respond to the CLOUD Act. It chose not to. It had Cloud Kootwijk in 2023. It chose not to.

We handed the keys over ourselves. Both sets. To both sides. The least we can do now is bend over, take it like a man and enjoy the consequences.