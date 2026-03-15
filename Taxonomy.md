# Taxonomy — roethof.net

Reference document for consistent categorization of all posts.

---

## Categories (max 2 per post)

Categories are broad themes for SEO and site navigation. They define the topic pages
that Google indexes as content hubs (`/categories/linux-open-source/` etc.).

**Rules:**
- Always lowercase with hyphens
- Max 2 per post
- Choose the two most specific ones that apply

| Category | Topics |
|---|---|
| `security-privacy` | Cybersecurity, hardening, CVEs, privacy, risk management, ISO 27001 |
| `linux-open-source` | Linux, FreeBSD, OSS, distros, desktop setup |
| `devops-infrastructure` | Ansible, Docker, KVM, CI/CD, networking, monitoring, scripting |
| `digital-sovereignty` | Geopolitics, EU, Netherlands, tech policy, cloud dependency |
| `career-sysadmin` | Sysadmin life, leadership, professional growth, IT failure |
| `health-ergonomics` | Burnout, ergonomics, keyboards, well-being, work-life balance |
| `personal-computing` | Productivity, tools, desktop, blogging |
| `ai-tech-insights` | AI, LLMs, prompt engineering, cloud trends, tech industry |
| `opinion-reflections` | Rants, personal stories, community, opinions |
| `hardware-maker` | Hardware reviews, 3D printing, DIY, products |

---

## Tags (max 5 per post)

Tags are concrete technical search terms. They provide extra context that the category
does not already cover. Use them for tools, protocols, products, CVEs, and specific techniques.

**Rules:**
- Max 5 per post
- Concrete terms, no broad themes
- Lowercase

### Good tags (examples)

```
kvm, qcow2, lvm, qemu, ansible, docker, ssh, vpn, cve,
iso27001, fortinet, cloudflare, vmware, broadcom, playwright,
hugo, llm, ai-prompt, ergonomics, burnout, sovereignty
```

### Bad tags — avoid these

Too generic; already covered by categories:

```
linux, technology, security, opinion, cloud, it, tech,
open source, sysadmin, devops, system administration, general
```

**Exception:** a generic tag is valid when it adds context outside the post's category.

> Post in `security-privacy` → tag `linux` is useful (SSH hardening is Linux-specific)
> Post in `linux-open-source` → tag `linux` is redundant (category already covers it)

---

## Full example

```yaml
---
title: "Converting KVM Guests from LVM to QCOW2, Base Images and Snapshots"
slug: converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots
date: 2011-11-18
lastmod: 2011-11-18
draft: false
author: "Ronny Roethof"
cover: posts/2011/11/converting-kvm-guests-from-lvm-to-qcow2-base-images-and-snapshots/cover.jpg

categories:
- linux-open-source
- devops-infrastructure

tags:
- kvm
- qcow2
- lvm
- qemu
- virtualization

summary: "Guide on converting LVM-based KVM guests to QCOW2 and creating base images and snapshots."
description: "Step-by-step instructions for converting KVM guests from LVM to QCOW2 and using base images and snapshots for virtualization management."
---
```

---

## Maintenance

When in doubt about a category: pick the most specific one. When in doubt about a tag:
ask yourself "would someone search for this specifically?" if yes, keep it; if no, drop it.

Use `fix_taxonomy.py` to bulk-update existing posts:

```bash
python3 fix_taxonomy.py --dir ./content --dry-run
python3 fix_taxonomy.py --dir ./content
```