//
//  Month.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/17/22.
//

import Foundation
import SwiftUI

struct Month {
    
    var id: String
    var clothes: Double
    var workout: Double
    var food: Double
    var home: Double
    var restaurant: Double
    var smetki: Double
    var tok: Double
    var voda: Double
    var toplo: Double
    var internet: Double
    var telefon: Double
    var vhod: Double
    var cosmetics: Double
    var higien: Double
    var other: Double
    var transport: Double
    var taxi: Double
    var car: Double
    var `public`: Double
    var preparati: Double
    var clean: Double
    var wash: Double
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

extension Month: Identifiable {
    
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

