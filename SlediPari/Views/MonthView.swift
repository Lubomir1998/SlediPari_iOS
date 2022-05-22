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
    
    @State var currentCategory = LocalizedStringKey("All")
    @State var isBottomSheetOpened = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allMonths) { month in
                                Text(month.id.toReadableDate)
                                    .padding(7)
                                    .background(viewModel.currentMonth?.id == month.id ? Color(UIColor.systemGray3) : Color(UIColor.systemBackground))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        
                                        Task.init {
                                            
                                            await viewModel.getMonth(monthId: month.id)
                                        }
                                    }
                                
                                Spacer(minLength: 35)
                            }
                        }
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }
                    
                    Divider()
                    
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
                            .padding(EdgeInsets(top: 40, leading: 40, bottom: 340, trailing: 40))
                        
                        ForEach(currentMonth.sortedList, id: \.self) { spending in
                            
                            InlineSpendingView(spending: spending, isSubCategory: (spending.title == "smetki" || spending.title == "transport" || spending.title == "food" || spending.title == "cosmetics" || spending.title == "preparati"))
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Text(LocalizedStringKey("total"))
                            Text(String(format: "%.2f", currentMonth.totalSum))
                            Text(LocalizedStringKey("lv"))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        
                        Spacer(minLength: 40)
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
                    
                    self.isBottomSheetOpened.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isBottomSheetOpened) {
                BottomSheetView(isPresented: $isBottomSheetOpened).environmentObject(viewModel)
            }
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
