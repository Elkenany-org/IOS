//
//  CompainesModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import Foundation


// MARK: - CompaniesDataModel
struct CompaniesDataModel: Codable {
    var message, error: String?
    var data: Data?
}

// MARK: - DataClass
struct Data: Codable {
    var sectors: [Sectorr]?
    var banners, compsort: [Any]?
    var logos:[Any]?
    var data: [MainData]?
    var currentPage, lastPage: Int?
    var firstPageURL, nextPageURL, lastPageURL: String?

    enum CodingKeys: String, CodingKey {
        case sectors, data
        case currentPage = "current_page"
        case lastPage = "last_page"
        case firstPageURL = "first_page_url"
        case nextPageURL = "next_page_url"
        case lastPageURL = "last_page_url"
    }
}

// MARK: - Datum
struct MainData: Codable {
    var id: Int?
    var name: String?
    var rate: Double?
    var image: String?
    var desc, address: String?
}

// MARK: - Sector
struct Sectorr: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

