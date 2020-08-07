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
    let image: String
    let restaurantMenuDescription: String
    let restaurantID, menuCategoryID: Int
    let createdAt, updatedAt: String
    let itemattributes: [ItemAttribute]

    enum CodingKeys: String, CodingKey {
        case id, name, price, image
        case restaurantMenuDescription = "description"
        case restaurantID = "restaurant_id"
        case menuCategoryID = "menu_category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case itemattributes
    }
}

// MARK: - Itemattribute
struct ItemAttribute: Codable {
    let id: Int
    let name: String
    let price, itemID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case itemID = "item_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
