//
//  startChat.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/18/22.
//

import Foundation


// MARK: - StartChat
struct StartChat: Codable {
    let message, error: String?
    let data: startChatClass?
}

// MARK: - DataClass
struct startChatClass: Codable {
    let chat: Chats?
}

// MARK: - Chat
struct Chats: Codable {
    let id: Int?
    let massages: [Massagees]?
}

// MARK: - Massage
struct Massagees: Codable {
    let id: Int?
    let image: String?
    let name: String?
    let createdAt, massage: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case createdAt = "created_at"
        case massage
    }
}


