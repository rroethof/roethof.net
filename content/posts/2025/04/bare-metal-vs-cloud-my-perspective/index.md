---
title: "Cloud or Bare Metal? My Case for Control, Sovereignty, and Sanity"
date: "2025-04-06T16:03:00+02:00"
draft: false
slug: "bare-metal-vs-cloud-my-perspective"
tags:
  - Bare Metal
  - DevOps
  - Digital Sovereignty
  - Linux
  - Open Source
  - Security
  - Self-Hosting
categories:
  - DevOps & Infrastructure
  - My Perspective
  - Security & Privacy
  - System Management
---

## Cloud vs. Bare Metal: My Hard-Won Wisdom

Let's be honest: the cloud isn't always the convenient solution it's made out to be. Years of building and securing systems have taught me that the supposed "convenience" often masks hidden costs and a serious lack of control. I've seen those crazy invoices, it's like dark magic! My friends at [Technative](https://technative.eu/) help companies navigate this, but I've seen the downsides firsthand.

### The Illusion of Convenience: Control and Sovereignty

It's about more than just money; it's about *control*. When we use the cloud, we're handing over our data, our infrastructure, and our sovereignty. Even the Dutch government is exploring a national cloud ([Dutch Government Article](https://www.ictmagazine.nl/nieuws/rijksoverheid-onderzoekt-noodzaak-soevereine-overheidscloud/)) because they're realizing this too.

Articles like [this one](https://berthub.eu/articles/posts/mailen-en-communiceren-zonder-musk-en-trump-cloud-kootwijk/) about escaping big tech only reinforce this point. It's not just about the price tag; it's about *who* controls your data. And I've learned a fundamental truth: if you didn't build it, you don't control it.

This lack of control extends beyond simple cost considerations. It delves into the realm of data sovereignty and the potential for government surveillance. The Foreign Intelligence Surveillance Act (FISA), specifically Section 702, grants the NSA direct access to data held by cloud providers, a chilling reality. ([More on FISA 702](https://en.wikipedia.org/wiki/Section_702_of_the_FISA_Amendments_Act_of_2008)).

A friend of mine put it perfectly: **"Building a sovereign cloud in an American data center is like putting a safe in the FBI's living room, you might have the key, but they own the house."** 

He also wisely pointed out: **"Building a sovereign cloud on American software is like building a fortress on American foundations, no matter how European the walls are, the gate remains out of your control."**

### My VPS Experiences: A Costly Lesson in Scalability

I've used smaller VPS providers (Tilaa, Versio, Hetzner), they're great for simple projects like a personal blog. But for my work, DNS, mail, multiple web servers, the costs quickly spiraled out of control. Three DNS servers at €10/month each? It adds up fast. Managing them all became a nightmare.

My experience as a pentester and security officer only made the risks even clearer. This experience underscored the limitations of relying on multiple VPS providers for complex infrastructure. The management overhead and escalating costs ultimately led me to seek a more sustainable and controlled solution.

### The Serverius Solution: Colocation and Regaining Control

That's why I moved to colocation at Serverius. I'm a happy customer, and I've referred many friends and companies. They're also committed to sustainability ([Serverius About Us](https://serverius.net/about-us/)), which is important to me.

I have a solid security plan in place ([see my Ansible role for basic Linux hardening](posts/2025/04/ansible-role-linux-hardening/)), and robust monitoring. My Dell R430 is the heart of it all. The transition to Serverius wasn't just about cost savings; it was about regaining control over my infrastructure and prioritizing data security.

### Beyond the Price Tag: Environmental Impact and Security Risks

The cloud's "convenience" comes at a hidden cost. The environmental impact of massive data centers is undeniable, and the privacy implications are even more alarming.

Beyond the financial aspects, the environmental footprint and security vulnerabilities of large-scale cloud providers are significant concerns. My experience as a security officer and pentester has made me acutely aware of these risks. The inherent complexities of large-scale systems, coupled with the potential for government access to data (as highlighted by FISA Section 702), make a strong case for greater control and transparency.

### A Personal Journey: Ergonomics, Burnout, and the Need for Sanity

My journey with Tietze's syndrome ([my ergonomic keyboard quest](posts/2025/03/my-quest-for-ergonomic-bliss-a-journey-to-find-a-split-keyboard-that-works-with-tietses-syndrome/)) and my heart attack in 2024 ([my burnout story](posts/2025/03/the-sleep-deprived-sysadmin-how-lack-of-sleep-affects-performance-productivity-and-security/)) taught me the importance of balance.

It's not just about being a good sysadmin; it's about being a good human. And that includes controlling my data. This personal journey has underscored the importance of prioritizing well-being alongside technical expertise. The relentless demands of the IT world can easily lead to burnout, impacting both professional performance and personal life.

### My Choice: Bare Metal, Sovereignty, and Sanity

I'm not against the cloud entirely. But for my core systems, bare metal and colocation at Serverius are the right choice for me. It's about reclaiming control, prioritizing data sovereignty, and ensuring my systems are built and maintained according to my own standards.

I'm using Matrix, Mastodon, and Nextcloud for communication ([my messaging app thoughts](posts/2025/03/a_critical-look-at-messaging-apps-signal-whatsapp-telegram-and-matrix/)), and contributing to open source ([why I love open source](posts/2025/03/contributing-to-open-source/)) because I believe in community. My 3D printing hobby ([my 3D printing adventures](posts/2025/03/unlocking-inner-creator-techie-3d-printer/)) taught me the value of building things myself. This approach aligns with my values of transparency, control, and community engagement.

This isn't about rejecting technology; it's about choosing the right tools for the job and prioritizing what truly matters: control, sovereignty, and sanity. And for me, that means embracing bare metal.

**Coming Soon:** I'm planning to share my experiences with virtualization in two upcoming posts:

*   **Migrating from VMware to Proxmox:** A step-by-step guide on how and why to move virtual machines from VMware to Proxmox.
*   **Proxmox vs. VMware:** A detailed comparison of these two popular virtualization platforms.

Stay tuned!

## References and Links

*   **Serverius:** [https://serverius.net/about-us/](https://serverius.net/about-us/)
*   **Technative:** [https://technative.eu/](https://technative.eu/)

### Government Links

*   **Dutch Government Cloud Initiative:** [https://www.ictmagazine.nl/nieuws/rijksoverheid-onderzoekt-noodzaak-soevereine-overheidscloud/](https://www.ictmagazine.nl/nieuws/rijksoverheid-onderzoekt-noodzaak-soevereine-overheidscloud/)
*   **Mailen en communiceren zonder Musk en Trump cloud Kootwijk:** [https://berthub.eu/articles/posts/mailen-en-communiceren-zonder-musk-en-trump-cloud-kootwijk/](https://berthub.eu/articles/posts/mailen-en-communiceren-zonder-musk-en-trump-cloud-kootwijk/)
*   **FISA Section 702:** [https://en.wikipedia.org/wiki/Section_702_of_the_FISA_Amendments_Act_of_2008](https://en.wikipedia.org/wiki/Section_702_of_the_FISA_Amendments_Act_of_2008)

### Internal Links

*   **My Ergonomic Keyboard Quest:** [https://roethof.net/posts/2025/03/my-quest-for-ergonomic-bliss-a-journey-to-find-a-split-keyboard-that-works-with-tietses-syndrome/](https://roethof.net/posts/2025/03/my-quest-for-ergonomic-bliss-a-journey-to-find-a-split-keyboard-that-works-with-tietses-syndrome/)
*   **My Burnout Story:** [https://roethof.net/posts/2025/03/the-sleep-deprived-sysadmin-how-lack-of-sleep-affects-performance-productivity-and-security/](https://roethof.net/posts/2025/03/the-sleep-deprived-sysadmin-how-lack-of-sleep-affects-performance-productivity-and-security/)
*   **My Messaging App Thoughts:** [https://roethof.net/posts/2025/03/a_critical-look-at-messaging-apps-signal-whatsapp-telegram-and-matrix/](https://roethof.net/posts/2025/03/a_critical-look-at-messaging-apps-signal-whatsapp-telegram-and-matrix/)
*   **Why I Love Open Source:** [https://roethof.net/posts/2025/03/contributing-to-open-source/](https://roethof.net/posts/2025/03/contributing-to-open-source/)
*   **My 3D Printing Adventures:** [https://roethof.net/posts/2025/03/unlocking-inner-creator-techie-3d-printer/](https://roethof.net/posts/2025/03/unlocking-inner-creator-techie-3d-printer/)
*   **My Ansible Role for Basic Linux Hardening:** [https://roethof.net/posts/2025/04/ansible-role-linux-hardening/](https://roethof.net/posts/2025/04/ansible-role-linux-hardening/)
