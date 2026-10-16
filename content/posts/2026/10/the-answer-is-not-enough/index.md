---
title: "The Answer Is Not Enough"
slug: "the-answer-is-not-enough"
date: 2026-10-06
lastmod: 2026-10-06
draft: false
author: "Ronny Roethof"
categories: ["ai-tech-insights", "opinion-reflections"]
tags: ["ansible", "llm", "stigmergy", "ai-assisted-work", "linkedin"]
summary: "Using AI to help you think makes you stronger. Using it so you don't have to think makes you dependent on something you don't understand."
description: "A reflection on AI shame, ownership of your work and why the calculation matters as much as the answer, prompted by two LinkedIn posts."
---

*Using AI to think better is not the same as using it so you don't have to.*

I was not planning to write about AI today. Then I read a LinkedIn post by [Kylian Martens](https://www.linkedin.com/in/kylian-martens-932443138/) that changed my mind.

## A presentation that looks like AI made it

Kylian's family had told him to be careful, because the presentation he had prepared for a job interview looked very AI-generated. His answer was, in essence: I know, and I don't care. I liked that, and not because I think everything AI produces is automatically good. Quite the opposite. I liked it because I recognise the reasoning behind it. Kylian had made the presentation himself. He decided what the story was, what the flow should be and what he wanted to say. Claude helped with additions, consistency and the visual side. He used AI to remove some of the tedious work without handing over ownership of the story.

I replied that this is exactly where I see the difference. I use AI myself, to brainstorm, to challenge my thinking, to find things I may have missed, to improve my language and, occasionally, to make something look considerably less ugly than what I would have produced alone. There is nothing wrong with that.

## The calculation matters

Kylian's answer to my reply stayed with me. He compared it to mathematics: AI can give you the answer, but the calculation is at least as important as the answer. That is the part of the AI discussion I think we are missing. We are becoming very good at producing answers, perhaps too good. Ask an AI to write an Ansible role and it will happily produce one. Ask it to explain a security finding and you get a beautifully structured explanation. Ask it to propose an architecture and you will probably receive a diagram, a list of components and a paragraph explaining why the design is scalable, secure and future-proof. It all looks very convincing, and that is precisely why I don't want AI to simply do my work for me.

Take the Ansible role. I could ask:

> Write me an Ansible role that hardens this server.

A few seconds later I have this:

```yaml
- name: Hardening server
  hosts: all
  tasks:
    - name: Disable root login via SSH
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: '^PermitRootLogin'
        line: 'PermitRootLogin no'
```

It looks tidy, and it locks the door. Technically it may even be fine. But does sshd ever reload, so the change actually takes effect? Is there another account with a key, or have I just locked myself out as well? Does a drop-in file in `sshd_config.d` quietly override it? I got an answer, but I haven't learned anything yet.

## Start with your own thinking

I would much rather start with my own reasoning and use the AI as a sparring partner. This is what I want the system to do. These are my assumptions. This is how I think I should approach it. What am I missing, is there a better way, what could break, and is there a security implication I haven't considered? Then we work through it. Sometimes the AI challenges my approach. Sometimes it finds something I overlooked or suggests something I would never have considered. And sometimes it confidently suggests something plainly wrong. That is part of the deal.

The point is not that AI always knows the answer. The point is that the conversation makes my thinking better. If we end up with an excellent Ansible role, great, but the real success is that I understand it. I know why it is structured the way it is, which assumptions it makes, what it changes on the system and what could go wrong. I did not outsource the thinking. I used another intelligence to challenge it.

That distinction becomes more important as AI gets better, because there is a big difference between using AI to help you think and using AI so you don't have to. The first makes you stronger. The second can leave you dependent on something you don't understand.

## When repetition looks like evidence

Kylian also pointed to [Martijn van Grieken's post](https://www.linkedin.com/feed/update/urn:li:activity:7512091430299869184/) about AI shame, which goes somewhere much deeper. Martijn writes about stigmergy: agents influencing each other through a shared environment, and how an explanation can be repeated until it appears everywhere. At some point the repetition itself starts to look like evidence. That is a far bigger problem than whether my PowerPoint looks like it was made by Claude.

Imagine an AI produces an incorrect assumption. Another system uses that output, someone publishes the result, another model learns from it, and six months later someone asks an AI the same question. The answer comes back again, and again. At some point the original assumption has become part of the landscape. It has references, it appears in multiple places and several systems agree. Except they don't really agree. They are all repeating the same mistake.

Martijn illustrates this with the nonsense term "vegetative electron microscopy". It started as a digitisation error in two scanned papers from the 1950s, resurfaced through a translation slip in later papers, and was then reproduced by language models, as researchers [described in The Conversation](https://incidentdatabase.ai/cite/1044/).

Ten copies of the same assumption are still one assumption.

AI does not turn repetition into truth.

If anything it makes the problem worse, because it is extremely good at making things sound plausible. For my own work this means that an architecture document an AI drafted from another AI's output deserves more scrutiny, not less, however polished it looks.

## Ownership, not shame

This is also why I don't care much about AI shame. Did you use Claude to make your presentation look better? Fine. Did you use ChatGPT to structure your thoughts, or did AI help you find something you had overlooked? Excellent. Did it help you write some code? Sure. I don't need a disclaimer in your email signature telling me that an AI checked your grammar. What I do want to know is whether you understand what you are sending me.

There is a big difference between "AI helped me build this" and "AI built this, and I hope it's right". The first is collaboration. The second is outsourcing responsibility. I expect that distinction to matter more over time, especially in the areas where I spend most of my days: infrastructure, automation and security. If an AI helps me find a better way to configure something, or challenges my assumptions about a security control, I am happy about that. If it helps me write code faster, fantastic. But when something breaks at three in the morning, I don't want to be staring at a YAML file thinking that apparently this was the correct answer. I want to know why it works, and more importantly, why it might not.

So no, Kylian, I don't think we should be ashamed of using AI. I think we should watch out for something else: becoming so comfortable with the answer that we forget to understand the calculation. The real danger of AI is not that it can think for us. It is that we might eventually stop thinking because it can.

**The answer is not enough.**

## Further reading

- Kylian Martens on LinkedIn: <https://www.linkedin.com/in/kylian-martens-932443138/>
- Martijn van Grieken, LinkedIn post on AI shame and stigmergy: <https://www.linkedin.com/feed/update/urn:li:activity:7512091430299869184/>
- "A weird phrase is plaguing scientific papers – and we traced it back to a glitch in AI training data", The Conversation, summarised in the AI Incident Database: <https://incidentdatabase.ai/cite/1044/>