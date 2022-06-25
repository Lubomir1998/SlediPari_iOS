//
//  MonthsViewModel.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import Foundation
import SwiftUI

@MainActor
class MonthsViewModel: ObservableObject {
    
    @Published var currentMonth: Month? = nil
    @Published var allMonths: [Month] = []
    @Published var totalSum: Double = 0.0
    @Published var currentList: [PieSlice] = []
    @Published var currentCategory = LocalizedStringKey("All")
    @Published var isLoading: Bool = false
    @Published var isAddingSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    private let monthsService = MonthService()
    
    func getAllMonths() {
        
        allMonths = monthsService.getMonthsFromCache()
    }
    
    func getMonth(monthId: String) {
        
        isLoading = true
        
        currentMonth = monthsService.getMonthFromCache(monthId: monthId)
        if let month = currentMonth {
            
            if currentCategory != LocalizedStringKey("All") {
                
                switch currentCategory {
                    case LocalizedStringKey("food"):
                        if month.food == 0.0 {
                            currentCategory = LocalizedStringKey("All")
                            self.currentList = month.sortedList
                            self.totalSum = month.totalSum
                        }
                        else {
                            self.currentList = month.foodList
                            self.totalSum = month.food.doubleValue
                        }
                        
                    case LocalizedStringKey("smetki"):
                        if month.smetki == 0.0 {
                            currentCategory = LocalizedStringKey("All")
                            self.currentList = month.sortedList
                            self.totalSum = month.totalSum
                        }
                        else {
                            self.currentList = month.smetkiList
                            self.totalSum = month.smetki.doubleValue
                        }
                        
                    case LocalizedStringKey("cosmetics"):
                        if month.cosmetics == 0.0 {
                            currentCategory = LocalizedStringKey("All")
                            self.currentList = month.sortedList
                            self.totalSum = month.totalSum
                        }
                        else {
                            self.currentList = month.cosmeticsList
                            self.totalSum = month.cosmetics.doubleValue
                        }
                        
                    case LocalizedStringKey("transport"):
                        if month.transport == 0.0 {
                            currentCategory = LocalizedStringKey("All")
                            self.currentList = month.sortedList
                            self.totalSum = month.totalSum
                        }
                        else {
                            self.currentList = month.transportList
                            self.totalSum = month.transport.doubleValue
                        }
                        
                    case LocalizedStringKey("preparati"):
                        if month.preparati == 0.0 {
                            currentCategory = LocalizedStringKey("All")
                            self.currentList = month.sortedList
                            self.totalSum = month.totalSum
                        }
                        else {
                            self.currentList = month.preparatiList
                            self.totalSum = month.preparati.doubleValue
                        }
                        
                    default: do {}
                }
            }
            else {
                
                self.currentList = month.sortedList
                self.totalSum = month.totalSum
            }
        }
        
        isLoading = false
    }
    
    func updateMonth() async {
        
        do{
            try await monthsService.updateMonth()
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func addSpending(monthId: String, title: String, price: Double) async {
        
        let request = PostSpendingRequest(monthId: monthId, title: title, price: price)
        isLoading = true
        
        do {
            isAddingSuccessful = try await monthsService.addSpending(request: request)
        }
        catch {
            isAddingSuccessful = false
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
}
