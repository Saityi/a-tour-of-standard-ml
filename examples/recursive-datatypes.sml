infixr 4 +:
datatype 'a list = eol
                 | +: of 'a * 'a list

datatype 'a tree = leaf
                 | node of { value : 'a
                           , left  : 'a tree
                           , right : 'a tree
                           }

val ints = 1 +: 2 +: 3 +: eol
val inttree = node { value = 1
                   , left  = node { value = 2
                                  , left = leaf
                                  , right = leaf
                                  }
                   , right = node { value = 3
                                  , left = leaf
                                  , right = leaf
                                  }
                   }