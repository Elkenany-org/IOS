//
//  chatMessagesModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/18/22.
//

import Foundation

// MARK: - ChatMessages
struct ChatMessages: Codable {
    let message, error: String?
    let data: chatData?
}

// MARK: - DataClass
struct chatData: Codable {
    let chat: Chat?
}

// MARK: - Chat
struct Chat: Codable {
    let massages: [MassageElement]?
}

// MARK: - MassageElement
struct MassageElement: Codable {
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


