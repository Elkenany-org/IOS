//
//  Speakers.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import Foundation



// MARK: - Speakers
struct Speakers: Codable {
    let message, error: String?
    let data: SpeakersData?
}

// MARK: - DataClass
struct SpeakersData: Codable {
    let banners, logos: [String]?
    let speakers: [Speakerr]?

    enum CodingKeys: String, CodingKey {
        case banners, logos
        case speakers = "Speakers"
    }
}

// MARK: - Speaker
struct Speakerr: Codable {
    let id: Int?
    let image: String?
    let name, type: String?
}

