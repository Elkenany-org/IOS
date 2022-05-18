//
//  homeTestModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/18/22.
//

import Foundation


// MARK: - HomeTestModel
struct HomeTestModel: Codable {
    let message, error: String?
    let data: DataClasssss?
}

// MARK: - DataClass
struct DataClasssss: Codable {
    let logos: [Logoss]?
    let type: String?
    let recomandtion, show, magazine: [Magaziness]?
}

// MARK: - Logo
struct Logoss: Codable {
    let id: Int?
    let link: String?
    let image, imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, link, image
        case imageURL = "image_url"
    }
}

// MARK: - Magazine
struct Magaziness: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let type: TypeEnum?
    let imageURL, imageThumURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, type
        case imageURL = "image_url"
        case imageThumURL = "image_thum_url"
    }
}

enum TypeEnum: String, Codable {
    case magazines = "magazines"
    case show = "show"
}

