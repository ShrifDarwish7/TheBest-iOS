//
//  SpecialCars.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - SpecialCars
struct SpecialCars: Codable {
    let specialCars: [SpecialCar]

    enum CodingKeys: String, CodingKey {
        case specialCars = "SpecialCar"
    }
}

// MARK: - SpecialCar
struct SpecialCar: Codable {
    let id: Int
    let name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
