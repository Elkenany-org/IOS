//
//  GuideCompaniesDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//


import Foundation

// MARK: - GuideCompaniesDataModel
struct GuideCompaniesDataModel: Codable {
    var message, error: String?
    var data: GuideData?
}

// MARK: - DataClass
struct GuideData: Codable {
    var sectors: [Sector]?
//    var banners:[String]?
//    var logos: [String]?
    var subSections: [SubSection]?

    enum CodingKeys: String, CodingKey {
        case sectors
        case subSections = "sub_sections"
    }
}

// MARK: - Sector
struct Sector: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

// MARK: - SubSection
struct SubSection: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var companiesCount: Int?
    var logoIn: [LogoIn]?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case companiesCount = "companies_count"
        case logoIn = "logo_in"
    }
}

// MARK: - LogoIn
struct LogoIn: Codable {
    var id: Int?
    var link: String?
    var image: String?
}


