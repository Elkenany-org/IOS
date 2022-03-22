//
//  LoginModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    var message: String?
    var error: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var name, email, phone, apiToken: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case apiToken = "api_token"
    }
}


