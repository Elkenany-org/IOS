//
//  aboutUsMO.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/23/22.
//

import Foundation




// MARK: - AboutUSModel
struct AboutUSModell: Codable {
    let message, error: String?
    let data: AboutDataa?
}

// MARK: - DataClass
struct AboutDataa: Codable {
    let about: String?
}

