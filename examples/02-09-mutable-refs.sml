val x = ref 10
val y = ref 20

(* Although an 'assignment', returns unit, as assignment 
 * is an expression and returns a value *)
val _ = x := !x + !y
val _ = !x (* 30 *)

fun ++ (x: ref int) : int = (
    x := !x + 1;
    !x (* Return the new value of x *)
)

val x = ref 0
val _ = ++x (* 1 *)
val _ = !x (* 1 *)