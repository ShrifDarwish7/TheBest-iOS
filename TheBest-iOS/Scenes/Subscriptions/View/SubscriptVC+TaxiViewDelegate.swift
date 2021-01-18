//
//  SubscriptVC+TaxiViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 20/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps
import SVProgressHUD

extension SubscriptVC: TaxiOrderViewDelegate{
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithAddressFromGoogleMaps(_ address: GoogleMapsGeocodeAddress) {
        self.addressTF.text = address.formattedAddress
    }
    
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline) {
        polyline.strokeColor = UIColor(named: "FurnitureColor")!
        polyline.map = self.mapView
     //   self.startRide.tag = 1
       // self.startRide.setTitle("Start ride", for: .normal)
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
    }
    
}
