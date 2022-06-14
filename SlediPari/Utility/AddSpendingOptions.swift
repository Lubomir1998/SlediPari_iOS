//
//  AddSpendingOptions.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/20/22.
//

import Foundation
import SwiftUI

func getSpendingOptions() -> [(String, LocalizedStringKey)]{
    return  [
        ("", LocalizedStringKey("not_selected")),
        ("home", LocalizedStringKey("food_home")),
        ("restaurant", LocalizedStringKey("food_res")),
        ("tok", LocalizedStringKey("smetki_tok")),
        ("voda", LocalizedStringKey("smetki_voda")),
        ("toplo", LocalizedStringKey("smetki_toplo")),
        ("internet", LocalizedStringKey("smetki_internet")),
        ("telefon", LocalizedStringKey("smetki_telefon")),
        ("vhod", LocalizedStringKey("smetki_vhod")),
        ("public", LocalizedStringKey("transport_public")),
        ("car", LocalizedStringKey("transport_car")),
        ("taxi", LocalizedStringKey("transport_taxi")),
        ("clothes", LocalizedStringKey("clothes")),
        ("workout", LocalizedStringKey("workout")),
        ("remont", LocalizedStringKey("remont")),
        ("posuda", LocalizedStringKey("posuda")),
        ("travel", LocalizedStringKey("travel")),
        ("gifts", LocalizedStringKey("gifts")),
        ("snacks", LocalizedStringKey("snacks")),
        ("medicine", LocalizedStringKey("medicine")),
        ("domPotrebi", LocalizedStringKey("domPotrebi")),
        ("tehnika", LocalizedStringKey("tehnika")),
        ("machove", LocalizedStringKey("machove")),
        ("furniture", LocalizedStringKey("furniture")),
        ("education", LocalizedStringKey("education")),
        ("entertainment", LocalizedStringKey("entertainment")),
        ("tattoo", LocalizedStringKey("tattoo")),
        ("toys", LocalizedStringKey("toys")),
        ("higien", LocalizedStringKey("cosmetics_higien")),
        ("other", LocalizedStringKey("cosmetics_other")),
        ("clean", LocalizedStringKey("preparati_clean")),
        ("wash", LocalizedStringKey("preparati_wash")),
        ("subscriptions", LocalizedStringKey("subscriptions"))
    ]
}
