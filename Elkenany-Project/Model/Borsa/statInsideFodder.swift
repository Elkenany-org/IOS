//
//  statInsideFodder.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/22/22.
//

import Foundation

struct statInsideFodder: Codable {
    var message, error: String?
    var data: InsideDataFodder?
}

// MARK: - DataClass
struct InsideDataFodder: Codable {
    var listMembersss: [ListMemberrr]?
    var changesMembersss: [ChangesMemberrr]?

    enum CodingKeys: String, CodingKey {
        case listMembersss = "list_members"
        case changesMembersss = "changes_members"
    }
}

// MARK: - ChangesMember
struct ChangesMemberrr: Codable {
    var id: Int?
    var name: String?
    var change:String?
    var counts: Int?
}

// MARK: - ListMember
struct ListMemberrr: Codable {
    var id: Int?
    var name: String?
}
