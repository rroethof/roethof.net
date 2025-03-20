---
date: '2015-02-22T09:30:29+01:00'
draft: false
title: 'find and mv files in bash'
tags: 
  - 'bash'
categories:
  - 'bash'
  - 'tips'
---

Today I was working on an oldskool backup script and needed to move (not delete) old files, playing arround with find a bit and I thought I would document this shell command for posterity’s sake.

```
for i in $(find . -type f -mtime +1); do mv $i /[NEW DIRECTORY PATH]/; done;
```