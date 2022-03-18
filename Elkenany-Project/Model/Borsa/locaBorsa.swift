//
//  locaBorsa.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/23/21.
//

import Foundation

// MARK: - LocaBorsa
struct LocaBorsa: Codable {
    var message, error: String?
    var data: BorsaDataa?
}

// MARK: - DataClass
struct BorsaDataa: Codable {
    var columns: [Column]?
    var banners: [Bannerr]?
    var logos:[logg]?
    var members: [Member]?
}

struct logg: Codable {
    var id: Int?
    var link: String?
    var image: String?
}

struct Bannerr: Codable {
    var id: Int?
    var link: String?
    var image: String?
}

// MARK: - Column
struct Column: Codable {
    var title: String?
}

// MARK: - Member
struct Member: Codable {
    var name: String?
    var memID: Int?
    var kind, change, changetwo: String?
    var  price: Int?
    var statistics: String?
    var newColumns: [String]?
    var type: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case memID = "mem_id"
        case kind, change, statistics
        case changetwo = "change_date"
        case newColumns = "new_columns"
        case type
    }
}

