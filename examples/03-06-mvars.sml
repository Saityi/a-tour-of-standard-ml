open SyncVar
fun main () = 
  let val i : int mvar = mVar ()
  in (
    mPut (i, 10);
    mGet i; (* 10 *)
    mPut (i, 10);
    (* uncaught exception Put
         raised at: cml/src/core-cml/sync-var.sml:203.42-203.45 *)
    mTake i; (* 10 *)
    mPut (i, 0);
    mGet i; (* 0 *)
    OS.Process.success
  )
  end