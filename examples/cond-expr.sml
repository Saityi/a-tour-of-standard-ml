val trueCond =
  if (1 = 1)
  then 1
  else 0

val elseCond =
  if (1 = 0)
  then 1
  else if (1 = 1)
  then ~1
  else 0

(* val error = if true then () else 1;
 * stdIn:16.1-16.23 Error: types of if branches do not agree [overload conflict]
    then branch: unit
    else branch: [int ty]
    in expression:
      if true then () else 1 *)