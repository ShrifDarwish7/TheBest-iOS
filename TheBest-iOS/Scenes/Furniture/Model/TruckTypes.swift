//
//  TruckTypes.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - TruckeTypes
struct TruckeTypes: Codable {
    let truckCarTypes: [TruckCarType]

    enum CodingKeys: String, CodingKey {
        case truckCarTypes = "TruckCarTypes"
    }
}

// MARK: - TruckCarType
struct TruckCarType: Codable {
    let id: Int
    let name: String
    let image: String
    let type: Int
    let createdAt, updatedAt: String
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
