//
//  password_code.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 9/27/22.
//




import Foundation
// MARK: - PasswordCode
struct PasswordCode: Codable {
    let message: String?
    let error: String?
    let data: passwordCodeData?
}

// MARK: - DataClass
struct passwordCodeData: Codable {
    let name, email, phone, apiToken: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case apiToken = "api_token"
    }
}
