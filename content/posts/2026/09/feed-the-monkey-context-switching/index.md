---
title: "Feed the Monkey: What Nobody Tells You About Context Switching"
slug: feed-the-monkey-context-switching
date: 2026-09-01
lastmod: 2026-09-01
draft: false
author: Ronny Roethof
categories: ["career-sysadmin", "opinion-reflections"]
tags: ["sysadmin-culture"]
summary: "Put two Linux people in a room and one word is enough. Put a manager in that same room and suddenly you need an interpreter. The interruption is not the problem. The context switch is."
description: "A personal, slightly irreverent take on what it actually costs to move between technical shorthand and plain language, and why autonomy is the real fix."
---

*On shorthand, intruders, and why closing the door is sometimes the whole strategy.*

## One word is enough

Put two people who know Linux in the same room and watch how little language they actually need. One word is often enough. No context has to be built and no assumptions have to be checked, because you already share the mental model, you know what the other person means, what they are probably going to try next, and which parts of the problem are not worth discussing yet. You make progress fast, you fill in each other's blind spots before they become problems, and the whole thing runs like a well-rehearsed routine. It is one of the genuine pleasures of the job, the kind of shorthand you only get with someone who works at the same level or has lived through enough of the same fires.

## The intrusion

Then a manager walks in and asks what is going on. Nothing about that question is unreasonable, they have every right to ask it and honestly they probably should. And yet the reaction I will admit to having more often than I would like is that it feels like an intrusion. Not because the person is unwelcome, but because the timing could not be worse. The flow that existed thirty seconds earlier is gone, and now you are doing two jobs at once, solving the actual problem and rebuilding it from scratch in a language that was never designed for speed.

## The gear change nobody logs

That second job is the part people underestimate. It is not simply a matter of swapping technical words for plain ones, it is a full gear change in the middle of a sentence you were already halfway through in your head. You go from thinking in shorthand to thinking in explanations, and that switch costs something real even if it never shows up in any incident report.

## Jargon is not always efficiency

I am not exempt from this either. Jargon is efficient, it compresses meaning, and when two people share the same terminology a single sentence can replace an entire paragraph of explanation. But jargon is also comfortable, and comfortable things get used as a shield more often than we like to admit. Diving deeper into the technical weeds than the moment requires is its own quiet way of avoiding the translation work altogether. Two Linux people nerding out about systemd, networking or some obscure kernel behaviour is not always purely about efficiency. Sometimes it is simply easier to stay in the language where nobody expects you to slow down, and shorthand that is normally communication quietly turns into camouflage.

## Feed the monkey

Whenever a manager or a non-technical colleague asks what my ideal working situation looks like, I give the same answer every time. Give me the goal, give me the resources, give me a timeframe. Then close the door and slide some food under it every so often. Feed the monkey. It usually gets a laugh, but underneath the joke is a genuine point about trust and autonomy. Give someone who knows what they are doing a clearly defined outcome, the tools to achieve it and enough room to work, and you remove a surprising amount of unnecessary communication, because the less a technical process gets interrupted, the less translation is ever needed in the first place. People sometimes assume technical people dislike explaining things, and I do not think that is generally true. What they tend to dislike is having to reconstruct their entire mental model every fifteen minutes because someone needs an update at the precise moment they finally had the whole picture in their head. The explanation itself is rarely the problem, the timing is.

## The cost is context, not time

None of that means the translation work should stop happening. Managers are not asking out of idle curiosity, they are trying to understand what is happening inside systems they are ultimately responsible for, and that is fair. Sometimes the technical person is simply too deep in the weeds to notice that what feels obvious to them is invisible to everyone else. "Feed the monkey" only gets you so far before someone reasonably wants to know what is actually in the cage, so the door does have to open occasionally and the explanation does have to happen. What I have become more conscious of is that this communication has a cost that is not measured in the number of words spoken, but in the context that gets lost. Every interruption forces a small reconstruction, where you were, what assumptions you were holding, which branch of the problem you were exploring, what you had already ruled out and what you were about to test next. None of that is visible to the person who just walked in for what felt to them like a thirty-second question. To you it may have been a ten-minute detour, and sometimes you never quite get the original train of thought back.

## Autonomy is not isolation

That is probably the distinction I have become more aware of over time. Autonomy does not mean "leave me alone and never ask questions", it means trust me enough to let me work and make the interruptions intentional rather than habitual. There is a difference between visibility and interruption, between accountability and micromanagement, between asking whether the monkey is alive and opening the cage every ten minutes to check its pulse. The first is management, the second is context switching with a job title.

## Interrupt less

What changed for me is not my willingness to explain. I still explain, I still translate, I still understand that technical work has to be made visible to people who do not share the same mental model. What changed is that I am more honest about what the interruption actually costs, and a little more deliberate about when the door needs to stay shut. Sometimes the best way to improve communication is not to communicate more. Sometimes it is to interrupt less.