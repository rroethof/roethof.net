---
title: "My 'Poor Man's CMDB': An Ansible Throwback and a Modern Refresh"
date: 2025-05-09
draft: false
slug: "ansible-dokuwiki-poor-mans-cmdb"
description: "A look back at a 10-year-old Ansible playbook for a DokuWiki-based CMDB, and an introduction to its updated task list for modern server documentation."
categories: ["Ansible", "Automation", "DevOps", "SysAdmin"]
tags: ["Ansible", "CMDB", "DokuWiki", "Automation", "InfrastructureAsCode", "LegacyCode", "ServerDocumentation"]
---

It's always a bit of a trip to look back at old projects. About a decade ago, I cobbled together an Ansible playbook designed to create a very basic, what I affectionately called, "Poor Man's CMDB" using DokuWiki. The idea was simple: use Ansible to gather information about servers and automatically generate wiki pages for them. No fancy databases, no complex frontends – just a straightforward way to get essential server data into an easily accessible format.

## The Original Sin: Why a DokuWiki CMDB?

Back then, the landscape was a bit different. While more sophisticated CMDB tools existed, they often came with a significant overhead in terms of setup, maintenance, or cost. For smaller environments or for sysadmins who just needed a quick and dirty way to document their fleet, something simpler was appealing.

The goals were:
*   **Leverage Ansible:** Use the tool already in place for configuration management to also handle basic documentation.
*   **Simplicity:** DokuWiki is file-based, easy to set up, and easy to back up.
*   **Automation:** Manually creating and updating server documentation is a recipe for outdated information.

The original playbook, which you can still find gathering digital dust over on GitHub, aimed to achieve this.

*   **Original Code Repository:** [drk-nyght/ansible-dokuwiki-cmdb](https://github.com/drk-nyght/ansible-dokuwiki-cmdb/)
*   **Original README:** [README.MD on GitHub](https://github.com/drk-nyght/ansible-dokuwiki-cmdb/blob/master/README.MD)

The README gives a good overview of what it tried to do, including creating server pages, a server list, and incorporating basic details.

## Fast Forward: A Modern Approach

Recently, I found myself thinking about this old concept and decided to sketch out what a more modern set of Ansible tasks for a similar purpose might look like. Ansible has evolved, best practices have shifted, and the kind of information one might want to gather has expanded.

This new version focuses more on gathering specific configuration details like Graylog, Zabbix, and systemd-journald settings, all orchestrated by a main playbook that includes a dedicated task file.

### The New Ansible Playbook

Here's the main Ansible playbook that drives the process. It defines the target hosts, necessary variables (like DokuWiki paths and credentials), and then calls upon a separate file for the detailed tasks.

```yaml
- name: Run the cmdb play
  hosts: all
  become: true
  gather_facts: true
  vars:
    dokuwiki_user: "xxx"
    dokuwiki_group: "xxx"
    dokuwiki_local_destination: "/home/xxx/.documentation"
    dokuwiki_local_destination_user: "xxx"
    dokuwiki_local_destination_group: "xxx"
    dokuwiki_directory: "/opt/dokuwiki/config/dokuwiki/data/pages/serverlijst"
    dokuwiki_serverlist_destination: "/opt/dokuwiki/config/dokuwiki/data/pages/serverlijst.txt"
    dokuwiki_targetserver: xxx.xxx.xxx.xxx

  tasks:
    - name: Import the cmdb tasks
      ansible.builtin.include_tasks: tasks/cmdb.yml
```

This playbook sets up the environment and then uses `ansible.builtin.include_tasks` to pull in the detailed steps from `tasks/cmdb.yml`.

### The Core Logic: `tasks/cmdb.yml`

The actual heavy lifting – gathering facts, checking configurations, creating local documentation files, and preparing data for DokuWiki – is handled in the `tasks/cmdb.yml` file. Let's break down what each part of these tasks does:

```yaml
# This file should only contain a list of tasks.
# Play-level directives like 'name', 'hosts', and 'vars_files' are removed
# as they are not applicable when using 'include_tasks'.
### Caching facts
- name: Display all variables/facts known for each server
  ansible.builtin.debug:
    msg: "{{ ansible_default_ipv4.address }} {{ ansible_fqdn }} {{ ansible_hostname }}" # Simplified access to facts

### Documentation files
- name: Create the directories for the description files on each server
  ansible.builtin.file:
    path: "{{ dokuwiki_local_destination }}"
    state: directory
    owner: "{{ dokuwiki_local_destination_user }}"
    group: "{{ dokuwiki_local_destination_group }}"
    mode: "0775"

- name: Create the description file on each server
  ansible.builtin.template:
    src: dokuwiki_templates/description.txt.j2
    dest: "{{ dokuwiki_local_destination }}/description.txt"
    owner: root
    group: root
    mode: "0644"
    force: false

- name: Download the description file
  ansible.builtin.slurp:
    src: "{{ dokuwiki_local_destination }}/description.txt"
  register: server_description

- name: Create the changelog file on each server
  ansible.builtin.copy:
    content: ""
    dest: "{{ dokuwiki_local_destination }}/changelog.txt"
    mode: "0644"
    force: false

- name: Download the changelog file
  ansible.builtin.slurp:
    src: "{{ dokuwiki_local_destination }}/changelog.txt"
  register: server_changelog

- name: Create the notes file on each server
  ansible.builtin.copy:
    content: ""
    dest: "{{ dokuwiki_local_destination }}/notes.txt"
    mode: "0644"
    force: false

- name: Download the notes file
  ansible.builtin.slurp:
    src: "{{ dokuwiki_local_destination }}/notes.txt"
  register: server_notes

# Gather package facts if not already gathered (idempotent)
- name: Gather package facts
  ansible.builtin.package_facts:
    manager: auto

# Gather service facts if not already gathered (idempotent)
- name: Gather service facts
  ansible.builtin.service_facts:

### Dokuwiki directory and file creation
# The following tasks are intended to run on the dokuwiki_targetserver.
# We use delegate_to and run_once for tasks that set up the DokuWiki server itself.

- name: Create the directories for DokuWiki on the target server
  ansible.builtin.file:
    path: "{{ dokuwiki_directory }}"
    state: directory
    owner: "{{ dokuwiki_user }}"
    group: "{{ dokuwiki_group }}"
    mode: "0775"
  delegate_to: "{{ dokuwiki_targetserver }}"
  run_once: true

- name: Place the serverlist template on the target server
  ansible.builtin.template:
    src: dokuwiki_templates/serverlist.txt.j2
    dest: "{{ dokuwiki_serverlist_destination }}"
    owner: "{{ dokuwiki_user }}"
    group: "{{ dokuwiki_group }}"
    mode: "0644"
  delegate_to: "{{ dokuwiki_targetserver }}"
  run_once: true

# This task runs for each host in the play, but the action is delegated
# to the dokuwiki_targetserver, creating a page for each inventory_hostname.
- name: Place each server as a wikipage on {{ dokuwiki_targetserver }}
  ansible.builtin.template:
    src: dokuwiki_templates/server.txt.j2
    dest: "{{ dokuwiki_directory }}/{{ inventory_hostname }}.txt"
    owner: "{{ dokuwiki_user }}"
    group: "{{ dokuwiki_group }}"
    mode: "0644"
  delegate_to: "{{ dokuwiki_targetserver }}"
```

This new set of tasks:
*   Creates local description, changelog, and notes files on each server (presumably for local reference or to be filled manually, then slurped).
*   Finally, it includes tasks (delegated to a `dokuwiki_targetserver`) to create the DokuWiki directory structure, a server list page, and individual server pages using templates.

## Still a "Poor Man's" Solution, But Evolved

Even with these updates, it's still fundamentally a "poor man's CMDB." It won't replace full-featured CMDB solutions for complex environments. However, for quickly generating and maintaining basic server documentation within a familiar Ansible and DokuWiki ecosystem, it can be quite effective.
By running this playbook regularly, perhaps via a cron job or a more sophisticated scheduling tool like AWX, Ansible Tower, or Semaphore, you can ensure that your DokuWiki-based CMDB remains surprisingly up-to-date and accurate.

It's interesting to see how the core idea persists – automating documentation – while the tools and specific data points evolve. Perhaps in another 10 years, we'll be using AI to not only gather this data but also to write the DokuWiki markup in perfect prose! For now, Ansible still does a pretty good job.

What are your go-to methods for quick and effective server documentation?

---

## Appendix: Explanation of the Ansible Code

Here's a breakdown of what the Ansible code in this post does and how the pieces fit together:

### Main Playbook

The main playbook defines the target hosts and sets up variables for DokuWiki paths, user/group ownership, and the DokuWiki server. It then uses `ansible.builtin.include_tasks` to pull in the detailed steps from `tasks/cmdb.yml`. This keeps the playbook clean and focused on orchestration, while the actual logic is handled in a separate file.

### `tasks/cmdb.yml` – The Core Logic

This file contains the actual tasks, which can be grouped as follows:

- **Fact Gathering:**  
  Uses Ansible modules to collect information about each server, such as IP address, hostname, installed packages, and running services.

- **Local Documentation Files:**  
  For each server, it creates a directory and three files: `description.txt`, `changelog.txt`, and `notes.txt`. These files are intended for local documentation and are later read using the `slurp` module for further processing.

- **DokuWiki Integration:**  
  The playbook then switches context to the DokuWiki server (using `delegate_to` and `run_once`):
    - Creates the necessary directory structure for DokuWiki pages.
    - Generates a server list page and individual server documentation pages using Jinja2 templates, populated with the facts gathered earlier.

### Why This Approach?

This method leverages Ansible’s automation capabilities to keep server documentation up-to-date with minimal manual effort. It’s a practical, lightweight alternative to more complex CMDB solutions, especially for smaller environments or teams already using Ansible.

By running this playbook regularly, you can ensure your DokuWiki-based CMDB remains accurate and current, all while keeping the process simple and maintainable.
