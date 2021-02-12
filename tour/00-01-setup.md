---
chapter: Welcome
title: Setup
index: 0
section: 1
---

### [Experimental] In-page compiler

Although having a local SML/NJ available will make the tour easier to experiment with, it is possible to run the code samples on the page. The code runner comes with several libraries preloaded:

- the standard library, known as [Basis](https://smlfamily.github.io/Basis/overview.html) 
- [SML/NJ's library](https://www.smlnj.org/doc/smlnj-lib/)
- [Concurrent ML](http://cml.cs.uchicago.edu/pages/refman.html) 

(NOTE: This is a new feature! Please file issues at [the Github issue tracker.](https://github.com/Saityi/a-tour-of-standard-ml/issues))

### Prerequisites to running examples locally

- [Install Standard ML of New Jersey](https://www.smlnj.org/)
  - SML/NJ contains an interactive compiler manager and REPL which will be used for the examples throughout this tour
  - SML/NJ will also install an implementation of the standard library, the SML Basis Library.
- Ensure SML/NJ has been added to the path as appropriate for your architecture
- Clone the [repository](https://github.com/Saityi/a-tour-of-standard-ml/) to get the examples and begin the tour!

``` sml
$ git clone https://github.com/Saityi/a-tour-of-standard-ml.git
$ cd a-tour-of-standard-ml
$ sml
Standard ML of New Jersey v110.97 [built: Wed Apr 22 09:39:44 2020]
- (* You may change the directory from within Standard ML *);
- OS.File.chDir("./examples");
val it = () : unit
- use "setup.sml";
[opening setup.sml]
Hello, world!
```

Note that REPL examples are cleaned up slightly; the text that appears in your REPL may differ somewhat, as a result.
