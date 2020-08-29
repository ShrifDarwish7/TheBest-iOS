//
//  TrucksResult.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - TrucksResult
struct TrucksResult: Codable {
    let data: [TruckData]
}

// MARK: - Datum
struct TruckData: Codable {
    let id: Int
    let image: String
    let lat, lng, distance: Double
    let cost: Int
    var selected: Bool?
}
