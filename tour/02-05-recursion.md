---
chapter: Working in Standard ML
title: Recursion
index: 2
section: 5
---
Iteration may be expressed using recursion. If you would like to sum a list of items, for example, you might use recursion. 

This is safe as the Standard ML specification requires implementations to optimise recursive calls; it will not explode the stack as it may in other languages, and will compile to a tight, efficient loop.