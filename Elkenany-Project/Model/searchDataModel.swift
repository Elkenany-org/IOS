//
//  searchDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/10/22.
//

import Foundation

// MARK: - SearchDataModel
struct SearchDataModell: Codable {
    let message, error: String?
    let data: SearchDataModelClass?
}

// MARK: - DataClass
struct SearchDataModelClass:Codable {
    let result: [ResultSearch]?
}

// MARK: - Result
struct ResultSearch: Codable {
    let id: Int?
    let name, type: String?
}
