---
title: "We Did This To Ourselves"
slug: we-did-this-to-ourselves-sovereignty-failure
date: 2026-03-18
lastmod: 2026-03-19
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
  - belastingdienst
  - fast-enterprises
summary: "A decade of Dutch digital sovereignty surrendered through procurement. From the failed Rijkscloud to the CLOUD Act, and now a state secretary who confirms it in writing and presses on anyway."
description: "Analysis of the systemic failure in Dutch IT policy, highlighting the legal and physical dependencies on US and Chinese infrastructure despite years of expert warnings, and the Kamerbrief that finally put it in writing."
---

Microsoft stood before the French Senate last week and confirmed, under oath, that it cannot guarantee European data will never be disclosed to US authorities.

The room should have erupted. It did not. Because anyone who has been paying attention already knew this. The CLOUD Act has been law since 2018. Not a revelation. A confession of something we collectively decided to ignore for eight years while signing multi-year Microsoft 365 contracts, migrating government infrastructure to Azure, and telling ourselves that a Data Processing Agreement was the same thing as protection.

It is not. It never was. And we did this to ourselves.

This week, we got the definitive proof. Not from a leaked document. Not from a whistleblower. From a Dutch state secretary, in a formal parliamentary letter, about a contract his ministry just signed.

State Secretary Eerenberg confirmed to the Tweede Kamer that American authorities may gain access to the VAT processing system now operated by Fast Enterprises, regardless of where the servers are physically located. His words, not an interpretation. Not a worst-case scenario. A formal written admission. The Kamer asked to stop. Eerenberg is pressing forward. The contract is signed. Stopping costs money.

This is not a data point. This is a confession.

### How We Got Here: A Timeline of Self-Inflicted Wounds

Not a story of sophisticated adversaries outmanoeuvring a vigilant defence. A story of warnings ignored, budgets withheld, and decisions made by people who treated digital infrastructure as a procurement exercise rather than a sovereignty question.

* **2011 -- The Dutch government launches the Rijkscloud initiative.** Sovereign cloud infrastructure for public administration, under Dutch control, on Dutch terms. It dies quietly within two years. No budget. No political will. No follow-through. The first domino falls without anyone noticing.
* **2017 -- China enacts the National Intelligence Law.** Every Chinese company and citizen is now legally obligated to "support, assist and cooperate with national intelligence work." Dutch enterprises and government bodies continue procuring Huawei equipment without a single procurement policy change.
* **2018 -- The US CLOUD Act becomes law.** American authorities can now compel US-based companies to produce data regardless of where it is stored. Frankfurt, Amsterdam, Dublin: does not matter. Dutch government accelerates its Microsoft 365 rollout. Nobody connects the dots.
* **2018 -- Bloomberg reports hardware backdoors in Supermicro motherboards.** The story is disputed but never fully resolved. Dutch datacenters conduct no documented audit of their hardware supply chains. The servers stay in the racks.
* **2021 -- Telecommunications Huawei ban.** The Dutch government pressures providers to remove Huawei from 5G cores. At the same time, Huawei equipment continues to be installed in Dutch hospitals, care facilities, justice institutions, and datacenters. Policy applied to one sector and ignored everywhere else.
* **2023 -- Bert Hubert presents Cloud Kootwijk to the Tweede Kamer.** Sovereign infrastructure for email, chat, and file sharing. Not a moon shot. A working minimum. The Kamer passes supportive motions. No budget is allocated. Nothing is built. The 2011 script repeats verbatim.
* **2024 -- SIDN migrates to Amazon Web Services.** The foundation responsible for .nl moves to AWS because it is "cheaper and easier." The Tweede Kamer votes to block it. SIDN, a private foundation, ignores them. The registration system stays on AWS.
* **2025 -- The Belastingdienst migrates to Microsoft 365.** The organisation holding financial records on every person and business in the Netherlands runs its daily communications on servers subject to US law. Approved at the highest level. Celebrated as modernisation.
* **2026 -- The Belastingdienst signs a 20-year, 190 million euro contract with Fast Enterprises** for the system that processes eighty billion euros in annual VAT revenue. The Kamer raises sovereignty concerns. The state secretary acknowledges them, confirms American authorities can legally access the system, and signs anyway. Stopping costs money.
* **2026 -- Microsoft confirms under oath what has been true since 2018.** It is reported as news.

### The Sunk Cost State

Parliament asked to stop. The state secretary is pressing forward.

The reasoning is explicit: the contract is signed, stopping costs money, so we continue. The sunk cost fallacy, elevated to official policy. It is never too late to stop a bad decision, but it requires acknowledging the decision was bad, and that is not something Dutch procurement culture does.

You have seen this logic before. You will see it again. It drove the toeslagenaffaire. It drove Diginotar. It drives every Dutch IT procurement catastrophe in this series: the decision was made, the political cost of reversal exceeds the political cost of exposure, so we document the risk and proceed. Eerenberg's letter is that document. Filed. Archived. Forgotten.

The people who made these decisions will not bear the consequences. The procurement manager who signed the Fast Enterprises contract will not be in the room if Dutch VAT data surfaces under a CLOUD Act request. Risk exported downward. Convenience flowing up.

### The Actual Danger: Concrete, Not Theoretical

The sovereignty conversation tends to stay abstract. Here it is concrete:

* **VAT Infrastructure:** Eighty billion euros in annual VAT revenue processed by a system the Dutch state does not own, cannot audit at code level, and cannot exit. American authorities can compel access. The state secretary confirmed this in writing and proceeded.
* **Financial Records:** The Belastingdienst knows your income, assets, business structure, and debts. All of it now lives in Microsoft's infrastructure. US authorities can compel access. The tax authority of a sovereign nation is dependent on infrastructure a foreign government can reach into.
* **Parliamentary Function:** The Tweede Kamer has moved its communications to Microsoft 365. There is now a red button in America. Press it, and Dutch parliamentary function grinds to a halt.
* **Judicial and Medical Infrastructure:** Dutch Ministry of Justice locations and hospitals run on Huawei hardware. Judicial data and patient records are processed on hardware from a company with a statutory obligation to cooperate with Chinese state intelligence.
* **Physical Layer:** Physical Layer: Amsterdam is dominated by Equinix and Digital Realty, both American and both subject to the CLOUD Act. Dutch-owned alternatives like EvoSwitch were sold to Americans. Serverius was sold to Scandinavian private equity. Independent Dutch providers still exist, True Fullstack being one of them, but the government is not using them at scale. The physical layer of Dutch government IT is not Dutch.

### The Engineers Were Right. Nobody Listened.

Bert Hubert explained it. The people who tried to build the Rijkscloud in 2011 knew. The security architects who flagged the CLOUD Act in 2018 knew.

In every case, the response was the same: too expensive, too difficult, not now, the vendor's assurances are sufficient. Sign the contract. The knowledge was present in the room and overruled by managers who did not understand the technical consequences.

The Fast Enterprises decision follows the same script. Experts flagged it. The Kamer motioned against it. The state secretary acknowledged the risk and signed anyway. Not out of ignorance this time. Out of indifference dressed as pragmatism.

### The Unpopular Truth

Nobody wants to talk about Washington. Microsoft, AWS, Google, and Fast Enterprises are US companies subject to US law. The CLOUD Act requires no hostile intent. It requires a lawyer and a business day. A trade dispute or a political calculation in Washington can become a legal instrument pointed at European data. This week, the American Congress is subpoenaing tech companies for their communications with European regulators. That is not a background detail. That is the environment in which Eerenberg signed a twenty-year contract.

The panic about Huawei pushed European enterprises toward American hyperscalers. Out of one jurisdictional dependency and into another, this time with better marketing and a friendlier flag on the invoice.

### The Next Set of Keys

The European digital sovereignty agenda, GAIA-X, Data Act, NIS2, is presented as the solution. But who controls the European layer?

Handing keys to an unelected Commission in Brussels is the same mistake made with AWS and Microsoft, just dressed in the colours of the EU flag. Sovereignty concentrated in Brussels is not Dutch sovereignty. The accountability deficit is the same.

### We Are Fucked. And It Is Our Own Fault.

The Dutch government had a Rijkscloud in 2011. It chose not to build it. It had eight years to respond to the CLOUD Act. It chose not to. It had Cloud Kootwijk in 2023. It chose not to. It had a parliamentary motion against the Fast Enterprises contract in 2026. It chose not to.

And now a state secretary has written it down. Formally. To parliament. American authorities can access the system. The contract stands.

We handed the keys over ourselves. Both sets. To both sides. The state secretary just confirmed it in writing and told us to move on.

The least we can do now is bend over, take it like a man and enjoy the consequences.

### Author's Note

This is part of an ongoing series on systemic failures in Dutch digital governance. For deeper context on the individual threads pulled together here, see:

* *"The Apeldoorn Illusion: A Post-Mortem of Dutch Digital Sovereignty"* ([roethof.net](https://roethof.net/posts/2026/03/unconscious-incompetence-apeldoorn-illusion-deep-dive/)) -- the Fast Enterprises decision in detail, before the Kamerbrief confirmed it
* *"The Dutch Kill Switch: Kyndryl, Solvinity, and the Sovereignty Mirage"* ([roethof.net](https://roethof.net/posts/2025/11/kyndryl-solvinity-sovereignty-kill-switch/)) -- how outsourcing creates dependencies the government cannot exit
* *"The Digital Trump Moment: The Bill for Our Collective Negligence Is Due"* ([roethof.net](https://roethof.net/posts/2026/01/digital-trump-moment-sovereignty-bill-due/)) -- the geopolitical context that makes all of this matter right now