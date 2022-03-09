//
//  ProfileData.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import Foundation

// MARK: - ProfileData
struct ProfileData: Codable {
    var message, error: String?
    var data: profiledata?
}

// MARK: - DataClass
struct profiledata: Codable {
    var id: Int?
    var name, phone, email: String?
    var image: String?
    var state: String?
}

