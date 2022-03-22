//
//  RegisterModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import Foundation


// MARK: - RegisterModel
struct RegisterDataModel: Codable {
    var message, error: String?
    var data: RegisterData?
}

// MARK: - DataClass
struct RegisterData: Codable {
    var name, email, phone, apiToken: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case apiToken = "api_token"
    }
}


