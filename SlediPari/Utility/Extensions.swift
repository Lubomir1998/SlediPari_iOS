//
//  Extensions.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import Foundation
import SwiftUI

func formatCurrentDateToString() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-yyyy"
    return dateFormatter.string(from: Date())
}

func addAnglesSum(spendings: [PieSlice], index: Int, totalSum: Double) -> Double {
    
    if index == 0 {
        return 0
    }
    
    var angles = 0.0
    
    for i in 0...index - 1 {
        
        angles += spendings[i].value.toPercent(totalSum: totalSum) * 3.6
    }
    
    return angles
}

extension String {
    
    var toReadableDate: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        
        if let date = dateFormatter.date(from: self) {
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "MMM yyyy"
            return dateFormatter2.string(from: date)
        }
        else {
            return ""
        }
    }
}

extension Double {
    
    func toPercent(totalSum: Double) -> Double {
        
        return totalSum == 0.0 ? 0.0 : (100 * self) / totalSum
    }
}
