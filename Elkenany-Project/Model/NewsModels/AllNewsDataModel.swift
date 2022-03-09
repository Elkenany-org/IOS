//
//  AllNewsDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import Foundation

// MARK: - AllNewsDataModel
struct AllNewsDataModel: Codable {
    var message, error: String?
    var data: DataNews?
}

// MARK: - DataClass
struct DataNews: Codable {
    var sections: [Section]?
    var banners, logos: [String]?
    var data: [Dataa]?
    var currentPage, lastPage: Int?
    var firstPageURL, nextPageURL, lastPageURL: String?

    enum CodingKeys: String, CodingKey {
        case sections, banners, logos, data
        case currentPage = "current_page"
        case lastPage = "last_page"
        case firstPageURL = "first_page_url"
        case nextPageURL = "next_page_url"
        case lastPageURL = "last_page_url"
    }
}

// MARK: - Datum
struct Dataa: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
    }
}

// MARK: - Section
struct Section: Codable {
    var id: Int?
    var name, type: String?
    var selected: Int?
}

