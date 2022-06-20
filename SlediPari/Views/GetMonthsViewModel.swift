//
//  GetMonthsViewModel.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/19/22.
//

import Foundation

@MainActor
class GetMonthsViewModel: ObservableObject {
    
    @Published var allMonths: [Month] = []
    @Published var completed: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let monthsService = MonthService()
    
    func getAllMonths() async {
        
        isLoading = true
        
        do {
            try await monthsService.getAllMonths()
        }
        catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        completed = true
    }
    
}
