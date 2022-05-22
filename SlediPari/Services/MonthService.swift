//
//  MonthService.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import Foundation

class MonthService {
    
    private let api = MonthApi()
    
    func getMonth(monthId: String) async throws -> Month? {
        
        do {
            return try await api.getMonth(monthId: monthId)?.toMonth()
        }
        catch {
            throw error
        }
    }
    
    func getAllMonths() async throws -> [Month] {
        
        do {
            return try await api.getAllMonths().map { $0.toMonth() }
        }
        catch {
            throw error
        }
    }
    
    func addSpending(request: PostSpendingRequest) async throws -> Bool {
        
        do {
            return try await api.addSpending(request: request)
        }
        catch {
            throw error
        }
    }
    
}
