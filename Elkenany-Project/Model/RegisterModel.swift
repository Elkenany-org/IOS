//
//  RegisterModel.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/5/21.
//

import Foundation


// MARK: - RegisterModel
struct RegisterDataModel: Codable {
    var message, error: JSONNull?
    var data: RegisterData?
}

// MARK: - DataClass
struct RegisterData: Codable {
    var name, email, phone, apiToken: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case apiToken = "api_token"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
