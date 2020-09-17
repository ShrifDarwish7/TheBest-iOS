//
//  LastTrips.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - LastTrips
struct LastTrips: Codable {
    let trips: [Trip]

    enum CodingKeys: String, CodingKey {
        case trips = "Trips"
    }
}

// MARK: - Trip
struct Trip: Codable {
    let id, clientID, driverID: Int
    let fromLat, fromLng, toLat, toLng: Double
    let paymentMethod: String
    let total: Int
    let status, addressFrom, addressTo: String?
    let rideType: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case fromLat = "from_lat"
        case fromLng = "from_lng"
        case toLat = "to_lat"
        case toLng = "to_lng"
        case paymentMethod = "payment_method"
        case total, status
        case addressFrom = "address_from"
        case addressTo = "address_to"
        case rideType = "ride_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
