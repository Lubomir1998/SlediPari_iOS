//
//  MonthService.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/15/22.
//

import Foundation
import SwiftUI
import CoreData

class MonthService {
    
    private let api = MonthApi()
    private let context = PersistenceController.shared.container.viewContext
        
    // local
    
    func getMonthFromCache(monthId: String) -> Month? {
        
        let request = NSFetchRequest<Month>()
        request.entity = Month.entity()
        request.predicate = NSPredicate(format: "id == %@", monthId)
        
        do {
            return try context.fetch(request).first
        }
        catch {
            printError(error)
            return nil
        }
    }
    
    func getMonthsFromCache() -> [Month] {
        
        let request = NSFetchRequest<Month>()
        request.entity = Month.entity()
        
        do {
            return try context.fetch(request)
        }
        catch {
            printError(error)
            return []
        }
    }
    
    // api
    
    func updateMonth(monthId: String = formatCurrentDateToString()) async throws {
        
        do {
            
            let monthDto = try await api.getMonth(monthId: monthId)
            let request = NSFetchRequest<Month>()
            
            guard let monthDto = monthDto else {
                return
            }
            
            request.entity = Month.entity()
            request.predicate = NSPredicate(format: "id == %@", monthDto.id)
            
            let existing = try context.fetch(request).first ?? Month(context: context)
            existing.map(from: monthDto)
            
            try context.save()
        }
        catch {
            printError(error)
            throw error
        }
    }
    
    func getAllMonths() async throws {
        
        do {
            let monthDtos = try await api.getAllMonths()
            
            for dto in monthDtos {
                
                let request = NSFetchRequest<Month>()
                
                request.entity = Month.entity()
                request.predicate = NSPredicate(format: "id == %@", dto.id)
                
                let existing = try context.fetch(request).first ?? Month(context: context)
                
                existing.map(from: dto)
            }
            
            try context.save()
        }
        catch {
            printError(error)
            throw error
        }
    }
    
    func addSpending(request: PostSpendingRequest) async throws -> Bool {
        
        do {
            return try await api.addSpending(request: request)
        }
        catch {
            printError(error)
            throw error
        }
    }
    
    // error
    
    func printError(_ error: Error) {
        print("@@@@@  \(error),, ->  \(error.localizedDescription)")
    }
}
