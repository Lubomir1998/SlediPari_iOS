//
//  BottomSheetView.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/20/22.
//

import SwiftUI

struct BottomSheetView: View {
    
    @Binding var isPresented: Bool
    let resetCategory: () -> Void
    @EnvironmentObject var viewModel: MonthsViewModel
    
    @State private var currentSelectedIndex = 0
    @State private var value: String = ""
    
    @State private var showInvalidPriceAlert = false
    @State private var showNoOptionAlert = false
    @State private var showAddingNotSuccessfulAlert = false
    
    let spendingOptions = getSpendingOptions()
    
    var body: some View {
                
        NavigationView {
            
            VStack(alignment: .center, spacing: 30) {
                
                Form {
                    Section {
                        Picker(selection: $currentSelectedIndex, label: Text(LocalizedStringKey("spending_type"))) {
                            
                            ForEach(0 ..< spendingOptions.count, id: \.self) { index in
                                Text(self.spendingOptions[index].1)
                            }
                        }
                        
                        HStack {
                            
                            Text(LocalizedStringKey("price"))
                            
                            Spacer()
                            
                            TextField(LocalizedStringKey("enter_price"), text: $value)
                                .keyboardType(.decimalPad)
                                .fixedSize()
                        }
                    }
                }.frame(height: 150)
                
                Button {
                    
                    if currentSelectedIndex == 0 {
                         showNoOptionAlert = true
                        return
                    }
                    
                    if let price = value.toOptDouble {
                        
                        Task {
                            
                            await viewModel.addSpending(monthId: formatCurrentDateToString(), title: spendingOptions[currentSelectedIndex].0, price: price)
                            
                            if viewModel.isAddingSuccessful {
                                self.isPresented = false
                                
                                resetCategory()
                            }
                            else {
                                showAddingNotSuccessfulAlert = true
                            }
                        }
                    }
                    else {
                        
                        showInvalidPriceAlert = true
                    }
                    
                } label: {
                    Text(LocalizedStringKey("spend"))
                }
                .disabled(viewModel.isLoading)
                
                //because we can't attach more than 1 alert per view
                //even if we do so, only the first one shows up
                
                VStack {EmptyView()}
                    .alert(isPresented: $showNoOptionAlert) {
                        Alert(
                            title: Text(LocalizedStringKey("nothing_selected")),
                            dismissButton: .default(Text(LocalizedStringKey("ok"))) {
                                showNoOptionAlert = false
                            }
                        )
                    }
                
                VStack {EmptyView()}
                    .alert(isPresented: $showInvalidPriceAlert) {
                        Alert(
                            title: Text(LocalizedStringKey("enter_price")),
                            dismissButton: .default(Text(LocalizedStringKey("ok"))) {
                                showInvalidPriceAlert = false
                            }
                        )
                    }
                
                VStack {EmptyView()}
                    .alert(isPresented: $showAddingNotSuccessfulAlert) {
                        Alert(
                            title: Text(LocalizedStringKey("something_wrong")),
                            message: Text(viewModel.errorMessage ?? ""),
                            dismissButton: .default(Text(LocalizedStringKey("ok"))) {
                                showAddingNotSuccessfulAlert = false
                            }
                        )
                    }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            .background(Color("background"))
            .navigationBarTitle(Text(LocalizedStringKey("spending_options")), displayMode: .inline)
            .navigationBarItems(
                trailing: Button {
                    
                    self.isPresented = false
                } label: {
                    Text(LocalizedStringKey("cancel"))
                }
            )
        }
    }
}
