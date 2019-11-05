val _ = map (fn x => x + 1) [1, 1, 1] (* [2, 2, 2] *)
val _ = List.filter (fn x => x mod 2 = 0) [1, 2, 3] (* [2] *)

(* NOTE: Actually builtin *)
fun foldr combiner aggregate nil       = aggregate
  | foldr combiner aggregate (x :: xs) = 
    let val the_rest_combined = foldr combiner aggregate xs
    in combiner (x, the_rest_combined)
    end

val sum       = foldr (op +) 0
val _ = sum [1, 2, 3] (* 6 *)
fun length xs = foldr (fn (_, length_count) => length_count + 1) 0 xs
val _ = length [1, 2, 3] (* 3 *)