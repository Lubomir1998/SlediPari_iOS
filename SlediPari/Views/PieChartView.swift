//
//  PieChartView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import SwiftUI

struct PieChartView: View {
    
    let spendings: [PieSlice]
    let totalSum: Double
        
    var body: some View {
        
        VStack {
            
            GeometryReader { g in
                
                ZStack {
                    
                    ForEach(0 ... spendings.count - 1, id: \.self) { index in
                        
                        PiePiece(spendings: spendings, index: index, totalSum: totalSum, center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).width / 2))
                    }
                }
            }
        }
    }
}

struct PiePiece: View {
    
    let spendings: [PieSlice]
    let index: Int
    let totalSum: Double
    let center: CGPoint
    
    var body: some View {
        
        Path { path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .degrees(270.0 + addAnglesSum(spendings: spendings, index: index, totalSum: totalSum)), endAngle: .degrees(270.0 + spendings[index].value.toPercent(totalSum: totalSum) * 3.6 + addAnglesSum(spendings: spendings, index: index, totalSum: totalSum)), clockwise: false)

        }
        .fill(spendings[index].color)
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(
            spendings: Month(id: "03-2022", clothes: 0, workout: 0, food: 0, home: 0, restaurant: 0, smetki: 0, tok: 0, voda: 0, toplo: 0, internet: 0, telefon: 0, vhod: 0, cosmetics: 0, higien: 0, other: 0, transport: 0, taxi: 0, car: 0, public: 0, preparati: 0, clean: 0, wash: 0, toys: 0, tattoo: 0, snacks: 0, subscriptions: 0, remont: 0, machove: 30, furniture: 0, tehnika: 0, travel: 10, posuda: 0, medicine: 20, domPotrebi: 0, education: 0, entertainment: 0, gifts: 0).sortedList,
            totalSum: 60
        )
    }
}
