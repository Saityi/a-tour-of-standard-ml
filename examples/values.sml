val i = 10
val j : real = 10.0
val k = i

(* Adding to i here simply returns a new value,
 * rather than modifying k or i *)
val i' = i + 1

(* This new value may ignored, but that does not change i *)
val _ = i + 1

(* This is useful to run something like 'print';
 * it cannot be run as a standalone statement as
 * it returns a value, as all function calls do
 * in Standard ML
 *)
val _ = print "Hello!\n"

(* Names may be redefined *)
val i = 10

val iEqK = i = k (* true *)
