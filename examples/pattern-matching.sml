fun map f xs =
  case xs of
    nil     => nil
  | x :: xs =>
    let val x'  = f x
        val xs' = map f xs
    in x' :: xs'
    end

fun map' f nil       = nil
  | map' f (x :: xs) = f x :: map' f xs
