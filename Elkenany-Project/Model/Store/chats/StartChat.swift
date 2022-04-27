//
//  StartChat.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/27/22.
//

import Foundation


// MARK: - StartChat
struct StartChatModelss: Codable {
    let message, error: String?
    let data: StartChatModel?
}

// MARK: - DataClass
struct StartChatModel: Codable {
    let chat: StarttChats?
}

// MARK: - Chat
struct StarttChats: Codable {
    let id: Int?
    let massages: [MassageForStarting]?
}

// MARK: - Massage
struct MassageForStarting: Codable {
    let id: Int?
    let image: String?
    let name, createdAt, massage: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case createdAt = "created_at"
        case massage
    }
}

