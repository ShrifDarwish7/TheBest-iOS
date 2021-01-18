//
//  MarketsVC+CLLocationManagerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation

extension MarketsVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
        switch self.type {
        case "markets":
            marketsVCPresenter?.getNearbyMarkets(categoryId: catReceivedId!)
        default:
            marketsVCPresenter?.getNearbyShera(categoryId: catReceivedId!)
        }
        locationManager.stopUpdatingLocation()
        
    }
    
}
