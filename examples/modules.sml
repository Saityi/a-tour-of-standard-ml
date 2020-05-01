structure Modules = struct
  open String
  structure R = Random

  fun favouriteNum () =
      let val seed  = R.rand (0, 0)
          val myInt = R.randRange (0, 10) seed
      in print ("My favourite number is " ^ (Int.toString myInt) ^ "\n")
      end
end