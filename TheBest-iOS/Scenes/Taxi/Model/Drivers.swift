//
//  Drivers.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Drivers
struct Drivers: Codable {
    let drivers: DriversClass

    enum CodingKeys: String, CodingKey {
        case drivers = "Drivers"
    }
}

// MARK: - DriversClass
struct DriversClass: Codable {
    let id: Int
    let name, email: String
    let image: String
    let fcmToken, phone: String
    let isAdmin, isDriver: Int
    let lat, lng: Double
    let birthDate, nationality: String?
    let status, createdAt, updatedAt: String
    let distance: Double
    let myCar: [MyCar]

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
        case distance
        case myCar = "my_car"
    }
}

// MARK: - MyCar
struct MyCar: Codable {
    let id: Int
    let carNumber: String
    let image: String
    let carModel, userID: Int
    let type, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case carNumber = "car_number"
        case image = "has_image"
        case carModel = "car_model"
        case userID = "user_id"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
