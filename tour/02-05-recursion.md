---
chapter: Working in Standard ML
title: Recursion
index: 2
section: 5
---

Standard ML encourages recursion in place of iteration; for example, to sum a list of numbers, you would use recursion. The specification requires that tail recursive functions be optimised away to not use stack space. `sum` here would explode the stack with a large enough list, but `sum_iter` would not, and would run as fast as an imperative loop.
