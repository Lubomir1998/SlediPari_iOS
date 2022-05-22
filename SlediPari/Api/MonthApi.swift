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
            throw MonthsError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let months = try JSONDecoder().decode([MonthDTO].self, from: data)
        return months
    }
    
    func addSpending(request: PostSpendingRequest) async throws -> Bool {
        
        guard let url = URL(string: getBaseUrl() + "getAllMonths") else {
            throw MonthsError.invalidUrl
        }
        
        let requestBody = ["monthId": request.monthId, "title": request.title, "price": request.price] as [String : Any]
        let finalBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Bool.self, from: data)
    }
    
}

enum MonthsError: Error {
    case invalidUrl
    case somethingIsWrong
}
