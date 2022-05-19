//
//  MonthApi.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/14/22.
//

import Foundation

class MonthApi {
    
    func getMonth(monthId: String) async throws -> MonthDTO? {
        
        var urlComponents = URLComponents(url: URL(string: getBaseUrl() + "getExpense")!, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [.init(name: "month", value: monthId)]
        
        guard let url = urlComponents?.url else {
            throw MonthsError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let month = try JSONDecoder().decode(MonthDTO.self, from: data)
        return month
    }
    
    func getAllMonths() async throws -> [MonthDTO] {
        
        guard let url = URL(string: getBaseUrl() + "getAllMonths") else {
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let months = try JSONDecoder().decode([MonthDTO].self, from: data)
        return months
    }
    
}

enum MonthsError: Error {
    case invalidUrl
    case somethingIsWrong
}
