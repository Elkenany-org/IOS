//
//  TestBorsaMember.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/23/22.
//

import Foundation


// MARK: - TestBorsaMember
struct TestBorsaMember: Codable {
    var message, error: String?
    var datas: TestFodderMem?
}

// MARK: - DataClass
struct TestFodderMem: Codable {
    var listMemberss: [ListMemberF]?
    var changesMemberss: [ChangesMemberF]?

    enum CodingKeys: String, CodingKey {
        case listMemberss = "list_members"
        case changesMemberss = "changes_members"
    }
}

// MARK: - ChangesMember
struct ChangesMemberF: Codable {
    var id: Int?
    var name, change: String?
    var counts: Int?
}

// MARK: - ListMember
struct ListMemberF: Codable {
    var id: Int?
    var name: String?
}

