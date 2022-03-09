//
//  notificationModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import Foundation



// MARK: - NotificationModel
struct NotificationModel: Codable {
    var message, error: String?
    var data: notData?
}

// MARK: - DataClass
struct notData: Codable {
    var nots: [Not]?
}

// MARK: - Not
struct Not: Codable {
    var id: Int?
    var title, desc: String?
    var image: String?
}

