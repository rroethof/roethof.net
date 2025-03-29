---
date: '2023-12-07T09:30:29+01:00'
draft: false
title: 'Error: externally-managed-environment when installing via pip3'
tags: 
  - 'pip3' 
  - 'environment management'
  - 'package installation'
  - 'python'
  - 'linux'
  - 'command line'
categories:
  - Linux & Open Source
  - Personal Computing & Productivity
  - Automation & Scripting
  - System Management
---

On new Debian 12 Bookworm installs, when I try running pip3 install something (whether that’s Ansible or some other Python tool), I get the following error message:

```
╰─# pip3 install -r requirements.txt
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.

    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.

    If you wish to install a non-Debian packaged Python application,
    it may be easiest to use pipx install xyz, which will manage a
    virtual environment for you. Make sure you have pipx installed.

    See /usr/share/doc/python3.11/README.venv for more information.

Note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

The error message says you can pass in the flag --break-system-packages but that sounds terrifying. I just want pip to stop nagging me, but let me manage my system dependencies like I have for many years.

I think some Python developers really want people like me to use [virtual environments](https://docs.python-guide.org/dev/virtualenvs/), but that’s way too much effort when I don’t really care to do that. If you want to use venv more power to you. I just like getting stuff done on my servers.

So the solution for Debian 12, at least, is to delete the *EXTERNALLY-MANAGED* file in your system Python installation:

```
sudo rm -rf /usr/lib/python3.11/EXTERNALLY-MANAGED
```
Note that the python3.11 version number should match whatever you have installed—it was 3.11 at the time of this blog post’s writing.

See this answer on [Stack Overflow](https://stackoverflow.com/a/75722775/100134) for more. Another interesting option is to install and use [pipx](https://pypa.github.io/pipx/), which does the grunt work of managing the venvs for you.