//
//  Markets.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Markets
struct Markets: Codable {
    let code: Int
    let markets: [Item]

    enum CodingKeys: String, CodingKey {
        case code
        case markets = "Markets"
    }
}

//// MARK: - Market
//struct Market: Codable {
//    let id: Int
//    let name: String
//    let image: String
//    let marketDescription, address: String
//    let categoryID, deliveryPrice: Int
//    let lat, lng: Double
//    let typeID: Int
//    let country, government, district, createdAt: String
//    let updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, image
//        case marketDescription = "description"
//        case address
//        case categoryID = "category_id"
//        case deliveryPrice = "delivery_price"
//        case lat, lng
//        case typeID = "type_id"
//        case country, government, district
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
