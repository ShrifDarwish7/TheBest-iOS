//
//  RoadServicesOptionsResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - RoadServicesOptions
struct RoadServicesOptions: Codable {
    let roadServOptions: [RoadServOption]

    enum CodingKeys: String, CodingKey {
        case roadServOptions = "RoadServOptions"
    }
}

// MARK: - RoadServOption
struct RoadServOption: Codable {
    let id: Int
    let name: String
    let image: String?
    let roadServicesID: Int
    let price, createdAt, updatedAt, description: String
    
    var checked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case roadServicesID = "road_services_id"
        case price
        case image = "has_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
