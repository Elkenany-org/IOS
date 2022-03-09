//
//  NewsDetialsDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import Foundation


// MARK: - NewsDetialsDataModel
struct NewsDetialsDataModel: Codable {
    var message, error: String?
    var data: DatanewsDetails?
}

// MARK: - DataClass
struct DatanewsDetails: Codable {
    var banners, logos: [String]?
    var id: Int?
    var title: String?
    var image: String?
    var desc, createdAt: String?
    var news: [MoreNews]?

    enum CodingKeys: String, CodingKey {
        case banners, logos, id, title, image, desc
        case createdAt = "created_at"
        case news
    }
}

// MARK: - News
struct MoreNews: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case createdAt = "created_at"
    }
}

