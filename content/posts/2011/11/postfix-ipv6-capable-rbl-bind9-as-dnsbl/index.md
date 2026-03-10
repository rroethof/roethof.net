---
date: '2011-11-18T09:32:29+01:00'
draft: false
title: 'Postfix IPv6 capable + RBL + BIND9 as DNSBL'
tags:
  - 'Postfix'
  - 'IPv6'
  - 'DNSBL'
  - 'BIND 9'
  - 'RBLs'
  - 'Email Security'
  - 'Spam Filtering'
categories:
  - Linux & Open Source
  - Infrastructure & Servers
  - System Management
  - Networking
  - Security & Privacy
---

Here we go again…
For using ipv6 dnsbl, we need postfix version => 2.6 as the author of postfix state in postfix-users list.

How ipv6 dnsbl keep AAAA record in their zone?
this is how it done. for example we got ipv6: 2001:1af8:4400:a00d:1::1 (my webserver)

RBL query lookup would be like this:

```
$ dig aaaa 1.0.0.0.0.0.0.0.0.0.0.0.1.0.0.0.d.0.0.a.0.0.4.4.8.f.a.1.1.0.0.2.dnsbl.example.tld.
$ dig txt 1.0.0.0.0.0.0.0.0.0.0.0.1.0.0.0.d.0.0.a.0.0.4.4.8.f.a.1.1.0.0.2.dnsbl.example.tld.
```
So, we need configure our private BIND9 RBL like this: first create dnsbl.example.tld zone in /etc/named.conf

```
zone "dnsbl.example.tld" {
      type master;
      file "dnsbl.example.tld";
};
```
second, we have to create dnsbl.example.tld zone file.

```
$TTL 86400
@       IN      SOA     ns1.dnsbl.example.tld.     hostmaster.dnsbl.example.tld. (
                        2011082200      ; serial number YYMMDDNN
                        28800           ; Refresh
                        7200            ; Retry
                        864000          ; Expire
                        86400           ; Min TTL
                        )

                NS      ns1.dnsbl.example.tld.
                NS      ns2.dnsbl.example.tld.

$ORIGIN dnsbl.example.tld.
blackhole       IN      A       127.0.0.2
                IN      AAAA    ::2
                IN      TXT     "Blocked by dnsbl.example.tld for SPAM Sources"

2.0.0.0.0.0.f.7.f.f.f.f.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0         IN      CNAME   blackhole
2.0.0.127                                                               IN      CNAME   blackhole
118.62.140.11                                                           IN      CNAME   blackhole
238.128.73.115                                                          IN      CNAME   blackhole
1.0.0.0.0.0.0.0.0.0.0.0.1.0.0.0.d.0.0.a.0.0.4.4.8.f.a.1.1.0.0.2         IN      CNAME   blackhole
```
why do i using CNAME instead of direct AAAA record? it’s just for efficiency, to avoid repetitions when adding ipv6 address on the blacklist. beside, postfix resolver can follow CNAME until found AAAA and TXT record.

IN postfix configuration, main.cf add this line:

```
smtpd_recipient_restrictions =
    ...
        reject_unauth_destination,
        reject_rbl_client dnsbl.example.tld,
    ...
```
now test all the things we’ve configured. (with my own ipv6 in the temporary list)

```
$ telnet mx.example.tld 25
220 mx.example.tld ESMTP Postfix (Ubuntu)
ehlo s1.example.tld
250-mx.example.tld
250-PIPELINING
250-SIZE 10240000
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250 DSN
mail from:<pietje@example.tld>
250 2.1.0 Ok
rcpt to:<jantje@example.tld>
554 5.7.1 Service unavailable; Client host [2001:1af8:4400:a00d:1::1] blocked using dnsbl.example.tld
Blocked by dnsbl.example.tld for SPAM Sources
quit
221 2.0.0 Bye

Connection to host lost.
```
In Postfix log, we will see rejection like this:

```
Aug 22 16:21:14 mx postfix/smtpd[25932]: NOQUEUE: reject: RCPT from s1[2001:1af8:4400:a00d:1::1]: 554 5.7.1 Service unavailable; Client host [2001:1af8:4400:a00d:1::1] blocked using dnsbl.example.tld; from=<pietje@example.tld> to=<jantje@example.tld> proto=ESMTP helo=<s1.example.tld>
```
that’s all :)