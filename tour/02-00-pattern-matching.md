---
chapter: Working in Standard ML
title: Pattern matching
index: 2
section: 0
---
Standard ML allow you to pattern match on values, providing case anaylsis. Using the `list` built into Standard ML, we could pattern match on its cases and apply a function to each value in the list.

- If the list is empty (case `nil`), there's nothing to do: return the empty list.
- If the list has an item, `x`:
  * apply `f` to `x`
  * apply `map f` to the rest of the list `xs`
  * create a new list of the transformed item, `x'`, and the transformed rest of the list, `xs'`
    * `x' :: xs'`

It's possible to pattern match directly in the function definition and avoid the intermediate values to make it less verbose, as in `map'`.