//
//  ComperingDoneModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import Foundation


// MARK: - ComperingDoneModel
struct ComperingDoneModel: Codable {
    var message, error: String?
    var data: COMDONE?
}

// MARK: - DataClass
struct COMDONE: Codable {
    var companies: [Companyss]?
}

// MARK: - Company
struct Companyss: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var feed: [Feed]?
}

// MARK: - Feed
struct Feed: Codable {
    var id: Int?
    var name: String?
    var price: Float?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case createdAt = "created_at"
    }
}

