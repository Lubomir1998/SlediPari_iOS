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
