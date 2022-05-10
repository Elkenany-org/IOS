//
//  searchModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/24/22.
//

import Foundation

struct searchModel: Codable {
    var message, error: String?
    var data: DataClassSearch?
}

// MARK: - DataClass
struct DataClassSearch: Codable {
    var result: [Resultt]?
}

// MARK: - Result
struct Resultt: Codable {
    let id: Int?
    let name: String?
    let type:String?
}


