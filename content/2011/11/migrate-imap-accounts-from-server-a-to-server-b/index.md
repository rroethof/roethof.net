---
date: '2011-11-18T09:31:29+01:00'
draft: false
title: 'Migrate IMAP accounts from server A to server B'
tags: 
  - 'Imap'
  - 'Email Migration'
  - 'Server Migration'
  - 'Linux'
  - 'System Administration'
  - 'Email Clients'
  - 'IMAP Accounts'
categories:
  - 'System Administration'
  - 'Linux'
  - 'Email'
  - 'Imap'
  - 'Server Migration'
  - 'IT Infrastructure'
---

There is a easy to use tool that facilitates the quick’n dirty move of the content of one IMAP account to a new server. Its name is *imapsync*. 
In Ubuntu, you may install it as this:

```
aptitude install imapsync
```

Now, set two files for the old and the new account in your home, containing the respective passwords of the two accounts. They are called *passfile_1* and *passfile_2* from now on.

Now run *imapsync* with the following options:

```
imapsync --host1 {old_imap_host} --user1 {old_imap_user} --authmech1 LOGIN \ --passfile1 passfile_1 --port1 993 --ssl1 \
--host2 {new_imap_host} --user2 {new_imap_user} --authmech2 LOGIN \ --passfile2 passfile_2 --port2 993 --ssl2
```
You just need to adjust the ports (143 vs. ssl) and the authentication mechanisms to your needs and you’re set.

To show how this works, here’s an example from a personal migration:

```
Turned ON syncinternaldates, will set the internal dates (arrival dates) on host2 same as host1.
TimeZone:[europe/amsterdam]
Will try to use LOGIN authentication on host1
Will try to use LOGIN authentication on host2
From imap server [servera] port [993] user [usera]
To   imap server [serverb] port [993] user [userb]
Banner: * OK [CAPABILITY IMAP4rev1 UIDPLUS CHILDREN NAMESPACE THREAD=ORDEREDSUBJECT THREAD=REFERENCES SORT QUOTA IDLE AUTH=PLAIN ACL ACL2=UNION] Courier-IMAP ready. Copyright 1998-2008 Double Precision, Inc.  See COPYING for distribution information.
Host servera says it has NO CAPABILITY for AUTHENTICATE LOGIN
Success login on [servera] with user [usera] auth [LOGIN]
Banner: * OK [CAPABILITY IMAP4rev1 LITERAL+ SASL-IR LOGIN-REFERRALS ID ENABLE AUTH=PLAIN] Dovecot ready.
Host serverb says it has NO CAPABILITY for AUTHENTICATE LOGIN
Success login on [serverb] with user [userb] auth [LOGIN]
host1: state Authenticated
host2: state Authenticated
From separator and prefix: [.][INBOX.]
To   separator and prefix: [.][INBOX.]
++++ Calculating sizes ++++
From Folder [INBOX]                             Size:   4122535 Messages:   252
From Folder [INBOX.Belangrijk]                  Size:  13395371 Messages:   127
flags from: [\Seen]["16-Jul-2011 09:45:30 +0200"]
Copied msg id [2053] to folder INBOX.Mailinglijsten.Debian.Bugs msg id [2053]
+ NO msg #2054 [9+vsr6Mzv58wM/L4Jt4Bvg:7095] in INBOX.Mailinglijsten.Debian.Bugs
+ Copying msg #2054:7095 to folder INBOX.Mailinglijsten.Debian.Bugs
```