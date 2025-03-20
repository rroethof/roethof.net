---
date: '2011-11-18T09:23:29+01:00'
draft: false
title: 'How to monitor Bind with Munin'
tags: 
  - 'monitoring'
categories:
  - 'monitoring'
---

Munin does have some limitations.
It does not scale well (to hundreds of servers) and I find it particularly painful to create aggregated graphs (for example aggregated network graph of two or more hosts). But I know these issues are being worked on.

Okay, enough talk – let’s monitor Bind:

First we need enable logging. Create a log directory and add log directives to the Bind configuration file (here on Ubuntu):

```
# mkdir /var/log/bind9
# chown bind:bind /var/log/bind9
# cat /etc/bind/named.conf.options
logging {
        channel b_log {
                file "/var/log/bind9/bind.log" versions 30 size 1m;
                print-time yes;
                print-category yes;
                print-severity yes;
                severity info;
        };

        channel b_debug {
                file "/var/log/bind9/debug.log" versions 2 size 1m;
                print-time yes;
                print-category yes;
                print-severity yes;
                severity dynamic;
        };

        channel b_query {
                file "/var/log/bind9/query.log" versions 2 size 1m;
                print-time yes;
                severity info;
        };

        category default { b_log; b_debug; };
        category config { b_log; b_debug; };
        category queries { b_query; };
  };
```

Restart bind:

```
# /etc/init.d/bind9 restart
  Stopping domain name service: named.
  Starting domain name service: named.
```
You can now see log files are being populated under /var/log/bind9/*

Next, configure Munin:

Make sure the munin-user (“munin”) can read you bind log files.

We need two additional plugins: “bind” and “bind_rndc”. If you can’t find them in your default install, head over here.

The “bind” plugin should work right away. “bind9_rndc” however need to read the “rndc.key file, which only are readable by the user “bind”. You have two options, either run the plugin as root or add the user “munin” to the group “bind” and enable the group “bind” to read the rndc.file. For the sake of simplicity, I run the plugin as root here. So you need to add:

```
# cat /etc/munin/plugin-conf.d/munin-node
[bind9_rndc]
  user root
  env.querystats /var/log/bind9/named.stats
```
Next restart Munin:

```
# /etc/init.d/munin-node restart
  Stopping munin-node: done.
  Starting munin-node: done.
```
Munin run every five minutes, so go take a coffee. Wait.