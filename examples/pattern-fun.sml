open String

datatype player = mage of {name: string, magic_type: string}
                | warrior of {name: string, weapon: string}

fun greet_player (mage {name=name, magic_type=magic_type}) =
    print ("Greetings, " ^ name ^ ", master of the " ^ magic_type ^ "!\n")
  | greet_player (warrior {name=name, weapon=weapon}) =
    print ("Hullo, " ^ name ^ ", wielder of " ^ weapon ^ "!\n")

val u = greet_player (warrior {name="Grom", weapon="Gorehowl"})