//
//  Showers.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import Foundation


// MARK: - Showers
struct Showers: Codable {
    let message, error: String?
    let data: ShowersData?
}

// MARK: - DataClass
struct ShowersData: Codable {
    let banners, logos, showers: [String]?

    enum CodingKeys: String, CodingKey {
        case banners, logos
        case showers = "Showers"
    }
}

