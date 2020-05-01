val i = 10
val j : real = 10.0
val k = i

(* Adding to i here simply returns a new value, 
 * rather than modifying k or i *)
val _ = i + 1

(* This new value may be given a name *)
val h = i + 1

(* Names may be redefined *)
val i = 10

val _ = i = k (* true *)