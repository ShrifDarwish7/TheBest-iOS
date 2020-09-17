//
//  NearestCars.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - NearestCars
struct NearestCars: Codable {
    let data: [NearestCar]
}

// MARK: - Datum
struct NearestCar: Codable {
    let id: Int
    let has_image: String
    let lat, lng, distance: Double
    let cost: Int
}
