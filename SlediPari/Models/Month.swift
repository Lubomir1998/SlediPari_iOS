//
//  Month.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/17/22.
//

import Foundation
import SwiftUI
import CoreData

public class Month: NSManagedObject {
    
    @NSManaged public var id: String
    @NSManaged public var clothes: NSNumber
    @NSManaged public var workout: NSNumber
    @NSManaged public var food: NSNumber
    @NSManaged public var home: NSNumber
    @NSManaged public var restaurant: NSNumber
    @NSManaged public var smetki: NSNumber
    @NSManaged public var tok: NSNumber
    @NSManaged public var voda: NSNumber
    @NSManaged public var toplo: NSNumber
    @NSManaged public var internet: NSNumber
    @NSManaged public var telefon: NSNumber
    @NSManaged public var vhod: NSNumber
    @NSManaged public var cosmetics: NSNumber
    @NSManaged public var higien: NSNumber
    @NSManaged public var other: NSNumber
    @NSManaged public var transport: NSNumber
    @NSManaged public var taxi: NSNumber
    @NSManaged public var car: NSNumber
    @NSManaged public var `public`: NSNumber
    @NSManaged public var preparati: NSNumber
    @NSManaged public var clean: NSNumber
    @NSManaged public var wash: NSNumber
    @NSManaged public var toys: NSNumber
    @NSManaged public var tattoo: NSNumber
    @NSManaged public var snacks: NSNumber
    @NSManaged public var subscriptions: NSNumber
    @NSManaged public var remont: NSNumber
    @NSManaged public var machove: NSNumber
    @NSManaged public var furniture: NSNumber
    @NSManaged public var tehnika: NSNumber
    @NSManaged public var travel: NSNumber
    @NSManaged public var posuda: NSNumber
    @NSManaged public var medicine: NSNumber
    @NSManaged public var domPotrebi: NSNumber
    @NSManaged public var education: NSNumber
    @NSManaged public var entertainment: NSNumber
    @NSManaged public var gifts: NSNumber
}

extension Month: Identifiable {
    
    func map(from object: MonthDTO) {
        self.id = object.id
        self.clothes = NSNumber(value: object.clothes)
        self.workout = NSNumber(value: object.workout)
        self.food = NSNumber(value: object.food.home + object.food.restaurant)
        self.home = NSNumber(value: object.food.home)
        self.restaurant = NSNumber(value: object.food.restaurant)
        self.smetki = NSNumber(value: object.smetki.internet + object.smetki.telefon + object.smetki.vhod + object.smetki.tok + object.smetki.voda + object.smetki.toplo)
        self.internet = NSNumber(value: object.smetki.internet)
        self.telefon = NSNumber(value: object.smetki.telefon)
        self.vhod = NSNumber(value: object.smetki.vhod)
        self.voda = NSNumber(value: object.smetki.voda)
        self.tok = NSNumber(value: object.smetki.tok)
        self.toplo = NSNumber(value: object.smetki.toplo)
        self.cosmetics = NSNumber(value: object.cosmetics.higien + object.cosmetics.other)
        self.higien = NSNumber(value: object.cosmetics.higien)
        self.other = NSNumber(value: object.cosmetics.other)
        self.transport = NSNumber(value: object.transport.taxi + object.transport.car + object.transport.public)
        self.taxi = NSNumber(value: object.transport.taxi)
        self.car = NSNumber(value: object.transport.car)
        self.public = NSNumber(value: object.transport.public)
        self.preparati = NSNumber(value: object.preparati.clean + object.preparati.wash)
        self.wash = NSNumber(value: object.preparati.wash)
        self.clean = NSNumber(value: object.preparati.clean)
        self.toys = NSNumber(value: object.toys)
        self.tattoo = NSNumber(value: object.tattoo)
        self.snacks = NSNumber(value: object.snacks)
        self.subscriptions = NSNumber(value: object.subscriptions)
        self.remont = NSNumber(value: object.remont)
        self.machove = NSNumber(value: object.machove)
        self.furniture = NSNumber(value: object.furniture)
        self.tehnika = NSNumber(value: object.tehnika)
        self.travel = NSNumber(value: object.travel)
        self.posuda = NSNumber(value: object.posuda)
        self.medicine = NSNumber(value: object.medicine)
        self.domPotrebi = NSNumber(value: object.domPotrebi)
        self.education = NSNumber(value: object.education)
        self.entertainment = NSNumber(value: object.entertainment)
        self.gifts = NSNumber(value: object.gifts)
    }
    
    var isCurrent: Bool {
        
        return self.id == formatCurrentDateToString()
    }
    
    var sortedList: [PieSlice] {
        
        var sorted: [PieSlice] = []
        
        for (name, _) in self.entity.attributesByName {
            
            if let value = self.value(forKey: name) as? Double, value > 0.0, (name != "home" && name != "restaurant" && name != "tok" && name != "voda" && name != "toplo" && name != "vhod" && name != "internet" && name != "telefon" && name != "car" && name != "taxi" && name != "public" && name != "clean" && name != "wash" && name != "other" && name != "higien") {
                sorted.append(PieSlice(value: value, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        sorted.sort(by: { $0.value > $1.value })
        return sorted
    }
    
    var totalSum: Double {
        
        var sum = 0.0
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, (name != "id" && name != "smetki" && name != "transport" && name != "food" && name != "cosmetics" && name != "preparati") {
                sum += sumValue
            }
            else {
                continue
            }
        }
        
        return sum
    }
    
    var foodList: [PieSlice] {
        
        var list: [PieSlice] = []
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, name == "home" || name == "restaurant", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var smetkiList: [PieSlice] {
        
        var list: [PieSlice] = []
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, name == "tok" || name == "voda" || name == "internet" || name == "toplo" || name == "vhod" || name == "telefon", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var transportList: [PieSlice] {
        
        var list: [PieSlice] = []
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, name == "taxi" || name == "car" || name == "public", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var preparatiList: [PieSlice] {
        
        var list: [PieSlice] = []
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, name == "clean" || name == "wash", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var cosmeticsList: [PieSlice] {
        
        var list: [PieSlice] = []
        
        for (name, _) in  self.entity.attributesByName {
            
            if let sumValue = self.value(forKey: name) as? Double, name == "higien" || name == "other", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: name, color: Color(name)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
}

struct PieSlice: Hashable {
    
    var value: Double
    var title: String
    var color: Color
}

