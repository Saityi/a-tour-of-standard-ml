---
chapter: Basics
title: Modules
index: 1
section: 6
---
Every Standard ML program is composed of modules. Modules group together a set of definitions. Here, we define a module named `Modules` by using the `structure` keyword, with one definition, `fun favouriteNum ()`.

This program makes use of three other modules: `String`, `Int`, and `Random`.

- `String` is `open`ed, bringing its definitions into the environment of the `Modules` module. The function `^` comes from the `String` module, and concatenates two strings.
- `Random` is aliased as `R`, to shorten its usage, while avoiding polluting the environment with its definitions directly.
- `Int` is used directly.