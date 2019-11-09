---
chapter: Concurrent ML
title: MVars
index: 3
section: 6
---
M-variables are much like I-variables, but may be written to multiple times. Writing to a full M-Variable is an error, but taking from an `mvar` clears its contents. You may get an M-Variable without clearing its contents using `mGet`, or with clearing its contents using `mTake`.

M-variables provide similar integration with the event framework as I-variables.