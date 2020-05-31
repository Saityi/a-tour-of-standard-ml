---
chapter: Basics
title: Values
index: 1
section: 0
---

The `val` keyword allows you to give a name to values. An explicit type declaration is allowed, but not required, as it may be inferred.

Note that values are immutable in Standard ML, but names may be redefined to give a new value an old name.

Equality is tested using an equal sign, `=`.

When you `use "examples/values.sml"`, you may notice something strange:

```sml
val i = <hidden-value> : int
```

What is this and why is it there? Since we redefined `i` in the same scope, the interpreter shows that it was defined once, but overridden, and that the original value is inaccessible now with `<hidden-value>`.
