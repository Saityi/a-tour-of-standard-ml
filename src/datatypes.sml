structure Datatypes = struct
    datatype card_suit = swords | wands | cups | disks
    datatype card_value = prince 
                        | princess 
                        | knight 
                        | queen 
                        | one 
                        | two 
                        | three 
                        | four 
                        | five 
                        | six 
                        | seven 
                        | eight 
                        | nine 
                        | ten
    datatype tarot_card = major_arcana of {name : string, number : int}
                        | minor_arcana of {suit : card_suit, value : card_value}
    datatype 'item list = nil | cons of ('item * 'item list);
    val xs = cons (3, cons (4, nil))
end