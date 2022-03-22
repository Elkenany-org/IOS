//
//  AdsStoreDetailsDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import Foundation


// MARK: - AdsStoreDetailsDataModel
struct AdsStoreDetailsDataModel: Codable {
    var message, error: String?
    
    var data: DetailsData?
}

// MARK: - DataClass
struct DetailsData: Codable {
    var banners, logos: [String]?
    var id: Int?
    var title: String?
    var salary: Int?
    var phone: String?
    var viewCount: Int?
    var address, paid, user, type: String?
    var desc, createdAt: String?
    var images: [Image]?

    enum CodingKeys: String, CodingKey {
        case banners, logos, id, title, salary, phone
        case viewCount = "view_count"
        case address, paid, user, type, desc
        case createdAt = "created_at"
        case images
    }
}

// MARK: - Image
struct Image: Codable {
    var image: String?
}

