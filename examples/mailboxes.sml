fun main () =
  let
    val m : int Mailbox.mbox = Mailbox.mailbox ()
  in (
    Mailbox.send (m, 10);
    Mailbox.recv m; (* 10 *)
    OS.Process.success
  )
  end

val _ = main ();
