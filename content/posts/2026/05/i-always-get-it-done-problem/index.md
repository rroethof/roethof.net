---
title: "I Always Get It Done (That’s the Problem)"
slug: "i-always-get-it-done-problem"
date: "2026-05-20"
lastmod: "2026-05-20"
draft: false
author: "Ronny Roethof"
categories:
  - career-sysadmin
  - opinion-reflections
tags:
  - operational-risk
  - automation
  - architecture
  - single-point-of-failure
  - knowledge-management
description: "Enterprise IT environments often depend on one highly competent person. That looks efficient until the organisation discovers it was never resilient."
summary: "When one person consistently carries operational recovery, troubleshooting and undocumented infrastructure knowledge, organisations mistake dependency for stability."
---

I have seen the same pattern for years.

Carl Watts described it well in [“When Competence Becomes Infrastructure”](https://www.linkedin.com/pulse/when-competence-becomes-infrastructure-carl-watts-gc1je/), but most environments recognise it long before they have a name for it.

    A clustered database goes down.  
    The people on call are competent.  
    But they do not know where to log in.  
    They do not know where the recovery documentation is.  

    Not because it does not exist.  
    Because nobody ever needed it.

One person logs in.

```bash
systemctl set-environment MYSQLD_OPTS="--wsrep-recover"
systemctl start mariadb
journalctl -u mariadb | grep -i "recovered position"

systemctl unset-environment MYSQLD_OPTS

sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/' \
/var/lib/mysql/grastate.dat

cat /var/lib/mysql/grastate.dat

galera_new_cluster
```
Fifteen minutes later, the cluster is back online.

Nobody else in the room could have done it without trial, error and risk.

From the outside, this looks like control. The incident stays small. Recovery is fast. Someone knew exactly what to do.

It feels like operational excellence.

It is not.

The organisation did not fail because knowledge was missing.  
It failed because that knowledge never had to move.

In almost every environment, the same sentence appears:

> “They always get it done.”

It sounds like reliability.

What it really means is that the organisation stopped building around the problem. One person kept compensating for it, so the gap never became visible.

Competence does not just solve problems.  
It hides them.

At first this looks efficient. Incidents are resolved quickly. Work keeps moving. There is very little friction.

That smoothness comes at a cost. One person is carrying complexity that was never distributed.

They know which script actually works.  
They know which warnings matter.  
They know which steps are safe to skip.  

As long as they are there, the system works.

That is where the risk settles in.

Workarounds stop being temporary. Fixes are not recorded. Decisions are not explained because there is no pressure to explain them. The system keeps delivering results, so nobody examines how those results are achieved.

Over time, the environment reshapes itself around that reality. What started as support becomes dependency.

Automation does not solve this.

It formalises whatever already exists. If the logic only lives in one head, the automation becomes another layer nobody else truly understands. It executes faster, but it does not distribute knowledge.

The system is not stable.

It is being actively stabilised.

This is where organisations confuse continuity with resilience.

The system continues to operate, so it is assumed to be stable. In reality, it is being held in place.

What is missing is not tooling or talent. It is structure—shared ownership, rehearsed recovery, and documentation that is actually used under pressure.

Instead:
- knowledge is not transferred  
- recovery is not practiced  
- documentation is not authoritative  

So it degrades.

The dependency was not accidental.

It worked.

And because it worked, it was rewarded.

We celebrate the engineer who restores service at 2 AM. We treat the recovery as proof of excellence instead of evidence of systemic failure.

To management, this looks like efficiency. In the short term, it is cheaper to rely on one highly capable engineer than to invest in redundancy, training, and shared ownership.

So the behaviour is reinforced.

The specialist carries the uncertainty, the edge cases, and the undocumented decisions. The system delivers outcomes, but the understanding of how it delivers them does not spread.

This can last for years.

Sometimes decades.

Especially when experience is high enough to make instability look normal.

But it does not scale.

At some point, something changes. Workload increases. The environment shifts. Or the person reaches a limit.

That is when the dependency becomes visible.

Suddenly the system is called fragile. Documentation is incomplete. The setup is risky.

None of that is new.

It only becomes visible when the system is forced to operate without the person holding it together.

That is when organisations realise they never built resilience.

They built continuity around an individual.

And continuity held by one person has predictable failure modes: the person leaves, burns out, or is overtaken by the complexity they were compensating for.

When that happens, the failure looks sudden.

It is not.

The difference between resilience and dependency is simple:

Resilience means other people can run the system.  
They can make decisions, recover from failure, and carry responsibility without guessing.

Dependency means they cannot.

In that case, the organisation does not own the knowledge required to operate its environment.

One person does.

Eventually the same sentence returns:

> “They always got it done.”

It was never a compliment.

It was a warning.