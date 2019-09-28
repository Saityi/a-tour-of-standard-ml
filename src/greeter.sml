functor Greeter (G : GREETING) = struct
  fun greet () = print G.greeting
end