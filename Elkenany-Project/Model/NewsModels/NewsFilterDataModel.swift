//
//  NewsFilterDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import Foundation


// MARK: - NewsFilterDataModel
struct NewsFilterDataModel: Codable {
    var message, error: String?
    var data: DataNewsFilter?
}

// MARK: - DataClass
struct DataNewsFilter: Codable {
    var sectors: [SectorSection]?
    var sort: [Sort]?
}

// MARK: - Sector
struct SectorSection: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

// MARK: - Sort
struct Sort: Codable {
    var id: Int?
    var name: String?
    var sortValue, value: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sortValue = "value "
        case value
    }
}

