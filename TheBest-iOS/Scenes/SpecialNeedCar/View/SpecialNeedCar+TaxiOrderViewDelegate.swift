//
//  SpecialNeedCar+TaxiOrderViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GooglePlaces
import GoogleMaps

extension SpecialNeedCarVC: TaxiOrderViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithAddressFromGoogleMaps(_ address: String) {
        self.fromLbl.text = address
    }
    
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline) {
        polyline.strokeColor = UIColor(named: "SpecialNeedCarColor")!
        polyline.map = self.mapView
        self.startRide.tag = 1
        self.startRide.setTitle("Start ride", for: .normal)
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
    }
    
    
}
