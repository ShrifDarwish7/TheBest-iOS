//
//  UpdateResponse.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/18/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - UpdateResponse
struct UpdateResponse: Codable {
    let code: Int
    let message: String
    let item: UserModel
}
