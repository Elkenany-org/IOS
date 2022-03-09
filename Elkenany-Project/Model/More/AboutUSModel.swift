//
//  AboutUSModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/23/22.
//

import Foundation



// MARK: - AboutUSModel
struct AboutUSModel: Codable {
    let message, error: String?
    let data: AboutData
}

// MARK: - DataClass
struct AboutData: Codable {
    let about: String
}

