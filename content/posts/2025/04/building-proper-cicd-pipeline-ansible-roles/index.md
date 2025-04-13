---
title: "Building a Proper CI/CD Pipeline for Ansible Roles (Because Manual Testing is for Suckers)"
date: 2025-04-15
draft: false
slug: "building-proper-cicd-pipeline-ansible-roles"
tags:
  - ansible
  - automation
  - devops
  - ci-cd
  - github-actions
  - testing
  - infrastructure-as-code
categories:
  - DevOps & Infrastructure
  - Automation & Scripting
  - System Management
  - Tech & Industry Insights
---

Alright, let's talk about CI/CD pipelines for Ansible roles. If you've read my [thoughts on automation](posts/2025/03/why_i_decided_to_move_my_weblogs_to_hugo/), you know I'm obsessed with automating everything. Manual testing? That's so 2020. Let's build something robust that does the heavy lifting for us.

## The CI/CD Beast: What Are We Taming Here?

After my recent heart attack (yeah, that was fun - check out my [burnout story](posts/2025/03/the-sleep-deprived-sysadmin-how-lack-of-sleep-affects-performance-productivity-and-security/)), I've become even more adamant about automation. We're going to set up a pipeline that tests our Ansible roles automatically, because life's too short for manual testing.

## The Testing Arsenal

Here's what we're working with (and trust me, I've battle-tested these in production):

### 1. Molecule: Our Testing Powerhouse

Let me tell you why Molecule is the real MVP here. It's not just another testing framework - it's specifically designed for testing Ansible roles, and it does this job incredibly well. Here's why I swear by it:

- **Consistent Testing Environment**: Molecule creates isolated environments for each test run, ensuring your tests are reliable and reproducible.
- **Multiple Testing Scenarios**: You can test your role against different distributions, configurations, and even test failure scenarios.
- **Integration with Other Tools**: It plays nicely with ansible-lint, testinfra, and other tools in the Ansible ecosystem.
- **Docker Integration**: The Docker driver makes testing lightning fast compared to full VMs.

For the Docker images, I'm using Jeff Geerling's (`geerlingguy`) images because:
- They're specifically built for testing Ansible roles
- Include necessary dependencies pre-installed (Python, Ansible, systemd support)
- Regularly updated with security patches
- Support multiple distributions (Debian, Ubuntu, RHEL/Rocky Linux, etc.)
- Trusted by the community (Jeff is an Ansible veteran and author)

Here's the actual configuration I use:

```yaml
# Actual molecule.yml configuration from template
---
role_name_check: 1
dependency:
  name: galaxy
driver:
  name: docker
  options:
    managed: false
    ansible_connection_options:
      ansible_connection: docker
lint: |
  set -e
  ansible-lint
platforms:
  - name: ${MOLECULE_DISTRO:-debian12}
    image: "geerlingguy/docker-${MOLECULE_DISTRO}-ansible:latest"
    pre_build_image: true
    command: ${MOLECULE_COMMAND:-""}
    tmpfs:
      - /run:rw,exec,mode=1777,size=65536k
      - /tmp/.ansible:rw,exec,mode=1777,size=65536k
      - /tmp/ansible-tmp:rw,exec,mode=1777,size=65536k
      - /var/tmp:rw,exec,mode=1777,size=65536k
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
    cgroupns_mode: host
    privileged: true
    override_command: false
```

Want to skip all this setup? I've created a complete template that you can use as a starting point. Check out [template-ansible-role](https://github.com/AnyLinQ-B-V/template-ansible-role) on GitHub. It's open source and includes all the configurations we discussed here, plus some extra goodies. Feel free to use it, learn from it, or contribute back to make it even better! If you're new to contributing to open source, check out my post on [how to get started with open source contributions](posts/2025/03/getting-started-with-open-source-contributions/) - it's easier than you think!

### 2. GitHub Actions: The Automation Champion

If you've seen how I [automated my Hugo blog deployment](posts/2025/03/why_i_decided_to_move_my_weblogs_to_hugo/), you know I'm a fan of GitHub Actions. Here's how we set it up for Ansible roles:

```yaml
# Your CI/CD pipeline doesn't have to be complicated
name: CI
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        distro: [debian12, ubuntu2204, rockylinux9]
    
    steps:
      - name: Check out code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install molecule molecule-docker ansible-lint docker

      - name: Run molecule test
        run: molecule test
        env:
          MOLECULE_DISTRO: ${{ matrix.distro }}
```

But wait, there's more! Our CI/CD pipeline isn't complete without verification and publishing. I use a separate `verify.yml` workflow for pull requests to maintain quality:

```yaml
name: Verify
on:
  pull_request:
    branches: [ main ]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run ansible-lint
        uses: ansible/ansible-lint@main
```

And for publishing to Ansible Galaxy, I extend the CI workflow with a publish job:

```yaml
  publish:
    needs: test
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Publish to Galaxy
        uses: robertdebock/galaxy-action@1.2.1
        with:
          galaxy_api_key: ${{ secrets.GALAXY_API_KEY }}
```

Don't forget to add your Ansible Galaxy API key to your repository secrets! You can get this from your Galaxy profile and add it under your repository's Settings > Secrets > Actions with the name `GALAXY_API_KEY`. This ensures your role gets automatically published when tests pass on the main branch.

## The Human Factor (Because We're Not Robots... Yet)

Look, I get it. Setting up CI/CD feels like overkill sometimes. But after my health scare, I've learned that automating these processes isn't just about efficiency - it's about sanity. Every hour you spend manually testing is an hour you could spend on more interesting problems (or, you know, sleeping properly).

## Best Practices (From Someone Who Learned the Hard Way)

1. **Test Different Distros**: Yeah, Debian 12 is my favorite, but test on other distros too. Trust me, it'll save you headaches later.
2. **Version Your Role Properly**: Use semantic versioning. Future you will thank present you.
3. **Document Everything**: Because memory is fleeting, especially after too many late-night debugging sessions.

## Next Steps

I'm working on a more detailed guide about integrating this with Proxmox (you've seen my [thoughts on Proxmox vs VMware](posts/2025/04/why-migrate-to-proxmox/)). Stay tuned for that.

Got questions? Found a way to make this even more automated? Let me know in the comments. And remember: if you're doing it more than twice manually, automate it!

**Coming Soon:**
- A deep dive into Molecule testing scenarios
- How to integrate this with your existing infrastructure
- More rants about the importance of automation (because I can't help myself)
