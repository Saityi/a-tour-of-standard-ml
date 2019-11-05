---
chapter: Concurrent ML
title: Concurrent ML Introduction
index: 3
section: 0
---
Note that for all examples in this chapter, it is assumed the CML library has been loaded and opened:

```sml
- CM.make "$cml/basis.cm";
- CM.make "$cml/cml.cm";
- open CML;
opening CML
  val version : {date:string, system:string, version_id:int list}
  val banner : string
  type 'a event = 'a ?.RepTypes.event
  datatype thread_id = ...
  val getTid : unit -> thread_id
  val sameTid : thread_id * thread_id -> bool
  val compareTid : thread_id * thread_id -> order
  val hashTid : thread_id -> word
  val tidToString : thread_id -> string
  val spawnc : ('a -> unit) -> 'a -> thread_id
  val spawn : (unit -> unit) -> thread_id
  val exit : unit -> 'a
  val joinEvt : thread_id -> unit event
  val yield : unit -> unit
  val newThreadProp : (unit -> 'a)
                      -> {clrFn:unit -> unit, getFn:unit -> 'a,
                          peekFn:unit -> 'a option, setFn:'a -> unit}
  val newThreadFlag : unit -> {getFn:unit -> bool, setFn:bool -> unit}
  datatype 'a chan = ...
  val channel : unit -> 'a chan
  val sameChannel : 'a chan * 'a chan -> bool
  val send : 'a chan * 'a -> unit
  val recv : 'a chan -> 'a
  val sendEvt : 'a chan * 'a -> unit event
  val recvEvt : 'a chan -> 'a event
  val sendPoll : 'a chan * 'a -> bool
  val recvPoll : 'a chan -> 'a option
  val never : 'a event
  val alwaysEvt : 'a -> 'a event
  val wrap : 'a event * ('a -> 'b) -> 'b event
  val wrapHandler : 'a event * (exn -> 'a) -> 'a event
  val guard : (unit -> 'a event) -> 'a event
  val withNack : (unit event -> 'a event) -> 'a event
  val choose : 'a event list -> 'a event
  val sync : 'a event -> 'a
  val select : 'a event list -> 'a
  val timeOutEvt : Time.time -> unit event
  val atTimeEvt : Time.time -> unit event
```
