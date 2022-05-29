//
//  magazineModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/25/22.
//

import Foundation



// MARK: - MagazineModel
struct MagazineModel: Codable {
    let message, error: String?
    let data: magazineData?
}

// MARK: - DataClass
struct magazineData: Codable {
    let id: Int?
    let name, shortDesc, about, address: String?
    let latitude, longitude: String?
    let countRate: Int?
    let rate:Float?
    let image: String?
    let createdAt: String?
    let phones: [phoneData]?
    let emails: [EmailData]?
    let mobiles: [MobileData]?
    let faxs: [FaxsData]?
    let social: [SocialData]?
    let addresses: [AddressData]?
    let gallary: [gallarysData]?
    let guides: [guidessData]?


    enum CodingKeys: String, CodingKey {
        case id, name
        case shortDesc = "short_desc"
        case about, address, latitude, longitude, rate
        case countRate = "count_rate"
        case image
        case createdAt = "created_at"
        case phones, emails, mobiles, faxs, social, addresses, gallary, guides
    }
}

// MARK: - Address
struct AddressData: Codable {
    let address, latitude, longitude: String?
}

// MARK: - Email
struct EmailData: Codable {
    let email: String?
}


// MARK: - phones
struct phoneData: Codable {
    let phone: String?
}

// MARK: - Mobile
struct MobileData: Codable {
    let mobile: String?
}

struct gallarysData: Codable {
    let image: String?
    let name: String?
    let id:Int?
}


struct guidessData: Codable {
    let image: String?
    let name: String?
    let link: String?
}


struct FaxsData: Codable {
    let fax: String?
}


// MARK: - Social
struct SocialData: Codable {
    let socialID: Int?
    let socialLink: String?
    let socialName: String?
    let socialIcon: String?

    enum CodingKeys: String, CodingKey {
        case socialID = "social_id"
        case socialLink = "social_link"
        case socialName = "social_name"
        case socialIcon = "social_icon"
    }
}

