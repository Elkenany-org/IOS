//
//  feedData.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/19/22.
//

import Foundation

// MARK: - FeedModelData
struct FeedModelData: Codable {
    var message, error: String?
    var data: feedData?
}

// MARK: - DataClass
struct feedData: Codable {
    var fodderCategories, fodderList: [Fodder]?

    enum CodingKeys: String, CodingKey {
        case fodderCategories = "fodder_categories"
        case fodderList = "fodder_list"
    }
}

// MARK: - Fodder
struct Fodder: Codable {
    var id: Int?
    var name: String?
    var selected: Int?
}
