//
//  forget_password_send_phone.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 9/27/22.
//

import Foundation

import Foundation

// MARK: - SearchMainModel
struct Forget_password_send_phone: Codable {
    let message: String?
    let error: String?
    let data: ForgetPasswordData?
}

// MARK: - DataClass
struct ForgetPasswordData: Codable {
    let name, email: String?
}

