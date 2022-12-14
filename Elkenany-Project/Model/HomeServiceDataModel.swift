//
//  HomeServiceDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/6/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeTestModel = try? newJSONDecoder().decode(HomeTestModel.self, from: jsonData)

import Foundation

// MARK: - HomeTestModel
struct HomeTestModelss: Codable {
    let message, error: String?
    let data: DataClassSS?
}

// MARK: - DataClass
struct DataClassSS: Codable {
    let logos: [LogoSS]?
    let type: String?
    let recomandtion, show, magazine: [Magazine]?
}

// MARK: - Logo
struct LogoSS: Codable {
    let id: Int?
    let link: String?
    let image, imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, link, image
        case imageURL = "image_url"
    }
}

// MARK: - Magazine
struct Magazine: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let type: String?
    let imageURL, imageThumURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, type
        case imageURL = "image_url"
        case imageThumURL = "image_thum_url"
    }
}



