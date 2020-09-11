//
//  FoodOrdersHistory.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct FoodOrdersHistory: Codable {
    let data: [FoodOrder]
}

struct FoodOrder: Codable {
    let id: Int
    let username: String
    let userID: Int
    let lat, lng: Double
    let comment, address, phone, total: String?
    let orderItems: [FoodOrderItem]?
    let status, orderDate: String

    enum CodingKeys: String, CodingKey {
        case id, username
        case userID = "user_id"
        case lat, lng, comment, address, phone, total
        case orderItems = "order items"
        case status
        case orderDate = "order date"
    }
}

struct FoodOrderItem: Codable {
    let id, itemID: Int
    let placeID: Int?
    let orderID, catID, variationID: Int?
    let count: Int?
    let itemName: String
    let restaurantName, restaurantAddress, restaurantImage: String?
    let variationName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case placeID = "place_id"
        case orderID = "order_id"
        case catID = "cat_id"
        case count
        case variationID = "variation_id"
        case itemName = "Item Name"
        case restaurantName = "Restaurant Name"
        case restaurantAddress = "Restaurant address"
        case restaurantImage = "Restaurant image"
        case variationName = "Variation Name"
    }
}
