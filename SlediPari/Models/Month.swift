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
    @NSManaged public var clean: Double
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
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            
            if let category = child.label, let value = child.value as? Double, value > 0.0, (category != "home" && category != "restaurant" && category != "tok" && category != "voda" && category != "toplo" && category != "vhod" && category != "internet" && category != "telefon" && category != "car" && category != "taxi" && category != "public" && category != "clean" && category != "wash" && category != "other" && category != "higien") {
                sorted.append(PieSlice(value: value, title: category, color: Color(category)))
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
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            
            if let sumValue = child.value as? Double, (child.label != "id" && child.label != "smetki" && child.label != "transport" && child.label != "food" && child.label != "cosmetics" && child.label != "preparati") {
                sum += sumValue
            }
            else {
                continue
            }
        }
        
        return sum
    }
    
    var foodList: [PieSlice] {
        
        let mirror = Mirror(reflecting: self)
        var list: [PieSlice] = []
        
        for child in mirror.children {
            
            if let category = child.label, let sumValue = child.value as? Double, category == "home" || category == "restaurant", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: category, color: Color(category)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var smetkiList: [PieSlice] {
        
        let mirror = Mirror(reflecting: self)
        var list: [PieSlice] = []
        
        for child in mirror.children {
            
            if let category = child.label, let sumValue = child.value as? Double, category == "tok" || category == "voda" || category == "internet" || category == "toplo" || category == "vhod" || category == "telefon", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: category, color: Color(category)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var transportList: [PieSlice] {
        
        let mirror = Mirror(reflecting: self)
        var list: [PieSlice] = []
        
        for child in mirror.children {
            
            if let category = child.label, let sumValue = child.value as? Double, category == "taxi" || category == "car" || category == "public", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: category, color: Color(category)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var preparatiList: [PieSlice] {
        
        let mirror = Mirror(reflecting: self)
        var list: [PieSlice] = []
        
        for child in mirror.children {
            
            if let category = child.label, let sumValue = child.value as? Double, category == "clean" || category == "wash", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: category, color: Color(category)))
            }
            else {
                continue
            }
        }
        
        list.sort(by: { $0.value > $1.value })
        return list
    }
    
    var cosmeticsList: [PieSlice] {
        
        let mirror = Mirror(reflecting: self)
        var list: [PieSlice] = []
        
        for child in mirror.children {
            
            if let category = child.label, let sumValue = child.value as? Double, category == "higien" || category == "other", sumValue > 0 {
                list.append(PieSlice(value: sumValue, title: category, color: Color(category)))
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

