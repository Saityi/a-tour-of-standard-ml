# A Tour of Standard ML

## Prerequisites

- Install Standard ML of New Jersey: https://www.smlnj.org/
  - SML/NJ contains an interactive compiler manager / REPL which will be used for the examples throughout this tour
  - SML/NJ will also install an implementation of the standard library, the SML Basis Library.
- Ensure SML/NJ has been added to the path as appropriate for your architecture
- Clone this repository and begin the tour!
## The Tour
This tour is made up of several files intended to be loaded into an SML REPL, as so:

```
a-tour-of-sml/ $ sml
```
```sml
(* REPL *)
Standard ML of New Jersey v110.93 [built: Thu Sep 05 19:16:24 2019]
- use "src/hello.sml";
[opening src/hello.sml]
[autoloading]
[library $SMLNJ-BASIS/basis.cm is stable]
[library $SMLNJ-BASIS/(basis.cm):basis-common.cm is stable]
[autoloading done]
structure Hello :
  sig
    val hello : unit -> unit
    val main : 'a * 'b -> Word32.word
  end
val it = () : unit
- Hello.hello ();
Hello!
```
`it` always contains the value of the last expression evaluated in the REPL.

You may start up an environment with all of the examples loaded by compiling the defintions in SML/NJ `.cm` file.

```sml
(* REPL *)
- CM.make "tour.cm";
```

Note: REPL examples are cleaned up slightly, such as removing the unit return value information. The text that appears in your REPL may differ somewhat, as a result.

---

Every Standard ML program is made up of modules. Here, we define a module named `Modules` by using the `structure` keyword:
```sml
(* modules.sml *)
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
- use "modules.sml";
- Modules.favouriteNum ();
```
---

In Standard ML, structures expose all of their contents, but what is exported may be controlled by defining a signature for the structure.

```sml
(* signatures.sml *)
structure Math : sig
  val e : real
end = struct
  val e : real  = 2.7182
  val pi : real = 3.1415
end

(* REPL *)
- use "signatures.sml";
[opening signatures.sml]
structure Math : sig val e : real end

- Math.e;
- val it = 2.7182 : real
- Math.pi;
stdIn:38.1-38.8 Error: unbound variable or constructor: pi in path Math.pi
```

Exercise: Fix the error by adding `pi` to the `sig` of `Math`, save, and reload the file in your REPL. Try to evaluate `Math.pi` again.

---

Signatures do not necessarily need to be tied to a specific structure. A signature may be defined separately, and have multiple implementations.

```sml
(* greeting.sig *)
signature GREETING = sig
  val greeting : string
end

(* greeting1.sml *)
structure EnglishGreeting :> GREETING = struct
  val greeting = "Hello.\n"
end

(* greeting2.sml *)
structure ValyrianGreeting :> GREETING = struct
  val greeting = "Valar morghulis.\n"
end
```

Signatures, by convention, are `UPPERCASE`.

```sml
(* REPL *)
- use "src/greeting.sig";
[opening src/greeter.sig]
signature GREETING = sig val greeting : string end

- use "src/greeting1.sml";
[opening src/greeter1.sml]
structure EnglishGreeting : GREETING

- use "src/greeting2.sml";
[opening src/greeter2.sml]
structure ValyrianGreeting : GREETING

- EnglishGreeting.greeting;
val it = "Hello.\n" : string

- ValyrianGreeting.greeting;
val it = "Valar morghulis.\n" : string
```

---

Modules may accept other modules as parameters, including accepting a signature rather than a specific implementation. These are called functors.

```sml
(* greeter.sml *)
functor Greeter (G : GREETING) = struct
  fun greet () = print G.greeting
end

(* REPL *)
- structure englishGreeter = Greeter(EnglishGreeting);
structure englishGreeter : sig val greet : unit -> unit end
- englishGreeter.greet ();
Hello.

- structure essosGreeter = Greeter(ValyrianGreeting);
structure essosGreeter : sig val greet : unit -> unit end
- essosGreeter.greet ();
Valar morghulis.
```

---
Functions are declared using `fn`, and may be given a name with `val`, such as `inc`. All functions take one argument and are curried. To declare a function with multiple arguments, use multiple functions, as in `add`. 

`inc'` partially applies `add` to 1, to create a new function. This has the same behaviour as `inc`.
```sml
(* functions.sml *)
structure Functions = struct
  val inc = fn x => x + 1
  val add = fn x => fn y => x + y
  val inc' = add 1

  fun add' x y = x + y

  fun sub (x: int) (y: int) = x - y
  fun mul (x, y) = x * y
  fun div' (x: int, y: int) = x div y
  fun divmod x y = ((x div y), (x mod y))

  fun printExample () = print (Int.toString (add 42 13))
end
```
As the single argument `fn` form is harder to work with, there is syntactic sugar for declaring functions of any number of arguments -- `fun`. This is first seen in `Functions` to declare `add'`, which is equivalent to `add`, but with a simpler definition. 

Type declarations are not required, as Standard ML features powerful type inference, but may be provided. If provided, they must be surrounded by parenthesis, as seen in `sub`.

You may make an uncurried version of the function by accepting a tuple as an argument, as seen in `mul`. This may also be provided with type declarations, as in `div'`.

Standard ML has tuples, so functions may return any number of results, as in `divmod`.

While all functions take one argument, you may not need one, such as a in function that produces side effects, but requires no input. To write such a function, you use a `unit` argument, as seen in `printExample`. `unit` is a type with only one value, `()`. 

In Standard ML, everything must produce a value, so side-effecting functions return `unit`, as well. This may be seen when you call the `use` function to load the functions module:

```sml
(* REPL *)
- use "functions.sml";
[opening functions.sml]
structure Functions :
  sig
    val inc : int -> int
    val add : int -> int -> int
    val inc' : int -> int
    val add' : int -> int -> int
    val sub : int -> int -> int
    val mul : int * int -> int
    val div' : int * int -> int
    val divmod : int -> int -> int * int
    val printExample : unit -> unit
  end
val it = () : unit
```
`use` returns `() : unit` after opening the file, and the signature of `printExample` shows a `unit` return type, as well.

---
