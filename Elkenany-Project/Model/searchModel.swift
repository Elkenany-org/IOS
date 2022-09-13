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
    let type: String?
    
}
