//
//  shipsModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/6/22.
//

import Foundation


// MARK: - ShipsModel
struct ShipsModel: Codable {
    let message, error: String?
    let data: ShipData?
}

// MARK: - DataClass
struct ShipData: Codable {
    let banners: [shipBanners]?
    let logos: [shiplogo]?
    let ships: [Ship]?
}

// MARK: - Ship
struct Ship: Codable {
    let id: Int?
    let name: String?
    let load: Int?
    let product, country, date, company: String?
    let port, agent, dirDate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, load, product, country, date, company
        case port = "Port"
        case agent
        case dirDate = "dir_date"
    }
}


struct shiplogo: Codable {
    let id: Int?
    let link:String?
    let image:String?
}

struct shipBanners: Codable {
    let id: Int?
    let link:String?
    let image:String?
}
