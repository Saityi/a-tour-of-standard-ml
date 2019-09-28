structure HelloWorld = struct
  fun hello () = print "Hello!\n"
  fun main (_, _) = (hello (); OS.Process.success)
end
