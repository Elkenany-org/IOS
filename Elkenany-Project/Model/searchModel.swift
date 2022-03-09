//
//  searchModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/24/22.
//

import Foundation


// MARK: - SearchModel
struct SearchModel: Codable {
    let message, error: String?
    let data: searchdataModell?
}

// MARK: - DataClass
struct searchdataModell: Codable {
    let result: [Resultssss]?
}

// MARK: - Result
struct Resultssss: Codable {
    let id: Int?
    let name: String?
    let type: String?
}

