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