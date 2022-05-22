//
//  PostSpendingRequest.swift
//  SlediPari
//
//  Created by Lyubomir Yordanov on 5/21/22.
//

import Foundation

struct PostSpendingRequest: Codable {
    
    let monthId: String
    let title: String
    let price: Double
}
