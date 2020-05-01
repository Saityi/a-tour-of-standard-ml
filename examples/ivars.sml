open SyncVar
fun main () =
  let val i : int ivar = iVar ()
  in (
    iGetPoll j; (* NONE *)
    iPut (i, 10);
    iGetPoll j; (* SOME 10 *)
    iPut (i, 10);
    (* uncaught exception Put
         raised at: cml/src/core-cml/sync-var.sml:142.42-142.45 *)
    OS.Process.success
  )
  end