(* Tuples *)
val t : (int * int) =
    (1, 2)

(* Lists *)
val l : int list =
    [1, 2, 3]

(* Records *)
val r : {name:string, occupation:string} =
    {name="Zaphod Beeblebrox", occupation="President of the Galaxy"}

val tupleField1      = #1 t
val zaphodsOccuption = #occupation r
val tuplesAreRecords = {1="Hello", 2="world"} = ("Hello", "world")
