datatype dog = dog of { name : string }
val n = (1,2,3)
val (_,two,_) = n
val (x,y,z) = n

val charlie = dog { name = "Charlie" }
val lucky   = dog { name = "Lucky" }
val dog{name=pup1} = lucky
val dog{name=pup2} = charlie
val [_, second, _] = [1, 2, 3]

(* Type error *)
(* val (x,y) = n *)
