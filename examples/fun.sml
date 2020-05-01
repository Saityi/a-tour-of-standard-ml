fun add x y = x + y

fun sub (x: int) (y: int) = x - y

fun mul (x, y) = x * y

fun divide (x: int, y: int) = x div y

fun divmod (x: int, y: int): (int * int) = (x div y, x mod y)

fun printExample () : unit = print "Hello!\n"

val add' = (op +)