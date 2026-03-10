---
title: "The Death of the Architect: How AI Hijacks the Technical Soul"
slug: death-of-the-architect-ai-hijacks-technical-soul
date: 2026-03-07
author: Ronny Roethof
category: IT Strategy / Cybersecurity / AI
tags: [Linux, CISO, Pentesting, Ansible, AI, Enshittification, Technical Debt]
---

The internet is becoming a high-speed open sewer. Since the rise of generative AI, everyone can create content with minimal effort - and what we are witnessing now is merely the opening sequence. Meta is rolling out tools for fully automated advertising campaigns: you provide a website, a goal, and a budget, and the system handles everything. Video, images, copy. Not a single human touches the process.

By the end of 2025, analysts estimated that over half of all new digital content was synthetic. The projections are staggering: soon, perhaps 90% of all new internet content will be generated - or at least heavily assisted - by AI.

This has profound implications. It raises an immediate and uncomfortable question: **What can I still trust?**

My prediction is that in a few years, the unfiltered internet will be uninhabitable. We will rely on AI assistants to navigate the noise - a "Great Filter" that searches, assesses relevance, checks for correctness, and only lets information through if it provides genuine value. For businesses and creators, reaching a human audience will mean proving authority, generating community-validated trust, or paying for the privilege. Given the acceleration we are already seeing, I expect this to be a reality within three years.

## The Attack on the Craft

I am not just a strategist observing this from a distance. I am one of the techies. I am the Linux admin, the pentester, and the CISO - with years of hands-on experience in Linux, networking, and infrastructure deployment at scale, including high-stakes, security-critical environments operating under strict duty of confidentiality.

From where I stand, this AI wave is not just threatening marketing or content creation. **It is attacking the core craft of the technical professional.**

We are transitioning from a world of **Automation** to a world of **Autonomy**. These are fundamentally different concepts, and the difference matters more than most organisations currently understand.

In the old paradigm of automation, we wrote the scripts. Whether it was bash, Python, or [complex Ansible playbooks](https://roethof.net/posts/2025/04/ansible-role-linux-hardening/), we were the ones defining the logic. We were the architects. A script only did what we - the human experts - told it to do. It was efficient, but the human brain remained the source of systemic understanding. We knew *why* port 443 needed to be open. We understood the full implications of a specific firewall rule. The [CI/CD pipeline](https://roethof.net/posts/2025/04/building-proper-cicd-pipeline-ansible-roles/) was something we designed, tested, and owned.

In the new paradigm of autonomy, the AI model defines the logic. Tools like Kali Linux are now integrating specialised AI agents that allow a user to simply type, in plain language: *"This is my target, scan it and tell me how to get in."* The AI then plans the network scans, executes the tools, interprets the output, chains vulnerabilities, and presents the attack vector.

The senior expertise is now inside the tool. The barrier to entry for complex technical work - pentesting, infrastructure design, security hardening - is evaporating.

## The Devaluation of Technical Depth

For enterprises, this looks like the ultimate efficiency play. Why hire three senior Linux engineers when one junior with a specialised AI agent can "build" infrastructure ten times faster? Managers look at the speed of deployment and completely ignore operational reality.

This is where the true decay of technology begins.

Cory Doctorow coined the term "enshittification" to describe how platforms deliberately become worse over time to squeeze out more value. We are witnessing the same decay in the technical workforce - and it plays out in three compounding ways.

**The Junior Debt.** When you automate entry-level tasks with AI, you destroy the apprenticeship model. A junior who never manually configures a network interface from an `/etc/` file will never internalise routing logic. They become button-pushers - functional until the AI hallucinates, crashes, or introduces a subtle conflict. At that point, there is nobody left who can open the black box and fix the underlying system. The [ecosystem of automation tooling](https://roethof.net/posts/2025/07/ansible-automation-ecosystem-comparison/) we spent years building was only ever as reliable as the people who understood it.

**Operational Neglect.** Enterprises are building infrastructure that no single human fully understands. AI writes the code, AI deploys the containers, AI writes the documentation. We sacrifice systemic integrity for the sake of speed. When an autonomous agent makes a subtle error in a routing table that creates a dependency loop across data centres, nobody can explain why - because nobody designed the system. You cannot fire an agent, and you cannot debug what you never understood.

**The Black Box Crisis.** As expertise erodes, we move toward infrastructure that engineers simply accept as working - until it doesn't. We already have a name for what this looks like at scale: [Microslop](https://microslop.com). The community did not coin that term out of spite. They coined it because Microsoft started shipping broken, half-tested garbage that bricked systems, corrupted drivers, and introduced regressions a competent engineer would have caught in ten minutes. There is even a [live slop tracker](https://microslop.com/#tracker) documenting the incidents as they happen - Copilot generating broken code with deprecated API calls, Bing flooding search results with hallucinated citations, Windows forcing AI overlays into every interface nobody asked for - from Paint to Notepad.

Then Microsoft tried to ban the word "Microslop" from their official Copilot Discord server. Users bypassed the filter with "Microsl0p" in minutes. Microsoft escalated to banning accounts. Then locked the entire server and wiped two days of message history. The Streisand effect did the rest - the story ran in Fast Company, Gizmodo, PCWorld, Newsweek, and Futurism within hours. You cannot censor your way out of a product quality problem. And the reason the quality problem exists is not a mystery: Microsoft executives have reportedly admitted that 30% of the company's code is now vibe-coded. That is not a boast. That is a confession.

But the deeper problem is the loop it creates. AI trains on web data, generates slop, the slop gets indexed, then the next model trains on that slop. Each iteration produces something worse than the last. The internet becomes a hall of mirrors. When your entire stack is generated by models trained on synthetic code, you invite cascading systemic failures that nobody is equipped to diagnose. Even [running models locally](https://roethof.net/posts/2025/03/run-llama-32-deepseek-and-interact-with-open-webui-locally-with-ollama/) and genuinely understanding their behaviour requires more foundational knowledge than most organisations are willing to develop. Microsoft is not an edge case. It is the preview.

## The Rise of the AI Janitor

In five years - likely less - the role of the technical professional will change dramatically. For those of us with years of deep hands-on experience, the shift will be profound.

**We are not going to be the Makers anymore. We are going to be the Auditors.**

Your value as an engineer will no longer be your ability to write the best Ansible playbook - the AI will generate ten in seconds. Your value will be in your ability to **audit the black box.**

When an autonomous agent misconfigures an ISO 27001-compliant network stack for a healthcare client, the button-pushers will stare blankly at the screen. At that moment, the organisations that survive will be the ones that kept at least a few people who actually understand BGP, kernel modules, and how authentication tokens pass between microservices. We will be the high-paid janitors - the air traffic controllers of the digital world - managing fleets of autonomous agents we did not design and cannot fully predict.

The role will shift from generating system-level trust by building infrastructure, to verifying it by proving the AI did not lie.

## Defending the Integrity

The technical world is currently celebrating the speed of AI generation while ignoring the cost to the underlying craft. We are building a fragile, synthetic infrastructure and calling it progress.

The experts who will matter in five years are not the ones with the best prompts. They are the ones with the most unshakeable understanding of foundational systems. The ones who can look at a network diagram and know in their gut that something is wrong - even when the AI insists it is optimal.

For those of us who grew up understanding how the kernel thinks, the battle is not about becoming obsolete. It is about being the last line of defence.

**Are you building a resilient foundation - or are you just an air traffic controller waiting for a system you never understood to declare an emergency?**  