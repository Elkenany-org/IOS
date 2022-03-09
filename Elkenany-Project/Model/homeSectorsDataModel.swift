//
//  homeSectorsDataModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import Foundation


// MARK: - HomeSectorsDataModel
struct HomeSectorsDataModel: Codable {
    var message, error: String?
    var data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    var sectors: [Sectors]?
    var logos: [Logo]?
    var popup: Popup?
    var type: String?
    var guide: [Guide]?
    var news:[News]?
    var recomandtion:[Recomandtion]?
    var stock: [Stock]?
    var store: [Guide]?
}

// MARK: - Guide
struct Guide: Codable {
    var id: Int?
    var name, type: String?
    var image: String?
    var companiesCount, members: Int?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case id, name, type, image
        case companiesCount = "companies_count"
        case members, title
    }
}

// MARK: - Logo
struct Logo: Codable {
    var id: Int?
    var link: String?
    var image: String?
}

// MARK: - Popup
struct Popup: Codable {
    var id: Int?
    var link: String?
    var media: String?
}


struct Sectors : Codable {
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


struct Stock : Codable {
    let id : Int?
    let name : String?
    let type : String?
    let image : String?
    let members : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case image = "image"
        case members = "members"
    }

}


struct Recomandtion : Codable {
    let id : Int?
    let name : String?
    let type : String?
    let image : String?
    let companies_count : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case type = "type"
        case image = "image"
        case companies_count = "companies_count"
    }


}

struct News : Codable {
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
