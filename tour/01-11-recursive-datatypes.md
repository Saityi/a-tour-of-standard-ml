---
chapter: Basics
title: Recursive types
index: 1
section: 11
---
Types may be recursive, making it easy to define recursive data structures like lists or trees. For example, a list of `'a`s could be defined using two cases:

- empty
  * `eol`: an 'end of list' marker
  * Defined in Standard ML as `nil`
- or an item of type `'a`, followed by the rest of the list of `'a`s, which may be empty
  * `+: of 'a * 'a list`
  * Defined in Standard ML as `::`

A binary tree could be defined as two cases as well:

- A `leaf`
- Or a `node`, containing an item of type `'a` and two subtrees, `left` and `right`

User-defined operators, like `+:` used here, may be made usable infix, that is, between two arguments, by using the `infixr <N> op` and `infix <N> op` keywords. Taking subtraction as an example, e.g., `3 - 4 - 5 - 6`:

* If subtraction were defined `infixr`, it would try to parse it as `(3 - (4 - (5 - 6))) = ~2`
* But subtraction is defined `infix`, so it actually parses as `(((3 - 4) - 5) - 6) = ~12`

`<N>` specifies how tightly operators bind to their arguments. Given two operators, `*` and `-`, and the expression `3 * 4 - 5`:

- `infix 3 *`, `infix 4 -` would parse as `(3 * (4 - 5)) = ~3`
- `infix 4 *`, `infix 3 -` would parse as `((3 * 4) - 5) = 7`
