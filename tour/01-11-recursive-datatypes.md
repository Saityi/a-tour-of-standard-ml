---
chapter: Basics
title: Recursive types
index: 1
section: 11
---
Types may be recursive, making it easy to define recursive data structures like lists or trees. For example, a list of `'a`s is either:

- empty
  * `nil`
- or an item of type `'a`, followed by the rest of the list of `'a`s, which may be empty
  * `:: of 'a * 'a list`

A binary tree could be defined as:
- A `leaf`
- Or a `node`, containing an item of type `'a` and two subtrees