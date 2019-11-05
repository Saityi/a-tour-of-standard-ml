---
chapter: Concurrent ML
title: IVars
index: 3
section: 5
---
Sometimes you may need threadsafe, mutable variables. Concurrent ML provides them in two flavours.

An `ivar` may be in one of two states: empty, or full. An `ivar` may be written once, and provides synchronisation on reads. Once written, the `ivar` is full, and further writes are an error.

As a value may not be put yet, there is a nonblocking operation that returns an option, `iGetPoll`.

I-variables work with the event framework of CML, and thus may be an event source for threads to `select` upon, if accessed via `iGetEvt`.