//
//  MonthView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import SwiftUI

struct MonthView: View {
        
    @ObservedObject private var viewModel = MonthsViewModel()
    @State var isBottomSheetOpened = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.allMonths) { month in
                                Text(month.id.toReadableDate)
                                    .padding(7)
                                    .background(viewModel.currentMonth?.id == month.id ? Color(UIColor.systemGray3) : Color(UIColor.systemBackground))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        
                                        Task.init {
                                            
                                            viewModel.getMonth(monthId: month.id)
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
                        
                        HStack {
                            
                            if viewModel.currentCategory == LocalizedStringKey("All") {
                                Spacer()
                            }
                            else {
                                
                                Button {
                                    
                                    viewModel.totalSum = currentMonth.totalSum
                                    viewModel.currentList = currentMonth.sortedList
                                    viewModel.currentCategory = LocalizedStringKey("All")
                                } label: {
                                    
                                    Text(LocalizedStringKey("back_to_all"))
                                        .font(.system(size: 14))
                                }
                            }
                            
                            Text(viewModel.currentCategory)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    alignment: .center
                                )
                                .font(.system(size: 20))
                            
                            Spacer()
                        }
                        .padding(15)
                        
                        PieChartView(spendings: viewModel.currentList.reversed(), totalSum: viewModel.totalSum)
                            .padding(EdgeInsets(top: 40, leading: 40, bottom: 340, trailing: 40))
                        
                        ForEach(viewModel.currentList, id: \.self) { spending in
                            
                            InlineSpendingView(spending: spending, isSubCategory: (spending.title == "smetki" || spending.title == "transport" || spending.title == "food" || spending.title == "cosmetics" || spending.title == "preparati"), totalSum: viewModel.totalSum, clickAction: { category in
                                
                                switch category {
                                    case "food":
                                        viewModel.currentList = currentMonth.foodList
                                        viewModel.totalSum = currentMonth.food.doubleValue
                                        viewModel.currentCategory = LocalizedStringKey("food")
                                        
                                    case "smetki":
                                        viewModel.currentList = currentMonth.smetkiList
                                        viewModel.totalSum = currentMonth.smetki.doubleValue
                                        viewModel.currentCategory = LocalizedStringKey("smetki")
                                        
                                    case "preparati":
                                        viewModel.currentList = currentMonth.preparatiList
                                        viewModel.totalSum = currentMonth.preparati.doubleValue
                                        viewModel.currentCategory = LocalizedStringKey("preparati")
                                        
                                    case "transport":
                                        viewModel.currentList = currentMonth.transportList
                                        viewModel.totalSum = currentMonth.transport.doubleValue
                                        viewModel.currentCategory = LocalizedStringKey("transport")
                                        
                                    case "cosmetics":
                                        viewModel.currentList = currentMonth.cosmeticsList
                                        viewModel.totalSum = currentMonth.cosmetics.doubleValue
                                        viewModel.currentCategory = LocalizedStringKey("cosmetics")
                                        
                                    default: do {}
                                }
                            })
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Text(LocalizedStringKey("total"))
                            Text(String(format: "%.2f", viewModel.totalSum))
                            Text(LocalizedStringKey("lv"))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        
                        Spacer(minLength: 40)
                    }
                    
                }
            }
            .task {
                viewModel.getAllMonths()
                viewModel.getMonth(monthId: formatCurrentDateToString())
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
                BottomSheetView(isPresented: $isBottomSheetOpened, resetCategory: {
                    Task.init {
                        
                        viewModel.currentCategory = LocalizedStringKey("All")
                        await viewModel.updateMonth()
                        viewModel.getAllMonths()
                        viewModel.getMonth(monthId: formatCurrentDateToString())
                    }
                }).environmentObject(viewModel)
            }
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}
