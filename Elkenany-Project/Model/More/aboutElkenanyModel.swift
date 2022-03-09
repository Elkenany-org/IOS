//
//  aboutElkenanyModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import Foundation


// MARK: - AboutElkenanyModel
struct AboutElkenanyModel: Codable {
    var message, error: String?
    var data: aboutData?
}

// MARK: - DataClass
struct aboutData: Codable {
    var offices: [Office]?
}

// MARK: - Office
struct Office: Codable {
    var id: Int?
    var name, address, latitude, longitude: String?
    var desc: String?
    var status: Int?
    var phones: [Phonee]?
    var emails: [Emaill]?
    var mobiles: [Mobilee]?
    var faxs: [Faxx]?
    var selected: Int?
}

// MARK: - Email
struct Emaill: Codable {
    var email: String?
}

// MARK: - Fax
struct Faxx: Codable {
    var fax: String?
}

// MARK: - Mobile
struct Mobilee: Codable {
    var mobile: String?
}

// MARK: - Phone
struct Phonee: Codable {
    var phone: String?
}

// MARK: - Encode/decode helpers
