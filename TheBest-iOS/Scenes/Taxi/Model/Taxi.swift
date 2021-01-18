//
//  Taxi.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/1/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Taxi
struct Taxi: Codable {
    let data: [TaxiData]
}

// MARK: - Datum
struct TaxiData: Codable {
    let id: Int
    let lat, lng, distance: Double
    let cost: Int
}
