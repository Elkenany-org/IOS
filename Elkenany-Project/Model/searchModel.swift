//
//  searchModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/24/22.
//

import Foundation

// MARK: - SearchMainModel
struct SearchMainModel: Codable {
    let message, error: String?
    let data: MainSearchData?
}

// MARK: - DataClass
struct MainSearchData: Codable {
    let result: [SearchResultian]?
}

// MARK: - Result
struct SearchResultian: Codable {
    let id: Int?
    let name: String?
//    let price: Float?
//    let address: String?
//    let image: String?
//    let short_desc: String?
//    let created_at: String?
//    let date: [String]?
//    let count: Int?
    let type: String?
    
}
