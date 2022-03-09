//
//  AdsStoreDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import Foundation

// MARK: - AdsStoreDataModel
struct AdsStoreDataModel: Codable {
    var message, error: String?
    var data: StorDetails?
}

// MARK: - DataClass
struct StorDetails: Codable {
    var sectors: [Sector]?
    var banners, logos: [String]?
    var sort, data: [Datum]?
    var currentPage, lastPage: Int?
    var firstPageURL: String?
    var nextPageURL: String?
    var lastPageURL: String?

    enum CodingKeys: String, CodingKey {
        case sectors, banners, logos, sort, data
        case currentPage = "current_page"
        case lastPage = "last_page"
        case firstPageURL = "first_page_url"
        case nextPageURL = "next_page_url"
        case lastPageURL = "last_page_url"
    }
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int?
    var title: String?
    var salary: Int?
    var address, createdAt: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case id, title, salary, address
        case createdAt = "created_at"
        case image
    }
}

// MARK: - Sector
struct SectorsSelected: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

