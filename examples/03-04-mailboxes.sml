open Mailbox
fun main () = 
  let val m : int mbox = mailbox ()
  in (
    send (m, 10);
    recv m; (* 10 *)
    OS.Process.success
  )
  end