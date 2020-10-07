//
//  MenuCategories.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - MenuCategories
struct MenuCategories: Codable {
    var items: Items
}

// MARK: - Items
struct Items: Codable {
    let id: Int
    let name: String
    let hasImage: String?
    let itemsDescription, address: String
    let categoryID, typeID: Int
    let createdAt, updatedAt: String
    var menuesCategories: [MenuesCategory]

    enum CodingKeys: String, CodingKey {
        case id, name
        case hasImage = "has_image"
        case itemsDescription = "description"
        case address
        case categoryID = "category_id"
        case typeID = "type_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case menuesCategories = "menues_categories"
    }
}

// MARK: - MenuesCategory
struct MenuesCategory: Codable {
    let id: Int
    let name: String
    let restaurantID: Int
    let createdAt, updatedAt: String

    var selected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantID = "restaurant_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case selected
    }
}
