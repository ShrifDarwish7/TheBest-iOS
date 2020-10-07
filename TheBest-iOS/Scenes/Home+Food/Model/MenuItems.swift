//
//  MenuItems.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/25/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - MenuIems
struct MenuIems: Codable {
    let restaurantMenu: [RestaurantMenuItem]

    enum CodingKeys: String, CodingKey {
        case restaurantMenu = "RestaurantMenu"
    }
}

// MARK: - RestaurantMenu
struct RestaurantMenuItem: Codable {
    let id: Int
    let name: String
    let price: String
    let hasImage: String?
    let restaurantMenuDescription: String
    let restaurantID: Int
    let menuCategoryID: String
    let createdAt, updatedAt, attributeTitle: String
    var itemattributes: [ItemAttribute]

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case hasImage = "has_image"
        case restaurantMenuDescription = "description"
        case restaurantID = "restaurant_id"
        case menuCategoryID = "menu_category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case itemattributes
        case attributeTitle = "attribute_title"
    }
}

// MARK: - Itemattribute
struct ItemAttribute: Codable {
    let id: Int
    let name: String
    let price, itemID: Int
    let createdAt, updatedAt: String
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case itemID = "item_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
