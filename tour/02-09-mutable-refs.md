---
chapter: Working in Standard ML
title: Mutable references
index: 2
section: 9
---
As noted previously, everything in Standard ML is immutable by default. `val` gives a name to a value. This is most commonly how SML is used, and mutability is rare. It may be useful sometimes to have a mutable reference, so SML does provide the capability to do so.

You may define a reference using `ref`, get its value using `!` before the name, and set it using `:=`.

Functions may accept references as parameters, and this is reflected in the type.