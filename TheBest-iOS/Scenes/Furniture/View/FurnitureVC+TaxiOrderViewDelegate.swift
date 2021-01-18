//
//  FurnitureVC+TaxiOrderViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GooglePlaces
import GoogleMaps

extension FurnitureVC: TaxiOrderViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithAddressFromGoogleMaps(_ address: GoogleMapsGeocodeAddress) {
        self.fromLbl.text = address.formattedAddress
    }
    
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline) {
        polyline.strokeColor = UIColor(named: "FurnitureColor")!
        polyline.map = self.mapView
        self.startRide.tag = 1
        self.startRide.setTitle("Start ride", for: .normal)
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
    }
    
    
}
