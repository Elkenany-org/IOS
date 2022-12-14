//
//  sendMessage.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/18/22.
//

import Foundation


// MARK: - SendMessage
struct SendMessage: Codable {
    let message, error: String?
    let data: sendmessage?
}

// MARK: - DataClass
struct sendmessage: Codable {
    let chat: Chatt?
}

// MARK: - Chat
struct Chatt: Codable {
    let massages: [Massageing]?
}

// MARK: - Massage
struct Massageing: Codable {
    let id: Int?
    let image: String?
    let name: String?
    let createdAt: String?
    let massage: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case createdAt = "created_at"
        case massage
    }
}



