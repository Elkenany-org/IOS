//
//  RatingModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/26/22.
//

import Foundation


// MARK: - Rating
struct RatingModel: Codable {
    let message, error: String?
    let data: RatingClass?
}

// MARK: - DataClass
struct RatingClass: Codable {
    let id: Int?
    let rate: String?
    let companyID, userID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, rate
        case companyID = "company_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

