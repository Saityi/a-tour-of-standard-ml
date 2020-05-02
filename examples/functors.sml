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

val u  = englishGreeter.greet ()
val u' = essosGreeter.greet ()