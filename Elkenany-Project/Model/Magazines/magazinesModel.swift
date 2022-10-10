//
//  magazinesModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import Foundation


// MARK: - HomeTestModel
struct MagazineS: Codable {
    let message, error: String?
    let data: MagazineData?
}

// MARK: - DataClass
struct MagazineData: Codable {
    let sectors: [Sectorrs]?
    let banners: [Bannerrs]?
    let logos: [loggss]?
    let data: [magazinesData]?
//    let currentPage, lastPage: Int?
//    let firstPageURL, nextPageURL, lastPageURL: String?

//    enum CodingKeys: String, CodingKey {
//        case sectors, banners, logos, data
//        case currentPage = "current_page"
//        case lastPage = "last_page"
//        case firstPageURL = "first_page_url"
//        case nextPageURL = "next_page_url"
//        case lastPageURL = "last_page_url"
//    }
}

// MARK: - Datum
struct magazinesData: Codable {
    let id: Int?
    let name: String?
    let rate: Double?
    let image: String?
    let desc, address: String?
}

// MARK: - Sector
struct Sectorrs: Codable {
    let id: Int?
    let name, type: String?
    let selected: Int?
}

struct Bannerrs: Codable {
    var id: Int?
    var link: String?
    var image: String?
}


struct loggss: Codable {
    var id: Int?
    var link: String?
    var image: String?
}
