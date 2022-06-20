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
                    
                    ForEach(0..<spendings.count, id: \.self) { index in
                        
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
        Text("")
    }
}
