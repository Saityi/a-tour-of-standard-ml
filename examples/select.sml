open CML
open TextIO
fun fib c q =
  let val x = ref 0
      val y = ref 1
      val break = ref false
      val nextFib = fn x' =>
        let val tmp = !x
        in ( 
          x := !y; 
          y := tmp + (!y)
        )
        end
  in while not (!break) do
      select 
        [ wrap (sendEvt (c, !x), nextFib )
        , wrap (recvEvt q, fn _ => ( 
            break := true; 
            print "quit\n" 
          ))
        ]
  end

fun print_channel c q =
  let val i = ref 0
  in ( 
    while (!i) < 10 do ( 
      print (Int.toString (recv c)); 
      print "\n"; 
      i := (!i) + 1
    ); 
    send (q, true)
  )
  end

fun main () =
  let val c : int chan = channel ()
      val q : bool chan = channel ()
  in ( 
    spawn (fn () => print_channel c q); 
    fib c q 
  )
  end

val _ = RunCML.doit(main, NONE)
(*
0
1
1
2
3
5
8
13
21
34
quit
*)