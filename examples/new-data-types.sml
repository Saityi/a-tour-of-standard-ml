type major_arcana_card = (string * int)

datatype card_suit = swords | wands | cups | disks

datatype card_value = prince | princess | knight | queen
                    | one | two | three | four | five
                    | six | seven | eight | nine | ten

datatype minor_arcana_card = minor_arcana_card of
    { suit  : card_suit
    , value : card_value
    }

datatype tarot_card = major_arcana of major_arcana_card
                    | minor_arcana of minor_arcana_card
