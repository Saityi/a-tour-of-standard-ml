val inc : int -> int =
    fn y =>
        1 + y

val add : int -> int -> int =
    fn x => fn y =>
        x + y

val inc' : int -> int =
    add 1

val t = (inc' 1) = (inc 1) (* true *)
