//
//  MonthDTO.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import Foundation

struct MonthDTO: Codable {
    
    struct Food: Codable {
        
        var home: Double
        var restaurant: Double
    }
    
    struct Transport: Codable {
        
        var taxi: Double
        var car: Double
        var `public`: Double
    }
    
    struct Smetki: Codable {
        
        var tok: Double
        var voda: Double
        var toplo: Double
        var internet: Double
        var telefon: Double
        var vhod: Double
    }
    
    struct Cosmetics: Codable {
        
        var higien: Double
        var other: Double
    }
    
    struct Preparati: Codable {
        
        var clean: Double
        var wash: Double
    }
    
    var id: String
    var clothes: Double
    var workout: Double
    var food: Food
    var smetki: Smetki
    var cosmetics: Cosmetics
    var transport: Transport
    var preparati: Preparati
    var toys: Double
    var tattoo: Double
    var snacks: Double
    var subscriptions: Double
    var remont: Double
    var machove: Double
    var furniture: Double
    var tehnika: Double
    var travel: Double
    var posuda: Double
    var medicine: Double
    var domPotrebi: Double
    var education: Double
    var entertainment: Double
    var gifts: Double
}

extension MonthDTO {
    
    func toMonth() -> Month {
        return Month(id: self.id, clothes: self.clothes, workout: self.workout, food: self.food.restaurant + self.food.home, home: self.food.home, restaurant: self.food.restaurant, smetki: self.smetki.tok + self.smetki.toplo + self.smetki.voda + self.smetki.vhod + self.smetki.internet + self.smetki.telefon, tok: self.smetki.tok, voda: self.smetki.voda, toplo: self.smetki.toplo, internet: self.smetki.internet, telefon: self.smetki.telefon, vhod: self.smetki.vhod, cosmetics: self.cosmetics.higien + self.cosmetics.other, higien: self.cosmetics.higien, other: self.cosmetics.other, transport: self.transport.taxi + self.transport.car + self.transport.public, taxi: self.transport.taxi, car: self.transport.car, public: self.transport.public, preparati: self.preparati.clean + self.preparati.wash, clean: self.preparati.clean, wash: self.preparati.wash, toys: self.toys, tattoo: self.tattoo, snacks: self.snacks, subscriptions: self.subscriptions, remont: self.remont, machove: self.machove, furniture: self.furniture, tehnika: self.tehnika, travel: self.travel, posuda: self.posuda, medicine: self.medicine, domPotrebi: self.domPotrebi, education: self.education, entertainment: self.entertainment, gifts: self.gifts)
    }
    
}


