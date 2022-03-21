//
//  StokeFilterDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/21/22.
//

import Foundation

// MARK: - StokeFilterDataModel
struct StokeFilterDataModel: Codable {
    var message, error: String?
    var data: BorsaDataFilter?
}

// MARK: - DataClass
struct BorsaDataFilter: Codable {
    var sections, subSections, fodderSubSections: [Sections]?

    enum CodingKeys: String, CodingKey {
        case sections
        case subSections = "sub_sections"
        case fodderSubSections = "fodder_sub_sections"
    }
}

// MARK: - Section
struct Sectionsss: Codable {
    var id: Int?
    var name, type, selected: String?
}

