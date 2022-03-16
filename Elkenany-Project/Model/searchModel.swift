//
//  searchModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/24/22.
//

import Foundation


// MARK: - SearchModel
struct SearchModel: Codable {
    var message, error: String?
    var data: searchdataModell?
}

// MARK: - DataClass
struct searchdataModell: Codable {
    var result: [Resultssss]?
}

// MARK: - Result
struct Resultssss: Codable {
    var id: Int?
    var name: String?
    var type: String?
}

