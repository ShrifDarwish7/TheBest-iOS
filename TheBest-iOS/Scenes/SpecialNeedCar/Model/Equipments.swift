//
//  Equipments.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/26/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Equipments
struct Equipments: Codable {
    let requerdEquipment: [RequerdEquipment]

    enum CodingKeys: String, CodingKey {
        case requerdEquipment = "RequerdEquipment"
    }
}

// MARK: - RequerdEquipment
struct RequerdEquipment: Codable {
    let id: Int
    let name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
