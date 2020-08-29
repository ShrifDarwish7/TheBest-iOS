//
//  SpecialCarResult.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - GetSpecialCar
struct SpecialCarResult: Codable {
    let data: [SpecialCarData]
}

// MARK: - Datum
struct SpecialCarData: Codable {
    let id: Int
    let lat, lng, distance: Double
    let image: String
    let cost: Int
    var selected: Bool?
}
