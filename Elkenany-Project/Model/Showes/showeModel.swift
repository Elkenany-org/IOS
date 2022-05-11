//
//  showeModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import Foundation


// MARK: - ShoweModel
struct ShoweModel: Codable {
    let message, error: String?
    let data: showesDataaa?
}

// MARK: - DataClass
struct showesDataaa: Codable {
    let banners, logos: [String]?
    let id: Int?
    let name, shortDesc: String?
    let viewCount: Int?
    let address: String?
    let rate, countShowers: Int?
    let image: String?
    let createdAt: String?
    let times: [Time]?
    let watches: [Watch]?
    let teckits: [Teckit]?
    let images: [ShowesImage]?
    let organisers: [Organiser]?

    enum CodingKeys: String, CodingKey {
        case banners, logos, id, name
        case shortDesc = "short_desc"
        case viewCount = "view_count"
        case address, rate
        case countShowers = "count_Showers"
        case image
        case createdAt = "created_at"
        case times, watches, teckits, images, organisers
    }
}

// MARK: - Image
struct ShowesImage: Codable {
    let image: String?
    let id: Int?
}

// MARK: - Organiser
struct Organiser: Codable {
    let name: String?
    let id: Int?
}

// MARK: - Teckit
struct Teckit: Codable {
    let name: String?
    let price: Int?
}

// MARK: - Time
struct Time: Codable {
    let phone: String?
}

// MARK: - Watch
struct Watch: Codable {
    let watch: String?
}

