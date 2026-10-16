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

From the outside, this looks like control.  

The incident stays small.  
Recovery is fast.

It feels like operational excellence.

It is not.

The organisation did not fail because knowledge was missing.  
It failed because that knowledge never had to move.

---

In almost every environment, the same sentence appears:

“They always get it done.”

It sounds like reliability.

What it really means is that the organisation stopped building around the problem.

One person kept compensating for it.  

So the gap never became visible.

---

Competence does not just solve problems.  

It hides them.

At first, this looks efficient.

Incidents are resolved quickly.  
Work keeps moving.  
There is very little friction.

That smoothness has a cost.

One person carries complexity that was never distributed.

They know which script actually works.  
They know which warnings matter.  
They know which steps are safe to skip.

As long as they are there, the system works.

That is where the risk settles in.

---

Workarounds stop being temporary.

Fixes are not recorded.  
Decisions are not explained.

Because there is no pressure to explain them.

The system keeps delivering results.

So nobody is forced to examine how those results are achieved.

Over time, the environment reshapes itself around that reality.

What started as support becomes dependency.

---

Automation does not solve this.

It formalises whatever already exists.

If the logic only lives in one head, the automation becomes another layer nobody else truly understands.

It executes faster.

It does not distribute knowledge.

---

The system looks stable.

It is not.

It is being actively stabilised.

This is where organisations confuse continuity with resilience.

The system keeps running, so it is assumed to be stable.

In reality, it is being held in place.

---

What is missing is not tooling or talent.

It is structure.

Shared ownership.  
Rehearsed recovery.  
Documentation that is actually used under pressure.

Instead:

- knowledge is not transferred  
- recovery is not practiced  
- documentation is not authoritative  

So it degrades.

---

And sometimes, the situation is even worse.

Because the problem was identified.  
The solution was designed.  
The risks were documented.  

And it still did not happen.

I proposed a full redesign of a monitoring database stack.

Not a patch.  

A proper fix:

- High-availability PostgreSQL cluster  
- TimescaleDB for scale and retention  
- Automated deployment with Ansible  
- Tested failover, backups, and recovery  

A system built to handle real production load.

It was clear.  
Documented.  
Testable.

The response was also clear.

The proposal was rejected and the risk was accepted.
Not because it was unclear.
Because it was inconvenient.

---

This is how dependency becomes a design choice.

Not an accident.

A decision.

---

We celebrate the engineer who restores service at 2 AM.

We treat the recovery as proof of excellence.

Instead of evidence of systemic failure.

To management, this looks like efficiency.

In the short term, it is cheaper to rely on one highly capable engineer than to invest in redundancy, training, and shared ownership.

So the behaviour is reinforced.

---

The specialist carries:

- the uncertainty  
- the edge cases  
- the undocumented decisions  

The system delivers outcomes.

But the understanding does not spread.

This can last for years.

Sometimes decades.

Especially when experience is high enough to make instability look normal.

---

But it does not scale.

At some point, something changes.

Load increases.  
Complexity grows.  

Or the person reaches a limit.

That is when the dependency becomes visible.

Suddenly the system is called fragile.  
Documentation is called incomplete.  
The setup is called risky.

None of that is new.

It was always true.

---

It only becomes visible when the system is forced to operate without the person holding it together.

That is when organisations realise:

They never built resilience.  

They built continuity around an individual.

---

The difference is simple.

Resilience means other people can run the system.

They can make decisions.  
Recover from failure.  
Carry responsibility without guessing.

Dependency means they cannot.

At that point, ownership is an illusion.

The organisation does not own the system.

One person does.

---

Eventually, the same sentence returns:

“They always got it done.”

It was never a compliment.

It was a warning.
