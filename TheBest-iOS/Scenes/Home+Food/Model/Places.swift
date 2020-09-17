//
//  Places.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Places
struct Places: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let name: String
    let image: String
    let deliverPrice: Int
    let itemDescription, address: String
    let country, government, district: String
    let categoryID, typeID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "has_image"
        case itemDescription = "description"
        case address
        case country, government, district
        case categoryID = "category_id"
        case typeID = "type_id"
        case deliverPrice = "delivery_price"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
