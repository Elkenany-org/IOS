//
//  showesHome.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import Foundation

// MARK: - ShowesHome
struct ShowesHome: Codable {
    let message, error: String?
    let data: showsMainData?
}

// MARK: - DataClass
struct showsMainData: Codable { 
    let sectors: [Sectorrrss]?
    let banners :[Bannerrsshow]?
    let logos: [loggssShow]?
    let data: [ShowesDataModel]?
}

// MARK: - Datum
struct ShowesDataModel: Codable {
    let id: Int?
    let name: String?
    let rate: Double?
    let image: String?
    let desc, address: String?
    let viewCount: Int?
    let date: String?
    let goingState: Bool?
    let deebLink, link: String?

    enum CodingKeys: String, CodingKey {
        case id, name, rate, image, desc, address
        case viewCount = "view_count"
        case date
        case goingState = "going_state"
        case deebLink = "deeb_link"
        case link
    }
}

// MARK: - Sector
struct Sectorrrss: Codable {
    let id: Int?
    let name, type: String?
    let selected: Int?
}


struct Bannerrsshow: Codable {
    var id: Int?
    var link: String?
    var image: String?
}


struct loggssShow: Codable {
    var id: Int?
    var link: String?
    var image: String?
}
