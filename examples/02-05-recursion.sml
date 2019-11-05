
fun sum []        = 0
  | sum (x :: xs) = x + sum xs

val _ = sum [1, 2, 3] (* 6 *)