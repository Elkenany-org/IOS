//
//  addAds.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/20/22.
//

import Foundation


// MARK: - AddAds
struct AddAds: Codable {
    let message: String?
    let error: String?
    let data: addDetails?
}

// MARK: - DataClass
struct addDetails: Codable {
    let adDetials: AdDetials?

    enum CodingKeys: String, CodingKey {
        case adDetials = "ad_detials"
    }
}

// MARK: - AdDetials
struct AdDetials: Codable {
    let id: Int?
    let title, desc, phone, address: String?
    let conType, salary: String?
    let images: [Imagees]?

    enum CodingKeys: String, CodingKey {
        case id, title, desc, phone, address
        case conType = "con_type"
        case salary, images
    }
}

// MARK: - Image
struct Imagees: Codable {
    let id: Int?
    let image: String?
}

