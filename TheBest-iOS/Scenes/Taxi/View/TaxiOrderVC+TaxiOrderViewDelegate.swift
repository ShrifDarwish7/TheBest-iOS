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
            marker.map = self.mapView
            
        }
        
    }
    
    func didCompleteWithError() {
        
    }
    
    func didCompleteWithAddressFromGoogleMaps(_ address: GoogleMapsGeocodeAddress) {
        self.fromLbl.text = address.formattedAddress
    }
    
    func didFailWithErrorAddressFromGoogleMaps() {
        
    }
    
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline) {
        polyline.strokeColor = UIColor(named: "TaxiGoldColor")!
        polyline.map = self.mapView
    }
    
    func didFailWithErrorDirectionFromGoogleMaps() {
        
    }
    
    func didCompleteWithDistanceFromAPI(_ distance: Distance) {
        UserDefaults.init().setValue(distance.cost, forKey: "trip_total")
        self.distance.text = "\(distance.distance)"
        self.tripFees.text = "\(distance.cost)"
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Confirm ride", for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.tripInfoStackHeight.constant = 70
            self.view.layoutIfNeeded()
        }
    
    }
    
    func didCompleteWithErrorDistanceFromAPI() {
        print("didCompleteWithErrorDistanceFromAPI")
    }

    func didCompleteConfirmRide() {
       // lottie?.play()
        loadingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.loadingView.alpha = 1
        }
        self.lottieContainerView.addLottieLoader()
//        self.driverName.text = driver.drivers.name
//        self.driverImage.sd_setImage(with: URL(string: driver.drivers.hasImage ?? ""))
//        self.carImage.sd_setImage(with: URL(string: driver.drivers.myCar?.first!.hasImage ?? ""))
//        self.carNumber.text = driver.drivers.myCar?.first?.carNumber
//        self.callDriver.addTapGesture { (_) in
//            TripsServices.callDriver(phoneNumber: driver.drivers.phone ?? "")
//        }
//        self.driverView.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.driverView.alpha = 1
//        }
    }
    
    func didAcceptRideFromDriver(_ driver: Driver?) {
        SVProgressHUD.dismiss()
        if let _ = driver{
            self.driverName.text = driver?.name
            self.driverImage.sd_setImage(with: URL(string: driver?.hasImage ?? ""))
            self.carImage.sd_setImage(with: URL(string: driver?.myCar?.first!.hasImage ?? ""))
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
        }
    }
    
    func didFailConfirmRide() {
        print("didFailConfirmRide")
    }
    
    func didCompleteCancelRide() {
        self.loadReasonsCollection()
        self.cancelationView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.cancelationView.alpha = 1
        }
    }
    
    func didFailCancelRide() {
        print("didFailCancelRide")
        
    }
    
}
