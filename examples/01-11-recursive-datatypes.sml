datatype 'a list = nil 
                 | :: of 'a * 'a list

datatype 'a tree = leaf
                 | node of ('a * 'a tree * 'a tree)

val _ = 1 :: 2 :: 3 :: nil
val _ = node (1, 
              node (2, leaf, leaf), 
              node (2, leaf, leaf))