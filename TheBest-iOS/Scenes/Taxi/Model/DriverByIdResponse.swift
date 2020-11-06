//
//  DriverByIdResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 11/5/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - DriverByIDResponse
struct DriverByIDResponse: Codable {
    let status: String
    let driver: Driver

    enum CodingKeys: String, CodingKey {
        case status
        case driver = "Driver"
    }
}
