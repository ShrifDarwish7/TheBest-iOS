//
//  Distance.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Distance
struct Distance: Codable {
    let distance, cost, est: Double

    enum CodingKeys: String, CodingKey {
        case distance
        case cost = "Cost"
        case est
    }
}
