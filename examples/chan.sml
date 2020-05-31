fun sum s c = CML.send (c, foldr (op +) 0 s)

fun main () = 
  let val s = [7, 2, 8, ~9, 4, 0]
      val ch = CML.channel ()
      val slen = (List.length s div 2)
      val x = ref 0
      val y = ref 0
  in ( 
      CML.spawn (fn () => sum (List.take (s, slen)) ch); 
      CML.spawn (fn () => sum (List.drop (s, slen)) ch); 
      x := CML.recv ch; 
      y := CML.recv ch; 
      print (Int.toString (!x)); 
      print " "; 
      print (Int.toString (!y)); 
      print " "; 
      print (Int.toString (!x + !y)); 
      print "\n"
  )
  end

val _ = RunCML.doit(main, NONE)
(* 17 ~5 12 *)
