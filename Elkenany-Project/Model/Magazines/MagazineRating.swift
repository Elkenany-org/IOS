//
//  MagazineRating.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/31/22.
//

import Foundation


// MARK: - MagazineModel
struct MagazineRating: Codable {
    let message, error: String?
    let data:RatingDataaa?
}

// MARK: - DataClass
struct RatingDataaa: Codable {
    let rate, magaID: String?
    let userID: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case rate
        case magaID = "maga_id"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
