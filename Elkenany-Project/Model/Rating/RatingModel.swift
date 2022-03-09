//
//  RatingModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/26/22.
//

import Foundation

// MARK: - RatingModel
struct RatingModel: Codable {
    var message, error: String?
    var data: RatingData?
}

// MARK: - DataClass
struct RatingData: Codable {
    var rate, companyID: String?
    var userID: Int?
    var updatedAt, createdAt: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case rate
        case companyID = "company_id"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

