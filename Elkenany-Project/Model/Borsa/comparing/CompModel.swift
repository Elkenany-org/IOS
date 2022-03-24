//
//  CompModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import Foundation



// MARK: - CompModel
struct CompModel: Codable {
    var message, error: String?
    var data: CompDataa?
}

// MARK: - DataClass
struct CompDataa: Codable {
    var stockName: String?
    var companies, feeds: [Company]?

    enum CodingKeys: String, CodingKey {
        case stockName = "stock_name"
        case companies, feeds
    }
}

// MARK: - Company
struct Company: Codable {
    var id: Int?
    var name: String?
}

