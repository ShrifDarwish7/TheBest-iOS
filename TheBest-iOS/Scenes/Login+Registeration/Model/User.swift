//
//  User.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - User
struct User: Codable {
    
    let massege: String?
    let user: UserClass
    let accessToken: String
    
    enum CodingKeys: String, CodingKey{
        case massege
        case user   
        case accessToken
    }
    
}

// MARK: - UserClass
struct UserClass: Codable {
    
    let id: Int
    let name, email: String
    let image: String
    let fcmToken, phone: String
    let isAdmin, isDriver: Int
    let lat, lng, birthDate, nationality: String?
    let status: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, email, image
        case fcmToken = "fcm_token"
        case phone
        case isAdmin = "is_admin"
        case isDriver = "is_driver"
        case lat, lng
        case birthDate = "birth_date"
        case nationality, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
