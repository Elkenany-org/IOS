//
//  DetailsDetailsMainModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/11/22.
//

import Foundation

// MARK: - DetailsDetailsMainModel
struct DetailsDetailsMainModel: Codable {
    var message, error: String?
    var data: DetailsDataa?
}

// MARK: - DataClass
struct DetailsDataa: Codable {
    var members: [Members]?
}

// MARK: - Member
struct Members: Codable {
    var id: Int?
    var name: String?
    var counts: Int?
    var days, week, oldprice: String?
}

