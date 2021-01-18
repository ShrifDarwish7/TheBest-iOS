//
//  MyProfileResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 09/01/2021.
//  Copyright © 2021 Sherif Darwish. All rights reserved.
//

import Foundation

struct MyProfileResponse: Codable {
    let status: Int
    let myProfile: UserModel
    let currnetTrip: Trip

    enum CodingKeys: String, CodingKey {
        case status
        case myProfile = "MyProfile"
        case currnetTrip = "CurrnetTrip"
    }
}
