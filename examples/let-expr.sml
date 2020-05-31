val lexpr =
  let val x = 1
      val y = 2
  in x + y
  end

(* REPL *)
(* - x;
 * stdIn:13.1 Error: unbound variable or constructor: x *)