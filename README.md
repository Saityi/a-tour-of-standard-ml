# A Tour of Standard ML

## What is Standard ML?

Standard ML is a functional programming language with a formal specification. It has static types to prevent a wide array of common errors, but also features powerful type inference, requiring few to no type declarations. It is easy to define new data types and structures, due to [algebraic data types](https://en.wikipedia.org/wiki/Algebraic_data_type), and write well-abstracted, easy to reason about code due to its powerful module system and [parametric polymorphism (generics)](https://en.wikipedia.org/wiki/Parametric_polymorphism).

There are free, full-program optimising compilers for it, producing efficient native code, such as [MLton](http://www.mlton.org/). The concurrency extension 'Concurrent ML' provides support for [communicating sequential processes](https://en.wikipedia.org/wiki/Communicating_sequential_processes), and is supported by SML/NJ and MLton.

## Prerequisites

- Install Standard ML of New Jersey: https://www.smlnj.org/
  - SML/NJ contains an interactive compiler manager / REPL which will be used for the examples throughout this tour
  - SML/NJ will also install an implementation of the standard library, the SML Basis Library.
- Ensure SML/NJ has been added to the path as appropriate for your architecture
- Clone this repository and begin the tour!

# The Tour

This tour is intended to be followed at a Standard ML REPL. There are several files you may load, included in the repository, with some definitions.
```
a-tour-of-sml/ $ sml
```
```sml
(* REPL *)
Standard ML of New Jersey v110.93
- use "examples/00-01-hello.sml";
[opening examples/00-01-hello.sml]
Hello, world!
val it = () : unit
```
`it` always contains the value of the last expression evaluated in the REPL.

Note: REPL examples are cleaned up slightly, such as removing the unit return value information. The text that appears in your REPL may differ somewhat, as a result.

# Basics

## Modules, values, functions
### Values
The `val` keyword allows you to give a name to values.

```sml
- val i = 10;
val i = 10 : int
```
Values may be given explicit type declarations, but they are not required.
```sml
- val j: real = 10.0;
val j = 10.0 : real
```
It is possible to name multiple values at once to be used in some expression
```sml
- let val x = 1
=     val y = 2
= in x + y
= end;
val it = 3 : int
```
Outside of the expression, however, their names become unbound again:
```sml
- let val x = 1 in x end;
val it = 1 : int
- x;
stdIn:13.1 Error: unbound variable or constructor: x
```
Equality is tested using `=`
```sml
val _ = i = k (* true *)
```

Note that `val` gives a name to an immutable value. It is not a mutable/variable reference.

### Basic data types

Standard ML has six data types built in:
```sml
(* Unit -- has only one value: () *)
- val u = ();
val u = () : unit

(* Booleans : bool *)
- val b = true;
val b = true : bool

(* Integers : int *)
- val i = 1;
val i = 1 : int

(* Note that negation is performed using a tilde *)
- ~1;
val it = ~1 : int;

(* Floating point numbers : real *)
- val r = 2.0;
val r = 2.0 : real

(* Note that negation is performed using a tilde *)
- ~2.0;
val it = ~2.0 : real;

(* Strings : string *)
- val s = "s";
val s = "s" : string

(* ASCII Characters : char *)
- val c = #"c";
val c = #"c" : char
```

### Compound data types
Standard ML has three built-in data structures:
```sml
(* Tuples *)
val t : (int * int) = 
    (1, 2)

(* Lists *)
val l : int list = 
    [1, 2, 3]

(* Records *)
val r : {name:string, occupation:string} = 
    {name="Zaphod Beeblebrox", occupation="President of the Galaxy"}

(* Fields of records may be accessed using #field record *)

val _ = #1 t (* 1 *)
val _ = #occupation r (* "President of the Galaxy" *)
```
Note that records are not associative maps (dictionaries); the label fields of records may only be an alphanumeric name, or a number greater than 0. 
```sml
(* Arbitrary values, such as strings, may not be used as fields *)
- {"a"=1};
stdIn:3.2-3.6 Error: syntax error: deleting  STRING EQUALOP
- {a=1};
val it = {a=1} : {a:int}
- {1=1} ;
val it = {1=1} : {1:int}
```

Tuples are a special case of records with number labels: 
```sml
- {1 = "a", 2 = "b"} = ("a", "b");
val it = true : bool
```

### Functions
Functions are declared using `fn`, and may be given a name with `val`. All functions take one argument and are curried. 
```sml
- val inc = fn x => x + 1;
val inc = fn : int -> int
```
To declare a function with multiple arguments, use multiple functions.
```sml
- val add = fn x => fn y => x + y
val add = fn : int -> int -> int
```
`inc'` partially applies `add` to 1, to create a new function. This has the same behaviour as `inc`.
```sml
- val inc' = add 1;
val inc' = fn : int -> int
```
As the single argument `fn` form is harder to work with, there is syntactic sugar for declaring functions of any number of arguments: `fun`. Here we declare `add'`, which has the same behaviour as `add`, but with a simpler definition.
```sml
- fun add' x y = x + y;
val add' = fn : int -> int -> int
```
Type declarations are not required, as Standard ML features type inference, but may be provided. If provided, they must be surrounded by parenthesis.
```sml
- fun sub (x: int) (y: int) = x - y;
val sub = fn : int -> int -> int
```
You may make an uncurried version of the function by accepting a tuple as an argument.
```sml
- fun mul (x, y) = x * y;
val mul = fn : int * int -> int
``` 
This may also be provided with type declarations.
```sml
- fun div' (x: int, y: int) = x div y;
val div' = fn : int * int -> int
```
Standard ML has tuples, so functions may return any number of results.
```sml
- fun divmod x y = (x div y, x mod y);
val divmod = fn : int -> int -> int * int
```

You may refer to an operator using `op`

```sml
val add' = (op +)
```

While all functions take one argument, you may not need one, such as a in function that produces side effects, but requires no input. To write such a function, you use a `unit` argument. `unit` is a type with only one value, `()`. 
```sml
- fun printExample () = print (Int.toString (add 42 13));
val printExample = fn : unit -> unit
- ();
val it = () : unit
```
In Standard ML, everything must produce a value, so side-effecting functions return `unit`, as well. This may be seen when you call the `use` function to load the functions module:
```sml
(* REPL *)
- use "examples/01-05-fun.sml";
[opening examples/01-05-fun.sml]
val add = fn : int -> int -> int
val sub = fn : int -> int -> int
val mul = fn : int * int -> int
val divide = fn : int * int -> int
val divmod = fn : int * int -> int * int
val printExample = fn : unit -> unit
val add' = fn : int * int -> int
val it = () : unit
```
`use` returns `() : unit` after opening the file.

### Modules

Every Standard ML program is composed of modules. Modules group together a set of definitions. Here, we define a module named `Modules` by using the `structure` keyword, with one definition, `fun favouriteNum ()`:
```sml
(* examples/01-06-modules.sml *)
structure Modules = struct
  open String
  structure R = Random

  fun favouriteNum () =
      let val seed  = R.rand (0, 0)
          val myInt = R.randRange (0, 10) seed
      in print ("My favourite number is " ^ (Int.toString myInt) ^ "\n")
      end
end
```
This program uses the modules `String`, `Int`, and `Random`.

- `String` is `open`ed, bringing its definitions into the environment of the `Modules` module. The function `^` comes from the `String` module, and concatenates two strings.
- `Random` is aliased as `R`, to shorten its usage, while avoiding polluting the environment with its definitions directly.
- `Int` is used directly.
```sml
(* REPL *)
- use "examples/01-06-modules.sml";
- Modules.favouriteNum ();
```

### Module signatures
In Standard ML, modules expose all of their contents by default, but what is exported may be controlled by defining a signature of the exports for the module.

```sml
(* examples/01-07-signatures.sml *)
structure Math : sig
  val e : real
end = struct
  val e : real  = 2.7182
  val pi : real = 3.1415
end

(* REPL *)
- use "examples/01-07-signatures.sml";
structure Math : sig val e : real end

- Math.e;
- val it = 2.7182 : real
- Math.pi;
stdIn:38.1-38.8 Error: unbound variable or constructor: pi in path Math.pi
```

### Signatures, continued

Signatures do not necessarily need to be tied to a specific module. A signature may be defined separately, and have multiple implementations.

```sml
(* examples/01-08-signatures.sml *)
signature GREETING = sig
  val greeting : string
end

structure EnglishGreeting : GREETING = struct
  val greeting = "Hello.\n"
end

structure ValyrianGreeting : GREETING = struct
  val greeting = "Valar morghulis.\n"
end

val _ = print EnglishGreeting.greeting
val _ = print ValyrianGreeting.greeting
```

Signatures, by convention, are `UPPERCASE`.

```sml
(* REPL *)
- use "examples/01-08-signatures.sml";
Hello.
Valar morghulis.
```

### Parameterised modules

Modules may accept other modules as parameters, including accepting a signature rather than a specific implementation. These are called functors, and declared using the `functor` keyword.

```sml
(* examples/01-09-functors.sml *)
signature GREETING = sig
  val greeting : string
end

functor Greeter (G : GREETING) = struct
  fun greet () = print G.greeting
end

structure EnglishGreeting : GREETING = struct
  val greeting = "Hello.\n"
end

structure ValyrianGreeting : GREETING = struct
  val greeting = "Valar morghulis.\n"
end

structure englishGreeter = Greeter(EnglishGreeting)
structure essosGreeter = Greeter(ValyrianGreeting)

val _ = englishGreeter.greet ()
val _ = essosGreeter.greet ()

(* REPL *)
- use "examples/01-09-functors.sml";
Hello.
Valar morghulis.
```

This allows you to depend on interfaces to modules rather than specific implementations, and to parameterise your dependency on modules rather than directly referencing them.

### Data type declarations

Type aliases may be defined using the `type` keyword.
```sml
type major_arcana_card = (string * int)
```

New data types may be declared using the `datatype` keyword. 

```sml
- datatype card_suit = swords | wands | cups | disks;
datatype card_suit = cups | disks | swords | wands
- swords;
val it = swords : card_suit
- datatype card_value = prince | princess | knight | queen | one | two | three | four | five | six | seven | eight | nine | ten;
```

The data type `card_suit` consists of four exclusive cases, while `card_value` consists of 14. These datatypes may be parameterised by other types to hold additional information.

```sml
datatype minor_arcana_card = minor_arcana_card of {suit: card_suit, value: card_value}

datatype tarot_card = major_arcana of major_arcana_card
                    | minor_arcana of minor_arcana_card
```

### Recursive data types
Types may be recursive, making it easy to define recursive data structures like lists or trees. For example, a list of `'a`s is either:

- empty
  * `nil`
- or an item of type `'a`, followed by the rest of the list of `'a`s, which may be empty
  * `:: of 'a * 'a list`

```sml
(* examples/01-11-recursive-datatypes.sml *)
datatype 'a list = nil 
                 | :: of 'a * 'a list
```

A binary tree could be defined as:

- A `leaf`
- Or a `node`, containing an item of type `'a` and two subtrees
 
```sml
datatype 'a tree = leaf
                 | node of ('a * 'a tree * 'a tree)

val _ = 1 :: 2 :: 3 :: nil
val _ = node (1, 
              node (2, leaf, leaf), 
              node (2, leaf, leaf)
```

The standard library defines several more structures, including arrays, array slices, and vectors:

http://sml-family.org/Basis/overview.html

## Programming in Standard ML (Flow Control)

### Pattern Matching

Standard ML allow you to pattern match on values, providing case anaylsis. Using the `list` previously defined, we could pattern match on its cases and apply a function to each value in the list.

```sml
fun map f xs =
  case xs of
    nil     => nil
  | x :: xs => 
    let val x'  = f x
        val xs' = map f xs
    in x' :: xs'
    end
```

- If the list is empty there's nothing to do: return the empty list.
  * `case xs of nil => nil`
- If the list has an item, `x`: 
  * apply `f` to `x` to produce `x'`
  * apply `map f` to the rest of the list `xs` to produce `xs'`
  * create a new list of the transformed item, `x'`, and the transformed rest of the list, `xs'`
    * `x' :: xs'`

It's possible to pattern match directly in the function definition and avoid the intermediate values to make it less verbose, as in `map'`.

```sml
fun map' f nil       = nil
  | map' f (x :: xs) = f x :: map' f xs
```

SML exhaustivity checking (making sure all cases of a data type are handled) on data types. Here, we get a warning that we haven't handled the recursive case of a list having items.

```sml
fun inexhaustive nil = nil

(*
 * 02-01-exhaustive.sml:1.6-1.28 Warning: match nonexhaustive
            nil => ... *)
```

Standard ML allows you to deconstruct values using the `val` keyword, as well, in place of using the `case` construct.

```sml
- val (x, y) = (1, 2);
val x = 1 : int
val y = 2 : int
```

All of these together makes it easy to express your problem as a set of cases, which you can then decompose and compose to write your logic.

```sml
open String

datatype player = mage of {name: string, magic_type: string}
                | warrior of {name: string, weapon: string}

fun greet_player (mage {name=name, magic_type=magic_type}) =
    print ("Greetings, " ^ name ^ ", master of the " ^ magic_type ^ "!\n")
  | greet_player (warrior {name=name, weapon=weapon}) =
    print ("Hullo, " ^ name ^ ", wielder of " ^ weapon ^ "!\n")

val _ = greet_player (warrior {name="Grom", weapon="Gorehowl"})
```

### Conditional expressions

Standard ML defines one conditional expression: 
```sml
- if true then 1 else 0;
val it = 1 : int
```

You may define additional cases by chaining the if-else expressions
```sml
val _ =
  if (1 = 0)
  then 1
  else if (1 = 1)
  then ~1
  else 0;
```

Note that all branches of the if-else expression must have the same type.
```sml
- if true then () else 1;
stdIn:16.1-16.23 Error: types of if branches do not agree [overload conflict]
  then branch: unit
  else branch: [int ty]
  in expression:
    if true then () else 1
```

### Iteration
Iteration may be expressed using recursion, such as this function which pattern matches on the `list` type cases to recursively add a list:

```sml
- fun sum [] = 0
=   | sum (x :: xs) = x + sum xs;
val sum = fn : int list -> int
- sum [1, 2, 3];
val it = 6 : int
```

Standard ML automatically optimises tail recursive calls, so this will not explode the stack, regardless of the size of the list.

You may frequently avoid direct recursion by use of higher-order functions: pass in a function to another function, which then handles the details of iteration or aggregation using your passed in the function. Examples include:

- `map f xs`, which applies a function `f` to each element in `xs`, creating a new list
- `List.filter p xs`, which filters a list using a predicate `p`, creating a new list containing any items that returned `true` for `p x`
- `foldr c s xs` lets you combine the items of a list to a summary value, using some combining operation `c` and a starting value `s`

```sml
val _ = map (fn x => x + 1) [1, 1, 1] (* [2, 2, 2] *)
val _ = List.filter (fn x => x mod 2 = 0) [1, 2, 3] (* [2] *)
```

### Infinite loops
You may encode an infinite loop using recursion:

```sml
fun forever () = forever ();
val forever = fn : unit -> 'a
- forever ();

(* Ctrl+C *)
Interrupt
-
```

### Chaining effectful calls
In Standard ML, everything is an expression which returns a result, but you may chain multiple expressions in an imperative-like form for their side effects by separating them by semicolons. The result of these chains is the last expression in the block.

```sml
- (print "Hello, "; print "world!"; print "\n");
Hello, world!
val it = () : unit
```

### Mutable references
As noted previously, everything in Standard ML is immutable by default. `val` gives a name to a value. This is most commonly how SML is used, and mutability is rare. It may be useful sometimes to have a mutable reference, so SML does provide the capability to do so.

```sml
val x = ref 10 : int ref
- val y = ref 20;
val y = ref 20 : int ref
- x := !x + !y;
val it = () : unit
- x;
val it = ref 30 : int ref
```

You may define a reference using `ref`, get its value using `!` before the name, and set it using `:=`.

Functions may even accept references as parameters, and this is reflected in the type system:

```sml
- fun ++ x = (x := !x + 1; !x);
val ++ = fn : int ref -> int
- val x = ref 0;
val x = ref 0 : int ref
- ++x;
val it = 1 : int
- x;
val it = ref 1 : int ref
```
### While loops
Standard ML has a `while` loop defined which may be used in place of recursion or higher order functions, wherein one expression is repeated while a condition holds.

Recursion and higher order functions tend to be preferred, as `while` only makes sense with a mutable condition, and Standard ML tends to prefer immutability.

```sml
val x = ref 0

val _ =
  while (!x) <> 10 do (
    x := !x + 1;
    print (Int.toString (!x));
    print "\n"
  )
```

## Concurrency

Note that for all examples in this section, it is assumed the CML library has been loaded and opened:

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


### Spawn

`spawn` creates a lightweight thread managed by the Concurrent ML runtime.

```sml
(* examples/03-01-spawn.sml *)
open CML
open TextIO

fun say s = 
  let val delay = Time.fromMilliseconds 100
      val waitThenPrint = fn () => ( 
          OS.Process.sleep delay; 
          print s
        )
      val i = ref 0
  in while (!i) < 5 do ( 
      waitThenPrint (); 
      i := (!i) + 1
  )
  end

fun main () = ( 
    spawn (fn () => say "World!\n");
    say "Hello!\n"
)

val _ = RunCML.doit (main, NONE)
(*
Hello!
World!
World!
Hello!
Hello!
World!
World!
Hello!
Hello!
World!
*)
```

### Channels

Channels are a typed conduit through which you can send and receive values with the channel `send` and `recv` functions.

```sml
(* Send to channel ch *)
- send (ch, v);
(* Receive from ch and give it a name v *)
- val v = recv ch;
```

```sml
open CML
open TextIO

fun sum s c = send (c, foldr (op +) 0 s)

fun main () = 
  let val s = [7, 2, 8, ~9, 4, 0]
      val ch = channel ()
      val slen = (List.length s div 2)
      val x = ref 0
      val y = ref 0
  in ( 
      spawn (fn () => sum (List.take (s, slen)) ch); 
      spawn (fn () => sum (List.drop (s, slen)) ch); 
      x := recv ch; 
      y := recv ch; 
      print (Int.toString (!x)); 
      print " "; 
      print (Int.toString (!y)); 
      print " "; 
      print (Int.toString (!x + !y)); 
      print "\n"
  )
  end

val _ = RunCML.doit(main, NONE)
(* 17 ~5 12 *)
```

Note that `send` is a blocking operation. It will not return until another thread attempts to `recv`.

### Select
`select` lets a thread wait on a list of communication events. 

```sml
open CML
open TextIO
fun fib c q =
  let val x = ref 0
      val y = ref 1
      val break = ref false
      val nextFib = fn x' =>
        let val tmp = !x
        in ( 
          x := !y; 
          y := tmp + (!y)
        )
        end
  in while not (!break) do
      select 
        [ wrap (sendEvt (c, !x), nextFib )
        , wrap (recvEvt q, fn _ => ( 
            break := true; 
            print "quit\n" 
          ))
        ]
  end

fun print_channel c q =
  let val i = ref 0
  in ( 
    while (!i) < 10 do ( 
      print (Int.toString (recv c)); 
      print "\n"; 
      i := (!i) + 1
    ); 
    send (q, true)
  )
  end

fun main () =
  let val c : int chan = channel ()
      val q : bool chan = channel ()
  in ( 
    spawn (fn () => print_channel c q); 
    fib c q 
  )
  end

val _ = RunCML.doit(main, NONE)
(*
0
1
1
2
3
5
8
13
21
34
quit
*)
```

### Mailboxes

In the previous section we used synchronous channels, but CML provides asynchronous channels with a nonblocking `send`, called Mailboxes:

```sml
- open Mailbox;
- val m : int mbox = mailbox ();
- send (m, 10);
val it = () : unit
- m;
val it = MB (ref (NONEMPTY (1,{front=#,rear=#}))) : int mbox
- recv m;
val it = 10 : int
- m;
val it = MB (ref (EMPTY {front=[],rear=[]})) : int mbox
```

### M and I-variables

Sometimes you may need threadsafe, mutable variables. Concurrent ML provides them in two flavours.

#### I-variables

An `ivar` may be in one of two states: empty, or full. An `ivar` may be written once, and provides synchronisation on reads. Once written, the `ivar` is full, and further writes are an error:

```sml
- val i : int ivar = iVar ();
val i = - : int ivar
- iPut (i, 10);
val it = () : unit
- iPut (i, 10);

uncaught exception Put
  raised at: cml/src/core-cml/sync-var.sml:142.42-142.45
```

As a value may not be put yet, there is a nonblocking operation that returns an option:

```sml
- val j : int ivar = iVar ();
val j = - : int ivar
- iGetPoll j;
val it = NONE : int option
- iPut (j, 0);
val it = () : unit
- iGetPoll j;
val it = SOME 0 : int option
```

I-variables work with the event framework of CML, and thus may be an event source for threads to `select` upon, if used with `iGetEvt`.

#### M-variables

M-variables are much like I-variables, but may be written to multiple times. Writing to a full M-Variable is an error, but taking from an `mvar` clears its contents. You may get an M-Variable without clearing its contents using `mGet`, or with clearing its contents using `mTake`.

```sml
- val i : int mvar = mVar ();
val i = - : int mvar
- mPut (i, 10);
val it = () : unit
- mGet i;
val it = 10 : int
- mPut (i, 10);

uncaught exception Put
  raised at: cml/src/core-cml/sync-var.sml:203.42-203.45
- mTake i;
val it = 10 : int
- mPut (i, 0);
val it = () : unit
- mGet i;
val it = 0 : int
```

M-variables provide similar integration with the event framework as I-variables.