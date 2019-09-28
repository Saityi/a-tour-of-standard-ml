structure Functions = struct
  val inc = fn x => x + 1
  val add = fn x => fn y => x + y
  val inc' = add 1

  fun add' x y = x + y

  fun sub (x: int) (y: int) = x - y
  fun mul (x, y) = x * y
  fun div' (x: int, y: int) = x div y
  fun divmod x y = ((x div y), (x mod y))

  fun printExample () = print (Int.toString (add 42 13))
end
