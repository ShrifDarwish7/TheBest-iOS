//
//  PlaceOrderResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 11/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct PlaceOrderResponse: Codable {
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let itemID: String?
    let placeID: Int?
    let count, attributeBody, attributeBodyTwo, attributeBodyThree: String?
    let additional: String?
    let orderID: Int?

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case placeID = "place_id"
        case count
        case attributeBody = "attribute_body"
        case attributeBodyTwo = "attribute_body_two"
        case attributeBodyThree = "attribute_body_three"
        case additional
        case orderID = "order_id"
    }
}
