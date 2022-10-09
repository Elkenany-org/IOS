//
//  StatisticsShipsDetialsModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 10/9/22.
//

import Foundation

// MARK: - StatisticsShipsDetialsModel
struct StatisticsShipsDetialsModel: Codable {
    let message, error: String?
    let data: SShipsDetialsData?
}

// MARK: - DataClass
struct SShipsDetialsData: Codable {
    let countries: [Countrylist]?
    let companies: [CompanyStat]?
    let shipsCharts: [ShipsListData]?

    enum CodingKeys: String, CodingKey {
        case countries, companies
        case shipsCharts = "ships_charts"
    }
}

// MARK: - Company
struct CompanyStat: Codable {
    let id: Int?
    let name: String?
    let data: [StatData]?
}

// MARK: - Datum
struct StatData: Codable {
    let product: String?
    let country: String?
    let load: Int?
    let nums: String?
}

// MARK: - CountryElement
struct Countrylist: Codable {
    let country: String?
}

// MARK: - ShipsChart
struct ShipsListData: Codable {
    let product: String?
    let load: Int?
}
