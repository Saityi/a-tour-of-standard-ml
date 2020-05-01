val x = ref 0

val _ =
  while (!x) <> 10 do (
    x := !x + 1;
    print (Int.toString (!x));
    print "\n"
  )