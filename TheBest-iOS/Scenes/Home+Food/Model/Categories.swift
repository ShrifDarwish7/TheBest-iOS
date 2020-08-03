//
//  Categories.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let mainCategories: [MainCategory]

    enum CodingKeys: String, CodingKey {
        case mainCategories = "MainCategories"
    }
}

// MARK: - MainCategory
struct MainCategory: Codable {
    let id: Int
    let name: String
    let image: String
    let createdAt, updatedAt: String
    let typeId: Int?
    
    var selected: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case typeId = "type_id"
        case selected
    }
}
