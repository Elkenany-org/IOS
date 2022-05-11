//
//  ShowReview.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import Foundation



// MARK: - ShowReview
struct ShowReview: Codable {
    let message, error: String?
    let data: ShowesRevwiesData?
}

// MARK: - DataClass
struct ShowesRevwiesData: Codable {
    let banners, logos: [String]?
    let review: [Review]?
    let rate: Double?
}

// MARK: - Review
struct Review: Codable {
    let name, email, desc, createdAt: String?
    let rate: Double?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name, email, desc
        case createdAt = "created_at"
        case rate, id
    }
}

