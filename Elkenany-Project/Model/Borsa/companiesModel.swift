//
//  companiesModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/19/22.
//

import Foundation


// MARK: - FeedModelData
struct CompaniesModelData: Codable {
    var message, error: String?
    var data: [CompanySelection]?
}

// MARK: - Datum
struct CompanySelection: Codable {
    var id: Int?
    var name: String?
    var selected: Int?
}

