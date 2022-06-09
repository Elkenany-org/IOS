//
//  shipsStat.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/9/22.
//

import Foundation


// MARK: - ShipsModel
struct ShipsStatModel: Codable {
    let message, error: String?
    let data: shipsStatData?
}

// MARK: - DataClass
struct shipsStatData: Codable {
    let ships: [ShipMainData]?
    let products: [ProductElement]?
    let countries: [CountryForShip]?
}

// MARK: - Country
struct CountryForShip: Codable {
    let country: String?
}

// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int?
    let name: String?
    let load: Int?
}

// MARK: - Ship
struct ShipMainData: Codable {
    let id: Int?
    let product: String?
    let country: String?
    let load: Int?
}



