//
//  StatisticesInsideModelFodder.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/22/22.
//

import Foundation

// MARK: - StatisticesInsideModel
struct StatisticesInsideModelFodder: Codable {
    var message, error: String?
    var data: InsideDataFodder?
}

// MARK: - DataClass
struct InsideDataFodder: Codable {
    var listMembers: [ListMemberrr]?
    var changesMembers: [ChangesMemberrr]?

    enum CodingKeys: String, CodingKey {
        case listMembers = "list_members"
        case changesMembers = "changes_members"
    }
}

// MARK: - ChangesMember
struct ChangesMemberrr: Codable {
    var id: Int?
    var name: String?
    var change:Int?
    var counts: Int?
}

// MARK: - ListMember
struct ListMemberrr: Codable {
    var id: Int?
    var name: String?
}
