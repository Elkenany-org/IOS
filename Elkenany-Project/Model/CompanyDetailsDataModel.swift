//
//  CompanyDetailsDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import Foundation


// MARK: - CompanyDetailsDataModel
struct CompanyDetailsDataModel: Codable {
    var message, error:String?
    var data: MainDataa?
}

// MARK: - DataClass
struct MainDataa: Codable {
    var id: Int?
    var name, shortDesc, about, address: String?
    var latitude, longitude: String?
    var rate, countRate: Double?
    var image: String?
    var createdAt: String?
    var phones: [Phone]?
    var emails: [Email]?
    var mobiles: [Mobile]?
    var faxs: [Fax]?
    var social: [Social]?
    var addresses: [Address]?
    var gallary, products: [MainData]?
    var localstock: [Localstock]?
    
    var cities: [City]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortDesc = "short_desc"
        case about, address, latitude, longitude, rate
        case countRate = "count_rate"
        case image
        case createdAt = "created_at"
        case phones, emails, mobiles, faxs, social, addresses, gallary, products, localstock,  cities
    }
}

// MARK: - Address
struct Address: Codable {
    var address, latitude, longitude: String?
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Email
struct Email: Codable {
    var email: String?
}

// MARK: - Fax
struct Fax: Codable {
    var fax: String?
}

// MARK: - Localstock
struct Localstock: Codable {
    var image: String?
    var name: String?
    var id: Int?
}

// MARK: - Mobile
struct Mobile: Codable {
    var mobile: String?
}

// MARK: - Phone
struct Phone: Codable {
    var phone: String?
}

// MARK: - Social
struct Social: Codable {
    var socialID: Int?
    var socialLink: String?
    var socialName: String?
    var socialIcon: String?

    enum CodingKeys: String, CodingKey {
        case socialID = "social_id"
        case socialLink = "social_link"
        case socialName = "social_name"
        case socialIcon = "social_icon"
    }
}

