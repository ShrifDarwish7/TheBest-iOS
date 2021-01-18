//
//  UserAddress.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 09/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

struct UserAddress: Codable {
    var coordinates: String
    var city: String
    var area: String
    var street: String
    var building: String
    var floor: String
    var flat: String
    var landmark: String
    var phone: String
}
