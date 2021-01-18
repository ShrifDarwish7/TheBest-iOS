//
//  RoadServicesCategoriesResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct RoadServicesCategoriesResponse: Codable {
    let categories: [MainCategory]

    enum CodingKeys: String, CodingKey {
        case categories = "RoadService"
    }
}
