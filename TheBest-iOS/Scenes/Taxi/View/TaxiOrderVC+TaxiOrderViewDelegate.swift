//
//  TaxiOrderVC+TaxiOrderViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension TaxiOrderVC: TaxiOrderViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWith(_ taxies: Taxi) {
        
        for taxi in taxies.data{
            
            let marker = GMSMarker()
            marker.icon = UIImage(named: "Taxi-Top-Yellow-icon")
            marker.position = CLLocationCoordinate2D(latitude: taxi.lat, longitude: taxi.lng)
            marker.map = mapView
            
        }
        
    }
    
    func didCompleteWithError() {
        
    }

}
