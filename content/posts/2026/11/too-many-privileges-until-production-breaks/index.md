---
title: "Too Many Privileges. Until Production Breaks."
slug: too-many-privileges-until-production-breaks
date: 2026-11-21
lastmod: 2026-11-21
draft: false
author: "Ronny Roethof"

categories:
  - career-sysadmin
  - devops-infrastructure

tags:
  - galera
  - zabbix
  - mariadb
  - ansible
  - mydumper

summary: "One week I'm defending my autonomy as an engineer. The next I'm rebuilding a critical database platform. Same engineer, different circumstances."
description: "A personal story about Galera failures, rebuilding infrastructure from scratch, corporate politics and the strange relationship between trust, responsibility and autonomy."
---

*On broken database clusters, corporate politics, rebuilding everything from scratch and the strange way trust works when production is on fire.*

Last week I was having discussions about working from home, corporate harmonization, job classifications and apparently having too much freedom. I'm just an engineer, although admittedly one with a big mouth, strong opinions, a Linux laptop and, according to some, too many privileges. I tend to question decisions that don't make sense to me, which isn't always appreciated in a corporate environment. This week, however, I'm apparently the guy everyone turns to when a critical database environment needs rescuing. Same engineer, same mouth, same privileges. Funny how that works.

## An architecture I never agreed with

There's some history behind this particular environment. Years ago, an external party designed the original Zabbix database architecture. I wasn't particularly happy with it and made my objections known. It didn't matter much. The design was pushed through, the decisions were made and eventually we had to live with it. That doesn't automatically mean every problem we've experienced was caused by the original design, but it does make the current situation rather ironic.

The setup consisted of two MariaDB Galera database nodes and an arbitrator. Three cluster members, but only two actual copies of the database. The arbitrator helps maintain quorum, but it doesn't store data. Lose one database node and you may still have a functioning cluster, but you've also lost your database redundancy. That's exactly where we ended up. One surviving production database containing a rather substantial amount of monitoring data, with an entire Zabbix environment depending on it. Galera still reported a Primary Component, but that didn't magically create another copy of the database.

And this wasn't the first time the environment had caused trouble. Back in May, during a datacenter migration, we experienced serious database problems and Zabbix went down completely. I was at home dealing with a burnout at the time, something I've written about on this blog before. Nevertheless, when things went wrong, the phone rang. I ended up helping bring the environment back to life while I was supposed to be recovering myself. Looking back, there's something rather uncomfortable about that. You're home because you've already reached your limit, yet somehow you're still the person people call when the infrastructure reaches its own.

October brought more database crashes and monitoring-related disruptions. November brought another series of Galera problems, replication issues, recovery attempts and complications involving backups and database maintenance. I investigated the incidents, restored the affected services and documented what happened. Not every root cause could be conclusively established and restoring service didn't always restore the redundancy we wanted, but the immediate problems were resolved. Until the next one arrived.

At some point you stop looking at these things as isolated incidents and start questioning the environment itself. How often are we going to recover the same platform before admitting that we need to change the way it's built and maintained?

## What the investigation actually revealed

When I started digging properly, I found considerably more than a couple of unhappy Galera nodes. The incident logs showed a database maintenance operation that went more than five hours without another progress message. Around the moment it continued, cluster membership changed. A database node subsequently tried to recover, couldn't perform an incremental state transfer and fell back to a much heavier recovery operation. Backup activity and database locking had also played a role in the wider incident.

The exact root cause couldn't be established conclusively. Some logs were no longer available, and several events happened close together without proving that one caused the other. I could have written a convenient story about how everything was caused by one bad design decision, but that wouldn't have been engineering. That would have been looking for evidence to support an opinion I'd already formed.

The broader investigation revealed inconsistencies in data retention, maintenance procedures that lacked adequate safeguards, configuration choices whose original reasoning wasn't particularly clear and monitoring that wasn't always providing the information it should. Some settings appeared to have been carried forward from older implementations without being properly reconsidered. The environment had accumulated quite a bit of technical debt, and the available documentation didn't always explain why things worked the way they did.

Not every unusual configuration is automatically wrong, and not every weakness causes an outage. But when you're maintaining a critical platform, you should understand the choices behind it, know how it behaves during failure and be able to demonstrate that recovery actually works. Having a cluster is not the same as having a recovery strategy, and having backups isn't the same as knowing you can restore them.

The findings went into my documentation, including what could be verified, what remained uncertain and which improvements were needed. No invented root causes, no convenient assumptions and no pretending that getting production running again meant everything was fixed.

## Starting over. Everything.

Once it became clear that continuing to patch up the existing environment wasn't the right long-term answer, I started looking at what we could reuse. The original implementation came with Ansible automation from the external supplier, so you'd expect there to be a reasonable foundation. Not quite.

The code was outdated, required far too much manual intervention and wasn't properly idempotent. Running the automation again didn't necessarily produce the same predictable result, which rather defeats the purpose of configuration management. I've never understood why people call something automated when you still need a collection of manual commands and undocumented fixes afterwards. That's not automation. That's manual administration with YAML files attached.

So I started over. Everything.

Fresh Debian 13 installations using preseed, followed by my Ansible baseline and security hardening. New automation for MariaDB, Galera, configuration, access control, firewall rules and the surrounding infrastructure. Three actual data-holding database nodes instead of two nodes and an arbitrator. Two HAProxy load balancers, Keepalived and a stable virtual database endpoint. Everything designed around repeatability and maintainability rather than remembering which manual steps were needed to make the original deployment work.

And none of this was straightforward. I wrote the automation, ran it, found problems, corrected them and ran it again. Galera had its own requirements, database authentication needed attention, firewall rules had to match the architecture and the load balancers needed to behave predictably. Sometimes the problem was a configuration setting, sometimes a permission, sometimes my own code. That's what building infrastructure actually looks like. It isn't a neat series of green Ansible tasks followed by everybody going home.

The goal wasn't merely to get the new environment online. I wanted to understand every part of it and be confident that we could reproduce and maintain it without depending on undocumented knowledge or somebody remembering how it was originally assembled. And this time I was given the freedom to do exactly that.

## The politics of being useful

The timing of all this is probably what fascinates me most. While I was dealing with a failing database cluster, investigating years of accumulated problems and rebuilding the infrastructure from scratch, there was another discussion going on. Corporate harmonization. Job classifications, mandatory office attendance, Linux workstations and how much independence an engineer should actually have.

For five days, the technical side of the organization had essentially been looking in my direction. We had one surviving production database, a massive dataset and a replacement environment that still needed to be built and migrated. The message was pretty clear: we need him to sort this out. Meanwhile, I was still having to explain why my responsibilities justified a particular job classification and why my existing working arrangements should remain unchanged.

And then, right in the middle of the incident, the response arrived. My job classification had been corrected, Linux was explicitly allowed to stay and my existing working-from-home arrangements would remain in place. Some questions about my original responsibilities were still unresolved, but those were three fairly significant confirmations. Credit where it's due, people had listened and reconsidered their position.

The contrast was almost comical. On one side, an organization trying to determine how much freedom and responsibility an engineer should have. On the other, that same organization depending on him to recover and replace a critical infrastructure platform. All happening during the same week, sometimes practically at the same time.

I don't believe that makes me special. I've been solving and documenting these incidents for months, including being called to help recover the environment during my burnout earlier this year. And I've had colleagues supporting me throughout, long before this particular crisis. People who understand how I work, trust my judgment and have been willing to back me up even when my opinions weren't particularly convenient. Their support didn't suddenly appear because a database cluster failed, and I certainly don't want to give the impression that everyone in the organization has been against me.

But it does make me wonder why the responsibility people are perfectly comfortable giving you during an emergency can be so difficult to recognize during an ordinary working week.

The thing is, I understand why people want reassurance. When production is at risk, they want to know what's happening, what the plan is and what happens if it fails. So I explain it, document the risks, communicate progress and make sure nobody gets unnecessary surprises. I tell people what I know, what I haven't established yet and what I need from them. Once people understand the approach, they're usually happy to give me the freedom to execute it. They're not being kept in the dark, but they're also not standing over my shoulder while I try to troubleshoot a database.

And that's all I've really been asking for. Feed the monkey and leave me the fuck alone. Not because I don't want accountability, but because I know the difference between being accountable for my work and having someone constantly looking over my shoulder.

## The migration problem

Of course, building the replacement was only half the problem. We still had to migrate the full Zabbix database from the only surviving production node. And that database was still doing its job, accepting writes and keeping the monitoring environment alive. The last thing I wanted was to destroy the source while trying to build its replacement.

Before scheduling the actual cutover, I wanted to test the migration process while production remained available. The idea was to find the problems before entering a maintenance window, rather than discovering them after shutting down Zabbix. The initial test used a consistent SQL export streamed directly into the new environment. No enormous intermediate dumpfiles, no unnecessary copying and no requirement for additional temporary storage.

The first test migration encountered a problem involving database objects and permissions. We investigated it, cleaned up the incomplete destination and adjusted the approach. During the second test, I accidentally terminated the import session myself. Experience doesn't prevent you from pressing the wrong keys, apparently. Fortunately, production was unaffected. I verified that the processes had stopped, checked the partial import, cleaned up the destination and started again with proper session management and monitoring.

The third test behaved much better. The new Galera cluster remained healthy, replication queues were almost empty, resource usage was reasonable and the old production database continued doing its job. Technically everything looked fine, apart from one rather annoying detail: it was slow as hell. After more than six hours, the new database filesystem had grown by roughly 170 GiB. At that rate, completing the full dataset could easily take well over a day, depending on how the remaining tables behaved. Filesystem growth isn't an exact measure of logical data throughput, but it was more than enough to tell me that a single SQL stream wasn't a particularly attractive option for a maintenance window.

That's exactly why I wanted to test the migration before taking Zabbix offline. A solution can work perfectly and still be the wrong solution for the job. So I started investigating parallel migration methods. Rather than feeding everything through one SQL stream, tools such as MyDumper and MyLoader can divide the work across multiple workers and potentially stream data directly between machines. That avoids creating and copying a complete intermediate dump while making better use of the available resources. Whether it delivers the performance we need remains to be tested. I prefer measurements over promises, especially when the only remaining production database is involved.

Meanwhile, there are plenty of operational details to consider. Available storage, the impact of long-running consistent exports, database maintenance jobs, cluster health, recovery procedures and a controlled maintenance window. During the final cutover, the application and any other database writers must be stopped so we're not moving data that keeps changing underneath us. Then there's validation, application testing and the decision about when the old environment can safely be retired.

Most of the work consists of checking things, thinking ahead and knowing when not to touch something. But that's also what separates a controlled migration from the next incident.

## The part that doesn't show up in the graphs

There's another side to this work that tends to disappear behind the CPU graphs and database statistics. Documentation. Over the years I've built my own DokuWiki setup and documentation structure for the infrastructure I manage. It's where I keep the architecture, installation procedures, configuration details, troubleshooting notes, incident reports and operational runbooks. I built it, I maintain it and, at the moment, I'm also the only one actually writing those pages.

That's not something I'm particularly proud of from an organizational perspective. Knowledge shouldn't depend on one person. But when you've spent months recovering an environment and investigating problems that weren't properly documented in the first place, you quickly appreciate having somewhere to record what you've learned.

The Galera incidents are a good example. Previous incident reports helped reconstruct the history of the platform. The technical investigation became a structured set of findings rather than a collection of assumptions. The new deployment has its own architecture and configuration documentation, and the migration runbook contains the checks, commands, decisions and recovery procedures developed along the way. When an import fails halfway through, having a reliable procedure for identifying the affected environment and cleaning up safely is considerably more useful than another pretty architecture diagram.

And because this is a production environment, ISO 27001 comes into the picture as well. Incident registration, risk management, change control, technical evidence, recovery planning and the ability to demonstrate that security and availability measures actually work. The existing change process still applies. Not every technical activity needs a meeting, but significant changes do need to be planned, recorded and justified.

I'm not a fan of paperwork for the sake of paperwork, but I don't have a problem with documentation that serves a real purpose. I want to know why something was built a certain way, what happens when it fails and how to recover it. I also want somebody else to be able to understand the environment without having to call me every time something goes wrong. Especially after what happened in May.

The irony is that the more seriously you take documentation, the more visible the gaps become. A configuration nobody can explain. A recovery procedure nobody has tested. A maintenance task that apparently ran for hours without anybody noticing. These are the things worth fixing, not merely documenting so an auditor can put a checkmark next to them.

## Same engineer. Different week.

There's a temptation to become rather impressed with yourself when everybody suddenly starts looking in your direction. You're the one investigating the problem, making technical decisions and explaining what needs to happen next. It's easy to start believing you're somehow more important than everybody else.

I try to avoid that. I'm not the only capable engineer in the organization, and I don't do all of this alone. Other people provide support, arrange resources, challenge assumptions and bring expertise I don't have. Some of those colleagues have trusted me for years, and that means a lot more to me than suddenly being called the hero of the week. Taking technical ownership doesn't mean acting like the entire company revolves around you.

But I can't ignore the irony of the past week. An architecture I objected to years ago was pushed through. I've spent months dealing with incidents, restoring services and documenting what happened, including being called upon while I was recovering from burnout. The original automation wasn't something I could reasonably build upon, so I rebuilt the replacement infrastructure and its automation from scratch. And while all of that was happening, I was simultaneously explaining why my responsibilities, Linux workstation and existing working arrangements deserved recognition.

That recognition did arrive, in writing, right in the middle of the incident. And I'm glad it did. People took my objections seriously, corrected the job classification and confirmed that the working arrangements I'd relied on for years would continue. That deserves acknowledgment. It doesn't settle every question about my role, but it does mean the discussion produced something constructive.

Still, the timing leaves me thinking. The technical responsibility wasn't new. The work wasn't new. The autonomy required to do it properly wasn't new either. I'd been doing these things for years, and during this particular week everyone could see exactly why that independence mattered. Would the same recognition have arrived without a critical incident happening at the same time? Perhaps. I genuinely don't know.

At the time of writing, the migration itself isn't finished. There are still risks to manage, tests to perform and a production cutover ahead. I'm not going to pretend everything will go perfectly. Infrastructure has a remarkable ability to make you look stupid the moment you become too confident.

I haven't become a different engineer overnight. I still have a big mouth, I still question decisions I disagree with and I still prefer my Linux environment and the freedom to work independently. I'm also still perfectly capable of making mistakes, as the interrupted test migration demonstrated.

I don't need to be the hero. I enjoy solving difficult technical problems, rebuilding infrastructure and automating things properly. I don't need applause for doing my job. This week showed that trust and autonomy are perfectly possible without giving up accountability.

I'd just like the same trust when nothing is broken.
