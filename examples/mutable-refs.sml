val x = ref 10
val y = ref 20

(* Although an 'assignment', returns unit, as assignment
 * is an expression and returns a value *)
val _ = x := !x + !y
val _ = !x (* 30 *)

fun ++ (x: int ref) : int = (
    x := !x + 1;
    !x (* Return the new value of x *)
)

val x = ref 0
val xNewState = ++x (* 1 *)
val xValue = !x (* 1 *)
