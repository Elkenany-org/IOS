//
//  FirstFilterModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/18/22.
//

import Foundation

// MARK: - FirstFilterModel
struct FirstFilterModel: Codable {
    var message, error: String?
    var data: FilterData?
}

// MARK: - DataClass
struct FilterData: Codable {
    var sectors: [Sectorrr]?
    var sort: [Sortt]?
}

// MARK: - Sector
struct Sectorrr: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

// MARK: - Sort
struct Sortt: Codable {
    var id: Int?
    var name: String?
    var sortValue, value: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sortValue = "value "
        case value
    }
}

