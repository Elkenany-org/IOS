//
//  subGuideFilter.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import Foundation


// MARK: - SubGuideFilter
struct SubGuideFilter: Codable {
    var message, error: String?
    var data: GuideDataMoadelFilterr?
}

// MARK: - DataClass
struct GuideDataMoadelFilterr: Codable {
    var sectors: [Country]?
    var subSections: [Cityy]?
    var countries: [Country]?
    var cities: [City]?
    var sort: [Sorttr]?

    enum CodingKeys: String, CodingKey {
        case sectors
        case subSections = "sub_sections"
        case countries, cities, sort
    }
}

// MARK: - City
struct Cityy: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Country
struct Country: Codable {
    var id: Int?
    var name: String?
    var selected: Int?
    var type: String?
}

// MARK: - Sort
struct Sorttr: Codable {
    var id: Int?
    var name: String?
    var sortValue, value: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sortValue = "value "
        case value
    }
}

