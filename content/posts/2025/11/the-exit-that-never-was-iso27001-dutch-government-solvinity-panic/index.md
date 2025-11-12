---
title: "The Exit That Never Was: ISO27001, the Dutch Government, and the Solvinity Panic"
date: 2025-11-12
tags:
- ISO27001
- Cloud
- Government
- Exit Strategy
- Solvinity
- Digital Sovereignty
draft: false
slug: the-exit-that-never-was-iso27001-dutch-government-solvinity-panic
categories:
- Security & Privacy
- Government
- Risk Management
---

This post follows my earlier analysis, [“The Dutch Kill Switch: Kyndryl, Solvinity, and the Sovereignty Mirage”](/posts/2025/11/kyndryl-solvinity-sovereignty-kill-switch), where I discussed the risks of critical Dutch infrastructure being exposed to foreign control and the illusion of digital sovereignty.

The recent acquisition of Dutch cloud provider **Solvinity** by the American company **Kyndryl** has triggered panic in government circles, headlines about “sovereignty at risk,” and heated public debate. And yet, here’s the kicker: the Dutch government demands strict compliance with ISO27001, NEN standards, BIO, and other frameworks from every supplier standards that explicitly **require an exit strategy**.  

Based on media coverage and public reporting—including an article by *RTL Z* titled [*“‘Persoonlijk bedonderd’: Justitie en Amsterdam ‘onaangenaam verrast’: Nederlands cloudbedrijf in Amerikaanse handen”*](https://www.rtl.nl/nieuws/economie/artikel/5538468/zorgen-bij-ministerie-en-gemeente-amsterdam-over-amerikaanse) it is highly implausible that a fully tested and operational exit strategy exists for critical services such as **DigiD**, **MijnOverheid**, or the **AIVD cloud hosting**.  

Time to **practice what you preach**. ISO27001 compliance is not a badge. It’s a blueprint. And the blueprint has not been followed internally. Compliance on paper does not equal operational resilience.

## ISO27001 and Exit Strategies: The Bare Minimum (ISO 27001:2022)

For those who drill down into standards, this failure is explicitly covered in Annex A, Controls **A.5.19** to **A.5.23** (Supplier Management) of the **ISO/IEC 27001:2022** standard (formerly A.15 in 2013). Specifically:

- **A.5.21: Managing information security for use of cloud services**  
  Organizations must define and agree upon information security requirements for cloud service acquisition and use, which inherently covers **exit planning and continuity**.

- **A.5.22: Monitoring, review and change management of supplier services**  
  Organizations must regularly monitor, review, and manage changes to supplier services, including addressing risks from changes in ownership or control (like the Kyndryl acquisition).

- **Mandatory Exit Strategy**  
  While the 2022 version integrated the explicit ‘Exit Strategy’ control (A.15.2.4 in 2013) into supplier and cloud security requirements, the core mandate remains: **a tested plan to ensure continuity and protect information assets if a supplier relationship ends**.

This is **not optional**. Yet, based on public signals, it appears **the government has no operational exit plan for its most critical cloud services**.

## How the Government Failed

The issue is systemic:

- **Monoculture dependency:** multiple critical services rely on a single cloud provider.
- **No tested exit procedure:** contracts may include legal clauses, audits may exist, but operational execution—data migration, fallback procedures, disaster recovery & business continuity's ignored.
- **Compliance vs. reality:** being “ISO27001 compliant” on paper does not prevent a governance or operational crisis when ownership changes.

Result: panic. And rightly so. But the crisis **could have been avoided** if basic standards were actually implemented. The government lectures suppliers on exit planning while sitting on a ticking dependency bomb.

## What a Proper Exit Strategy Looks Like

A truly operational exit strategy includes:

- **Data migration plans:** how to safely move critical information if a supplier changes ownership.
- **Fallback procedures:** maintain core operations on alternative platforms (even temporarily offline or on paper).
- **Disaster recovery & business continuity:** tested, realistic, and actionable.
- **Legal & jurisdictional analysis:** mitigating risks like the **CLOUD Act** or other foreign legal claims.
- **Supplier diversification & stewardship:** multi‑vendor setups or steward‑owned providers reduce strategic dependency.

## Lessons Learned

- **Lead by example:** ISO27001 requires it. Test it, don’t just document it.
- **Don’t panic after the fact:** proactive exit planning prevents operational and reputational disasters.
- **Rethink “sovereignty”:** it’s not marketing—true digital sovereignty is operational and contractual, not just a label.

The **Solvinity/Kyndryl** case is a warning, not a surprise. It’s a **self-inflicted risk** for anyone who thought compliance equals resilience.  

  *Lead by example. Fail by example. Don’t let compliance theater replace actual operational resilience.*
