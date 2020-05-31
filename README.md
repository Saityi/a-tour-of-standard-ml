[![Build Status](https://travis-ci.com/Saityi/a-tour-of-standard-ml.svg?branch=master)](https://travis-ci.com/Saityi/a-tour-of-standard-ml)

# A Tour of Standard ML
A fully featured tour is available at [A Tour of Standard ML](https://saityi.github.io/sml-tour/).

A Tour of Standard ML is built using [Hakyll](https://jaspervdj.be/hakyll/); this repository hosts the source for the site generator.

## What is Standard ML?

Standard ML is a functional programming language with a formal specification. It has static types to prevent a wide array of common errors, but also features powerful type inference, requiring few to no type declarations. It is easy to define new data types and structures, due to [algebraic data types](https://en.wikipedia.org/wiki/Algebraic_data_type), and write well-abstracted, easy to reason about code due to its powerful module system and [parametric polymorphism (generics)](https://en.wikipedia.org/wiki/Parametric_polymorphism).

There are free, full-program optimising compilers for it, producing efficient native code, such as [MLton](http://www.mlton.org/). The concurrency extension 'Concurrent ML' provides support for [communicating sequential processes](https://en.wikipedia.org/wiki/Communicating_sequential_processes), and is supported by SML/NJ and MLton.

## Prerequisites

- Install Standard ML of New Jersey: https://www.smlnj.org/
  - SML/NJ contains an interactive compiler manager / REPL which will be used for the examples throughout this tour
  - SML/NJ will also install an implementation of the standard library, the SML Basis Library.
- Ensure SML/NJ has been added to the path as appropriate for your architecture
- Clone this repository and begin the [tour!](https://saityi.github.io/sml-tour)
