//
//  InlineSpendingView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/19/22.
//

import SwiftUI

struct InlineSpendingView: View {
    
    let spending: PieSlice
    let isSubCategory: Bool
    
    var body: some View {
        HStack {
            
            Circle()
                .fill(spending.color)
                .frame(width: 24, height: 24)
            
            //will be localized
            Text(spending.title)
            
            if isSubCategory {
                
                Text("*")
            }
            
            Text(" - \(String(format: "%.2f", spending.value)) lv") // lv will be localized
            
            Spacer()
        }
        
    }
}

struct InlineSpendingView_Previews: PreviewProvider {
    static var previews: some View {
        InlineSpendingView(
            spending: PieSlice(value: 13.02, title: "Food", color: Color.blue),
            isSubCategory: true
        )
    }
}
