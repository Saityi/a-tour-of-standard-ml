fun say s =
  let val delay = Time.fromMilliseconds 100
      val i = ref 0
  in while (!i) < 5 do (
      OS.Process.sleep delay;
      print s;
      i := (!i) + 1
  )
  end

fun main () = (
    CML.spawn (fn () => say "World!\n");
    say "Hello!\n"
)

val _ = RunCML.doit (main, NONE)
