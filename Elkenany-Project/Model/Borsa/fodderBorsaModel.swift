//
//  fodderBorsaModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/19/22.
//

import Foundation


// MARK: - FodderBorsaModel
struct FodderBorsaModel: Codable {
    var message, error: String?
    var data: Fodderdata?
}

// MARK: - DataClass
struct Fodderdata: Codable {
    var columns: [Columnn]?
    var banners: [Banneers]?
    var logos: [loggs]?
    var sectionType: String?
    var members: [Memberss]?

    enum CodingKeys: String, CodingKey {
        case columns, banners, logos
        case sectionType = "section_type"
        case members
    }
}

// MARK: - Banner
struct Banneers: Codable {
    var id: Int?
    var link: String?
    var image: String?
}

struct loggs: Codable {
    var id: Int?
    var link: String?
    var image: String?
}


// MARK: - Column
struct Columnn: Codable {
    var title: String?
}

// MARK: - Member
struct Memberss: Codable {
    var name: String?
    var memID: Int?
    var feed: String?
    var price: Int?
    var change, changeDate: String?
    var statistics: String?
    var type: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case memID = "mem_id"
        case feed, price, change
        case changeDate = "change_date"
        case statistics, type
    }
}

