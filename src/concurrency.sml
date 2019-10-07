structure Concurrency = struct
  open CML
  open TextIO
  fun say s = 
    let val delay = Time.fromMilliseconds 100
        val waitThenPrint = fn () => 
          ( OS.Process.sleep delay
          ; print s
          )
        val i = ref 0
    in while (!i) < 5 do
         ( waitThenPrint ()
         ; i := (!i) + 1
         )
    end

  fun say_main () = 
    ( spawn (fn () => say "World!\n")
    ; say "Hello!\n" 
    )

  fun sum s c = 
    send (c, foldl (op +) 0 s)

  fun sum_main () =
    let val s = [7, 2, 8, ~9, 4, 0]
        val ch = channel ()
        val slen = (List.length s div 2)
        val x = ref 0
        val y = ref 0
    in ( spawn (fn () => sum (List.take (s, slen)) ch)
       ; spawn (fn () => sum (List.drop (s, slen)) ch)
       ; x := recv ch
       ; y := recv ch
       ; print (Int.toString (!x)) ; print " "
       ; print (Int.toString (!y)) ; print " "
       ; print (Int.toString (!x + !y)) ; print "\n"
       )
    end

    fun fib c q =
      let val x = ref 0
          val y = ref 1
          val break = ref false
          val nextFib = fn x' =>
            let val tmp = !x
            in ( x := !y
               ; y := tmp + (!y)
               )
            end
      in while not (!break) do
           select 
            [ wrap (sendEvt (c, !x), nextFib )
            , wrap (recvEvt q, fn _ => ( break := true
                                       ; print "quit\n" ))]
      end

      fun print_channel c q =
        let val i = ref 0
        in ( while (!i) < 10 do
               ( print (Int.toString (recv c)); print "\n"
               ; i := (!i) + 1
               )
           ; send (q, true)
           )
        end

      fun fib_main () =
        let val c : int chan = channel ()
            val q : bool chan = channel ()
        in ( spawn (fn () => print_channel c q)
           ; fib c q 
           )
        end
end