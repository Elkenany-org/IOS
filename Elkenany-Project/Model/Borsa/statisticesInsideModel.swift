//
//  statisticesInsideModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/11/22.
//

import Foundation


// MARK: - StatisticesInsideModel
struct StatisticesInsideModel: Codable {
    var message, error: String?
    var data: InsideData?
}

// MARK: - DataClass
struct InsideData: Codable {
    var listMembers: [ListMember]?
    var changesMembers: [ChangesMember]?

    enum CodingKeys: String, CodingKey {
        case listMembers = "list_members"
        case changesMembers = "changes_members"
    }
}

// MARK: - ChangesMember
struct ChangesMember: Codable {
    var id: Int?
    var name, change: String?
    var counts: Float?
}

// MARK: - ListMember
struct ListMember: Codable {
    var id: Int?
    var name: String?
}

