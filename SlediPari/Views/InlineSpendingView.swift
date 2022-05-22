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
    let clickAction: (String) -> Void
    
    var body: some View {
        
        HStack {
            
            Circle()
                .fill(spending.color)
                .frame(width: 20, height: 20)
            
            Text(LocalizedStringKey(spending.title))
            
            if isSubCategory {
                
                Text("*")
            }
            
            Text("- \(String(format: "%.2f", spending.value))")
            Text(LocalizedStringKey("lv"))
            
            Spacer()
        }
        .padding(.top, 15)
        .onTapGesture {
            clickAction(spending.title)
        }
    }
}

struct InlineSpendingView_Previews: PreviewProvider {
    static var previews: some View {
        InlineSpendingView(
            spending: PieSlice(value: 13.02, title: "Food", color: Color.blue),
            isSubCategory: true,
            clickAction: {_ in }
        )
    }
}
