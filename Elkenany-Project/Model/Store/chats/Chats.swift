//
//  Chats.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/27/22.
//

import Foundation



// MARK: - Chats
struct ChatsModel: Codable {
    let message, error: String?
    let data: MainChat?
}

// MARK: - DataClass
struct MainChat: Codable {
    let chat: [Chating]?
}

// MARK: - Chat
struct Chating: Codable {
    let massage: String?
    let id: Int?
    let createdAt: String?
    let image: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case massage, id
        case createdAt = "created_at"
        case image, name
    }
}

