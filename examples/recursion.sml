fun sum []        = 0
  | sum (x :: xs) = x + sum xs

fun sum_iter xs =
  let fun sum_iter' [] acc        = acc
        | sum_iter' (x :: xs) acc = sum_iter' xs (x + acc)
  in sum_iter' xs 0
  end

val s = sum [1, 2, 3]
val s' = sum_iter [1, 2, 3]
