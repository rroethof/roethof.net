---
layout: post
title: "The State of SSH: Neglect Disguised as Stability"
slug: "state-of-ssh-neglect-disguised-as-stability"
date: 2026-01-22
author: "Ronny Roethof"
category: "Security & Infrastructure"
tags: [ssh, security, devops, ed25519, certificates, identity, access-control]
---

### The State of SSH: Neglect Disguised as Stability

SSH still works. That’s the problem.

Over the last six months, I’ve inspected SSH access in more environments than I wanted to. About 75% were still using 2048-bit RSA keys generated around 2017. Same keys. Same access. Same blind faith.

Nothing broke, so nobody touched it.

That’s not stability. That’s neglect.

In infrastructure work, your public SSH key is your technical business card. When you hand me one, I immediately know how you think about risk. In 2026, an old RSA key doesn’t say “experienced.” It says “unchecked.”

### RSA Isn’t Broken. It’s Just Done.

RSA still works. Cryptographically, it’s fine. Operationally, it’s obsolete.

Large keys. Ugly tooling. Fragile implementations. Endless copy-paste mistakes. None of this kills you immediately. It just makes every system harder to reason about.

Ed25519 fixed this years ago. Smaller keys. Faster operations. Fewer footguns. Less room for subtle failure.

If Ed25519 breaks your environment, you’re not running legacy systems. You’re running fossils.

### Keys on Disk Are a Time Bomb

Most SSH failures don’t start with crypto. They start with files.

A private key sitting in `~/.ssh` is a long-lived secret waiting for malware, theft, backups, or plain human error. People trust their laptops far more than they should.

I don’t store private keys on disk. I store identity in a vault. Keys exist in memory, briefly, when needed. Then they disappear again.

This isn’t about paranoia. It’s about accepting that endpoints are hostile by default.

### One Key Everywhere Is a Lie

I don’t use one SSH key everywhere. That’s convenient. It’s also irresponsible.

Production is not the same as a personal VPS. A bastion is not the same as a build machine. If compromising one system should not give access to another, they don’t share credentials.

At the same time, infinite keys aren’t a virtue either. I’ve seen environments where nobody knows which key does what anymore. That’s not security. That’s entropy.

The rule is simple: new trust boundary, new key. No trust boundary, no new key.

Vaults make this possible. Without them, this approach collapses immediately.

### When Keys Stop Scaling

I don’t personally need SSH certificates. I’m one person. If my access needs HR processes, something has gone terribly wrong.

But every environment with real team churn hits the same wall:
`authorized_keys` files grow. Old access lingers. Nobody remembers why a key exists. Removing anything feels dangerous.

This is where SSH certificates stop being “advanced” and start being obvious.

Servers trust a Certificate Authority once. Engineers authenticate via identity. Credentials expire automatically. Access decays by default.

Keys require discipline forever. Certificates assume discipline will fail.

### Hardware Is for When Failure Is Not an Option

Most access belongs in a vault. Some access should never touch a networked device at all.

Root accounts. Recovery paths. Signing keys.

For those, I use hardware isolation. Not because it’s fashionable, but because it enforces a physical failure mode. Malware doesn’t negotiate with keypads.

Inconvenience is a feature.

### Agent Forwarding Is a Loaded Gun

`ssh -A` is still everywhere. It’s also still dangerous.

Compromise one intermediate host and your forwarded agent becomes a skeleton key to everything behind it. People keep using it because it’s easy, not because it’s safe.

ProxyJump keeps authentication local. Same workflow. Fewer blast radii.

This is what maturity looks like: identical convenience, fewer assumptions.

### Rotation Is About Decay, Not People

I don’t rotate keys because of personnel changes. I rotate them because systems rot quietly.

Laptops get lost. Backups leak. Old decisions outlive their context. Long-lived credentials accumulate risk whether you notice or not.

If rotating keys feels painful, your setup isn’t “secure but inconvenient.” It’s brittle.

### Things People Argue With Me About

RSA is fine if it’s 4096-bit.
Hardware keys are overkill.
Certificates are annoying.
Vaults are risky because they’re cloud.
Agent forwarding is easier.

All of these are technically defensible positions. None of them survive contact with real incidents.

I don’t optimize for theoretical safety. I optimize for what still works after something goes wrong.

### The Verdict

SSH isn’t outdated. The way people *treat* it is.

In 2026, unmanaged keys are not a neutral choice. They are a liability you’ve decided not to look at yet. Identity is power. Access is control. Long-lived secrets leak authority whether you like it or not.

If your SSH setup hasn’t changed since 2017, it’s already lying to you.

