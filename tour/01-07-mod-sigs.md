---
chapter: Basics
title: Module Signatures
index: 1
section: 7
---
In Standard ML, modules expose all of their contents by default -- you likely noticed how noisy the `Module` signature was before, what with it containing all of the contents of opening `String` -- but what is exported may be controlled by defining a signature of the exports for the module.

```sml
(* REPL *)
- use "examples/mod-sigs.sml";
structure Math : sig val e : real end

- Math.e;
- val it = 2.7182 : real
- Math.pi;
stdIn:38.1-38.8 Error: unbound variable or constructor: pi in path Math.pi
```
