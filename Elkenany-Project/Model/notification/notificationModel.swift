//
//  notificationModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import Foundation


// MARK: - AddPlaces
struct NotificationModel: Codable {
    let message, error: String?
    let data: DataNotification?
}

// MARK: - DataClass
struct DataNotification: Codable {
    let result: [ResultNot]?
}

// MARK: - Result
struct ResultNot: Codable {
    let id: Int?
    let title, desc: String?
    let image: String?
    let createdAt: String?
    let keyName: String?
    let keyID: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, desc, image
        case createdAt = "created_at"
        case keyName = "key_name"
        case keyID = "key_id"
    }
}

enum KeyName: String, Codable {
    case companies = "companies"
    case news = "news"
}

