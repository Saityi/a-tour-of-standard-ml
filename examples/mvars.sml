structure S = SyncVar
fun main () =
  let val i : int S.mvar = S.mVar ()
  in (
    S.mPut (i, 10);
    S.mGet i; (* 10 *)
    S.mPut (i, 10);
    (* uncaught exception Put
         raised at: cml/src/core-cml/sync-var.sml:203.42-203.45 *)
    S.mTake i; (* 10 *)
    S.mPut (i, 0);
    S.mGet i; (* 0 *)
    OS.Process.success
  )
  end
