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
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Confirm ride", for: .normal)
        self.confirmBtn.backgroundColor = UIColor(named: "SpecialNeedCarColor")
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
        print("didFailWithErrorAddressFromGoogleMaps")
    }
    
    func didCompleteWithDistanceFromAPI(_ distance: Distance) {
     //   self.distance.text = "\(distance.distance)"
     //   self.tripFees.text = "\(distance.cost)"
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Confirm ride", for: .normal)
//        UIView.animate(withDuration: 0.5) {
//            self.tripInfoStackHeight.constant = 150
//            self.view.layoutIfNeeded()
//        }
    
    }
    
    func didCompleteConfirmRide(_ driver: Drivers) {
        self.driverImageView.sd_setImage(with: URL(string: driver.drivers.image)!)
        self.driverName.text = " " + driver.drivers.name
        self.carNumber.text = driver.drivers.myCar.first?.carNumber
        self.driverView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.driverView.alpha = 1
        }
    }
    
}
