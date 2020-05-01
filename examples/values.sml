val i = 10
val j : real = 10.0
val k = i

(* Adding to i here simply returns a new value, 
 * rather than modifying k or i *)
val i' = i + 1

(* This new value may ignored *)
val _ = i + 1

(* Names may be redefined *)
val i = 10

val iEqK = i = k (* true *)