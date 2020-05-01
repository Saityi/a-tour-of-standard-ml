(* Tuples *)
val t : (int * int) = 
    (1, 2)

(* Lists *)
val l : int list = 
    [1, 2, 3]

(* Records *)
val r : {name:string, occupation:string} = 
    {name="Zaphod Beeblebrox", occupation="President of the Galaxy"}

val _ = #1 t (* 1 *)
val _ = #occupation r (* "President of the Galaxy" *)
val _ = {1="Hello", 2="world"} = ("Hello", "world") (* true *)