//
//  MonthView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import SwiftUI

struct MonthView: View {
    
    let allMonths: [Month]
    
    @ObservedObject private var viewModel = MonthsViewModel()
    
    @State var currentCategory = "All" // localize
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allMonths) { month in
                                Text(month.id.toReadableDate)
                                    .padding(7)
                                    .background(viewModel.currentMonth?.id == month.id ? Color(UIColor.systemGray3) : Color("background"))
                                    .cornerRadius(10)
                                Spacer(minLength: 35)
                            }
                        }
                        .padding()
                    }
                    .border(Color(UIColor.systemGray3), width: 1)
                    
                    if let currentMonth = viewModel.currentMonth {
                        
                        Text(currentMonth.id.toReadableDate)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .center
                            )
                            .font(.system(size: 20))
                        
                        Text(currentCategory)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .center
                            )
                            .font(.system(size: 20))
                        
                        PieChartView(spendings: currentMonth.sortedList, totalSum: currentMonth.totalSum)
                            .padding(40)
                    }
                    
                }
            }
            .task {
                await viewModel.getMonth(monthId: formatCurrentDateToString())
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .navigationBarItems(
                trailing: Button {
                    // open bottom sheet
                } label: {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(
            allMonths: [
                Month(id: "03-2022", clothes: 0, workout: 0, food: 0, home: 0, restaurant: 0, smetki: 0, tok: 0, voda: 0, toplo: 0, internet: 0, telefon: 0, vhod: 0, cosmetics: 0, higien: 0, other: 0, transport: 0, taxi: 0, car: 0, public: 0, preparati: 0, clean: 0, wash: 0, toys: 0, tattoo: 0, snacks: 0, subscriptions: 0, remont: 0, machove: 0, furniture: 0, tehnika: 0, travel: 0, posuda: 0, medicine: 0, domPotrebi: 0, education: 0, entertainment: 0, gifts: 0),
                Month(id: "04-2022", clothes: 0, workout: 0, food: 0, home: 0, restaurant: 0, smetki: 0, tok: 0, voda: 0, toplo: 0, internet: 0, telefon: 0, vhod: 0, cosmetics: 0, higien: 0, other: 0, transport: 0, taxi: 0, car: 0, public: 0, preparati: 0, clean: 0, wash: 0, toys: 0, tattoo: 0, snacks: 0, subscriptions: 0, remont: 0, machove: 0, furniture: 0, tehnika: 0, travel: 0, posuda: 0, medicine: 0, domPotrebi: 0, education: 0, entertainment: 0, gifts: 0),
                Month(id: "05-2022", clothes: 0, workout: 0, food: 0, home: 0, restaurant: 0, smetki: 0, tok: 0, voda: 0, toplo: 0, internet: 0, telefon: 0, vhod: 0, cosmetics: 0, higien: 0, other: 0, transport: 0, taxi: 0, car: 0, public: 0, preparati: 0, clean: 0, wash: 0, toys: 0, tattoo: 0, snacks: 0, subscriptions: 0, remont: 0, machove: 0, furniture: 0, tehnika: 0, travel: 0, posuda: 0, medicine: 0, domPotrebi: 0, education: 0, entertainment: 0, gifts: 0)
            ]
        )
    }
}
