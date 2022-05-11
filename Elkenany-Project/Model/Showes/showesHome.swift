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
    let data: ShowesData?
}

// MARK: - DataClass
struct ShowesData: Codable {
    let sectors: [SectorsSelection]?
    let banners, logos: [String]?
    let data: [showesHomeData]?
    let currentPage, lastPage: Int?
    let firstPageURL, nextPageURL, lastPageURL: String?

    enum CodingKeys: String, CodingKey {
        case sectors, banners, logos, data
        case currentPage = "current_page"
        case lastPage = "last_page"
        case firstPageURL = "first_page_url"
        case nextPageURL = "next_page_url"
        case lastPageURL = "last_page_url"
    }
}

// MARK: - Datum
struct showesHomeData: Codable {
    let id: Int?
    let name: String?
    let rate: Double?
    let image: String?
    let desc, address: String?
    let viewCount: Int?
    let date: String?
    let goingState: String?
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
struct SectorsSelection: Codable {
    let id: Int?
    let name, type: String?
    let selected: Int?
}

