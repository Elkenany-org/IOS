//
//  statisticsStockSectionsModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/6/22.
//

import Foundation


// MARK: - StatisticsStockSectionsModel
struct StatisticsStockSectionsModel: Codable {
    var message, error: String?
    var data: StatisticsData?
}

// MARK: - DataClass
struct StatisticsData : Codable {
    var section: String?
    var listSubs: [ListSub]?
    var changesSubs: [ChangesSub]?

    enum CodingKeys: String, CodingKey {
        case section = "Section"
        case listSubs = "list_subs"
        case changesSubs = "changes_subs"
    }
}

// MARK: - ChangesSub
struct ChangesSub: Codable {
    var id: Int?
    var name, change: String?
    var counts: Int?
}

// MARK: - ListSub
struct ListSub: Codable {
    var id: Int?
    var name: String?
}

