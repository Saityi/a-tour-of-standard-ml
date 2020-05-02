---
chapter: Welcome
title: Setup
index: 0
section: 1
---

### Prerequisites

- [Install Standard ML of New Jersey](https://www.smlnj.org/)
  - SML/NJ contains an interactive compiler manager and REPL which will be used for the examples throughout this tour
  - SML/NJ will also install an implementation of the standard library, the SML Basis Library.
- Ensure SML/NJ has been added to the path as appropriate for your architecture
- Clone the [repository](https://github.com/Saityi/a-tour-of-standard-ml/) to get the examples and begin the tour!

```
$ git clone https://github.com/Saityi/a-tour-of-standard-ml.git
```

### Getting Started

This tour is intended to be followed at the command line, using the Standard ML of New Jersey REPL. There are several files you may load included in the repository.

```sml
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
