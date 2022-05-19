//
//  MonthsViewModel.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import Foundation

@MainActor
class MonthsViewModel: ObservableObject {
    
    @Published var currentMonth: Month? = nil
    @Published var totalSum: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let monthsService = MonthService()
    
    func getMonth(monthId: String) async {
        
        isLoading = true
        
        do {
            currentMonth = try await monthsService.getMonth(monthId: monthId)
        }
        catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
}
