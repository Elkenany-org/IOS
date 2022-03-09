//
//  HomeServiceDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/6/21.
//

import Foundation

// MARK: - HomeServiceDataModel
struct HomeServiceDataModel: Codable {
    var message, error: String?
    var ServiceData: HomeDataS?
}

// MARK: - DataClass
struct HomeDataS: Codable {
    var logos: [Logoo]?
    var type: String?
    var  magazine: [Magazine]?
    var show:[Show]?
    var recomandtion:[RecomandtionS]?
}

// MARK: - Logo
struct Logoo: Codable {
    var id: Int?
    var link: String?
    var image: String?
}

// MARK: - Magazine
struct Magazine: Codable {
    var id: Int?
    var name, type: String?
    var image: String?
}


struct RecomandtionS : Codable {
    let id : Int?
    let name : String?
    let type : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case image = "image"
    }
}


struct Show : Codable {
    let id : Int?
    let name : String?
    let type : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case image = "image"
    }
}
