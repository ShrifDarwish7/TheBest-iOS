//
//  SubTypes.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 27/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - SubTypes
struct SubTypes: Codable {
    let subscriptionsTypes: [SubscriptionsType]

    enum CodingKeys: String, CodingKey {
        case subscriptionsTypes = "SubscriptionsTypes"
    }
}

// MARK: - SubscriptionsType
struct SubscriptionsType: Codable {
    let id: Int
    let name, image: String?
    let type: Int?
    let createdAt, updatedAt: String?
    let hasImage: String?
    
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hasImage = "has_image"
    }
}
