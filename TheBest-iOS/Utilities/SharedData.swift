//
//  SharedData.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class SharedData{
    
    static var phone: String?
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let goolgeApiKey = "AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE"
    static var userLat: CLLocationDegrees?
    static var userLng: CLLocationDegrees?
    static var userDestinationLat: CLLocationDegrees?
    static var userDestinationLng: CLLocationDegrees?
    static let headers = [
        "Authorization": "Bearer \(AuthServices.instance.user.accessToken)",
        "Accept": "application/json"
    ]
    
}
