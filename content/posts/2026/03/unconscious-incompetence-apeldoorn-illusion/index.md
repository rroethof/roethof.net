---
title: 'The Apeldoorn Illusion: A Post-Mortem of Dutch Digital Sovereignty'
slug: unconscious-incompetence-apeldoorn-illusion-deep-dive
date: 2026-03-06
lastmod: 2026-03-06
draft: false
author: Ronny Roethof
categories:
- security-privacy
tags:
- enterprise
- systemic-failure
- it
- ciso
- accountability
summary: A post-mortem of Dutch digital sovereignty failures, exploring enterprise
  and systemic IT accountability.
description: Exploring how Dutch digital sovereignty initiatives fail in practice
  and what enterprise IT can learn from systemic governance issues.
---

The Dutch government has developed a new strategy for managing critical infrastructure, which I personally call **the digital fuckups**. The recent decision to hand the core of the Netherlands' VAT collection system to the American firm Fast Enterprises is not a strategic partnership. It is a structural collapse of governance, driven by high workload pressure and profound, "unconscious incompetence" at the highest levels of the state.

### The Fable of the Physical Server

State Secretary Eelco Eerenberg keeps reassuring Parliament: "The servers are in Apeldoorn." Technically true, operationally meaningless. This is 20th-century thinking: a server is a box you can lock in a room. In the 21st century, power lives in the management layer, in proprietary code, automated pipelines, and remote administrative access—all governed by the US Cloud Act.

When the Dutch government claims security because the data sits in Apeldoorn, they are performing **compliance theater**. If the management layer is American, the system is American. If the update keys are in Washington, the system is in Washington. If Fast Enterprises decides tomorrow that Dutch fiscal logic isn’t worth maintaining, the servers in Apeldoorn are just expensive paperweights.

### The Psychology of Unconscious Incompetence

Why does this keep happening? There’s a recurring theme: a fundamental lack of IT literacy among decision-makers. This is **unconscious incompetence**. Leaders treat IT like water: you turn the tap, and the VAT comes out. They do not understand that software is a living liability needing constant, autonomous control. Outsourcing the "thinking" parts of your tax system to a foreign entity is renting your sovereignty.

This incompetence is worsened by the "Productivity vs. Security" paradox. The Belastingdienst is under immense pressure: legacy systems rotting, staff overworked, and political promises demanding instant results. The "quick fix" of an American package looks like salvation. In enterprise terms, it’s a trap. Choosing **Fast** over **Resilient** trades long-term national security for a short-term political win.

### The Architecture of Dependency

Experts like Bert Hubert and Marcel van Kooten have been sounding alarms. The Dutch government claims "control of all data traffic." Modern software is opaque; you cannot check the traffic of a proprietary black box to know if a backdoor exists or a kill-switch is embedded in a mandatory update.

Every tax law change now requires American permission. The Netherlands has privatized legislative execution. If the US leverages this dependency during a trade dispute, the Netherlands has zero leverage. We handed over the keys to the front door, back door, and safe.

- Computable reconstructie: [Digitale autonomie en de uitbesteding applicatiediensten omzetbelasting door de Staat](https://www.computable.nl/2026/02/24/digitale-autonomie-en-de-uitbesteding-applicatiediensten-omzetbelasting-door-de-staat/)
- Security.nl coverage: [Belastingdienst onder vuur over keuze voor Amerikaans beheer btw-systeem](https://www.security.nl/posting/926483/Belastingdienst+onder+vuur+over+keuze+voor+Amerikaans+beheer+btw-systeem)

### Operational Neglect and Skill Erosion

By outsourcing, the government ensures no Dutch civil servant will ever truly understand the VAT system at a code level. We are training a generation of **contract managers** powerless when the vendor stops performing. This is operational neglect on a grand scale.

### Compliance vs. Resilience Gap

The government says: "We are compliant." Compliance is **not security**. You can be ISO-compliant and still be completely vulnerable. Resilience is independent recovery. If Fast Enterprises disappears, the Netherlands cannot recover. No internal team can take over the codebase. No European alternative is ready.

### Political Smokescreen

Barbara Kathmann’s motion shows the divide: those who understand the stakes vs. those who want the problem gone. "This question is not one-dimensional," says Eerenberg. It is one-dimensional: ownership. Either you own your core systems, or you don't.

### Lessons from the Public Discourse

Public reaction has been intense and varied. Some comments highlight corruption concerns, dependency on US Big Tech, and lost internal expertise. The debate spans multiple platforms:

- Volkskrant: [Amerikaanse regering bouwt samen met techbedrijven aan surveillancestaat](https://www.volkskrant.nl/columns-opinie/amerikaanse-regering-bouwt-samen-met-techbedrijven-aan-surveillancestaat~bd6d2da1/)
- Herprogrammeer de Overheid: [Digitale toekomst van Nederland](https://www.herprogrammeerdeoverheid.nl)
- NRC.nl: ["Koop europees in" wordt straks hard beleid Brussel](https://www.nrc.nl/nieuws/2026/02/27/leus-koop-europees-wordt-straks-hard-beleid-brussel-wil-europese-inkoop-verplichten-a4921324)

### Conclusion: Reclaiming the Spine

The Ministry of Finance must admit they were out-negotiated because they didn’t understand the technology. They need lawyers, exit fees, and a European or internal alternative. Slower, more expensive, harder, but the only way to secure sovereignty. Rushed fixes like the QR-vaccination system show the dangers.

**Bottom line:** Physical presence in Apeldoorn is a red herring. If you don’t own the management, the code, and the lifecycle, you are not a partner. You are a tenant at the mercy of a landlord three thousand miles away. Stop the theater. Build a digital spine that belongs to us.

### Author’s Note

This continues my ongoing series on systemic failures in enterprise environments. For analysis on workload pressure, operational neglect, and the strategic security paradox, see:

- *"Burnout in Cybersecurity: The Crisis We’re Still Ignoring"* ([roethof.net](https://roethof.net/posts/2025/04/burnout-cybersecurity-crisis-still-ignored/))
- *"The Dutch Kill Switch: Kyndryl, Solvinity, and the Sovereignty Mirage"* ([roethof.net](https://roethof.net/posts/2025/11/kyndryl-solvinity-sovereignty-kill-switch/))
- *"The Sleep-Deprived Sysadmin: A Personal Journey Through Burnout and Recovery"* ([roethof.net](https://roethof.net/posts/2025/03/the-sleep-deprived-sysadmin-how-lack-of-sleep-affects-performance-productivity-and-security/))