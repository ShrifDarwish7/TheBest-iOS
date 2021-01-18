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
    
    func didCompleteWithAddressFromGoogleMaps(_ address: GoogleMapsGeocodeAddress) {
        self.fromLbl.text = address.formattedAddress
    }
    
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline) {
        polyline.strokeColor = UIColor(named: "SpecialNeedCarColor")!
        polyline.map = self.mapView
        self.startRide.tag = 1
        self.startRide.setTitle("Start ride", for: .normal)
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
    }
    
    func didAcceptRideFromDriver(_ driver: Driver?) {
        SVProgressHUD.dismiss()
        self.driverName.text = driver?.name
        self.driverImage.sd_setImage(with: URL(string: driver?.hasImage ?? ""))
        //self.carImage.sd_setImage(with: URL(string: driver?.myCar?.first!.hasImage ?? ""))
        self.carNumber.text = driver?.myCar?.first?.carNumber
        self.callDriver.addTapGesture { (_) in
            TripsServices.callDriver(phoneNumber: driver?.phone ?? "")
        }
        self.driverView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.loadingView.alpha = 0
            self.driverView.alpha = 1
        }) { (_) in
            self.loadingView.isHidden = true
        }
        
        showAlert(title: "", message: "a7777aaaa")
        
    }
    
    
    
}
