//
//  EditeMainInfoModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/29/21.
//

import Foundation

// MARK: - EditeMainInfoModel
struct EditeMainInfoModel: Codable {
    var message: String?
    var error: String?
    var data: infoDataEdite?
}

// MARK: - DataClass
struct infoDataEdite: Codable {
    var id: Int?
    var name, phone, email: String?
    var image: String?
    var state: String?
}

