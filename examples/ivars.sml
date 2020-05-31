structure S = SyncVar
fun main () =
  let val i : int S.ivar = S.iVar ()
  in (
    S.iGetPoll i; (* NONE *)
    S.iPut (i, 10);
    S.iGetPoll i; (* SOME 10 *)
    S.iPut (i, 10);
    (* uncaught exception Put
         raised at: cml/src/core-cml/sync-var.sml:142.42-142.45 *)
    OS.Process.success
  )
  end
