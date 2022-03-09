//
//  BorsaHomeDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import Foundation

// MARK: - BorsaHomeDataModel
struct BorsaHomeDataModel: Codable {
    var message, error: String?
    var data: BorsaData?
}

// MARK: - DataClass
struct BorsaData: Codable {
    var sectors: [Sectorss]?
    var banners: [Banner]?
    var logos:[log]?
    var subSections: [Sections]?
    var fodSections :[FodSections]?

    enum CodingKeys: String, CodingKey {
        case sectors, banners, logos
        case subSections = "sub_sections"
        case fodSections = "fod_sections"
    }
}

// MARK: - Banner
struct Banner: Codable {
    var id: Int?
    var link: String?
    var image: String?
}


struct log: Codable {
    var id: Int?
    var link: String?
    var image: String?
}
// MARK: - Section
struct Sections: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var members: Int?
    var type: String?
    var logoIn: [Banner]?

    enum CodingKeys: String, CodingKey {
        case id, name, image, members, type
        case logoIn = "logo_in"
    }
}

// MARK: - Section
struct FodSections: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var members: Int?
    var type: String?
    var logoIn: [Banner]?

    enum CodingKeys: String, CodingKey {
        case id, name, image, members, type
        case logoIn = "logo_in"
    }
}

// MARK: - Sector
struct Sectorss: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}


