---
date: '2018-01-27T09:30:29+01:00'
draft: false
title: 'Yum Remove duplicate packages'
tags:
  - 'YUM'
  - 'Linux'
  - 'Package Management'
  - 'Duplicate Packages'
  - 'System Administration'
  - 'Command Line'
  - 'package management'
  - 'system cleanup'
categories:
  - 'Linux'
  - 'YUM'
  - 'Package Management'
  - 'Duplicate Packages'
  - 'System Administration'
  - 'Command Line'
---

During mayor upgrades on several systems I came along the bad situation with duplicate packages..

This helped me solve the issue of having duplicate packages installed.
I only needed to add another flag to have:

```
rpm -e --justdb --nodeps <package-old_version>
```
Below you will find the steps to semi automate this, but beware, Your millage may vary, make sure you check the output that are put into the files.

Bottom of output from:
```
yum --assumeno upgrade
Warning: RPMDB altered outside of yum.
** Found 247 pre-existing rpmdb problem(s), 'yum check' output follows:
#(truncated)
chkconfig-1.7.4-1.el7.x86_64 is a duplicate with chkconfig-1.7.2-1.el7.x86_64
1:gmp-6.0.0-15.el7.x86_64 is a duplicate with 1:gmp-6.0.0-12.el7_1.x86_64
gobject-introspection-1.50.0-1.el7.x86_64 is a duplicate with gobject-introspection-1.42.0-1.el7.x86_64
grep-2.20-3.el7.x86_64 is a duplicate with grep-2.20-2.el7.x86_64
gzip-1.5-9.el7.x86_64 is a duplicate with gzip-1.5-8.el7.x86_64
pcre-8.32-17.el7.x86_64 is a duplicate with pcre-8.32-15.el7_2.1.x86_64
4:perl-5.16.3-292.el7.x86_64 is a duplicate with 4:perl-5.16.3-291.el7.x86_64
4:perl-libs-5.16.3-292.el7.x86_64 is a duplicate with 4:perl-libs-5.16.3-291.el7.x86_64
4:perl-macros-5.16.3-292.el7.x86_64 is a duplicate with 4:perl-macros-5.16.3-291.el7.x86_64
shared-mime-info-1.8-3.el7.x86_64 is a duplicate with shared-mime-info-1.1-9.el7.x86_64
2:tar-1.26-32.el7.x86_64 is a duplicate with 2:tar-1.26-31.el7.x86_64
```

Put above package names (starting from packages listed) into:
```
vi yum-fix.txt
```

Suggested to run from yum, but doesn’t seem to help. maybe it does a bit..

```
yum-complete-transaction --cleanup-only
cat yum-fix.txt|grep "is a duplicate with" > yum-fix_dupe.txt
cat yum-fix.txt|grep -v "is a duplicate with" > yum-fix_manually.txt
```

Parse output of some packages that start with a number and colon:
```
cat yum-fix_dupe.txt |awk '{print $6}'|awk -F":" '{if ((length($1) != 1) && (length($1) != 2)) print $1}' > yum-fix_dupe2.txt 
cat yum-fix_dupe.txt |awk '{print $6}'|awk -F":" '{if ((length($1) == 1) || (length($1) == 2)) print $2}' >> yum-fix_dupe2.txt
```

Remove old package version from rpm db:
```
for i in $(cat yum-fix_dupe2.txt);do rpm -e --justdb --nodeps $i;done 
```

Remove last 2 columns from output, and put on same line:
```
cat yum-fix_dupe2.txt | awk -F"-[0-9]" '{print $1}' |tr '\n' ' ' > yum-fix_dupe2-reinstall.txt 
```

Reinstall packages:
```
yum reinstall (cat yum-fix_dupe2-reinstall.txt) 
```

Don’t forget to go back and manually fix the non-duplicates above could have fixed them..

Try yum upgrade to see if any more errors:
```
cat yum-fix_manually.txt yum --assumeno upgrade
```
