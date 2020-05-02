val x = ref 0

val u =
  while (!x) <> 10 do (
    x := !x + 1;
    print (Int.toString (!x));
    print "\n"
  )