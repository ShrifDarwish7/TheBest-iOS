//
//  CarRentVC+CarsRentViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/31/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension CarRentVC: CarsRentViewDelegate{
    func ShowProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithCars(_ result: Cars) {
        self.cars = result
        self.loadBrandPicker()
        self.loadModelPicker()
        self.loadYearPicker()
        self.brandTF.text = self.cars?.cars.data.first?.name
        self.brandIcon.sd_setImage(with: URL(string: self.cars?.cars.data.first?.hasImage ?? ""))
    }
    
    func didFailFetchCars() {
        
    }
    
    func didCompleteWithNearesrCars(_ result: NearestCars) {
        
        for i in 0...(result.data.count)-1{
            if let lat = result.data[i].lat,
               let lng = result.data[i].lng{
                let marker = GMSMarker()
                marker.icon = Images.imageWithImage(image: UIImage(named: "car-marker")!, scaledToSize: CGSize(width: 40, height: 55))
                marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                marker.map = mapView
                                    
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.confirmBtn.isHidden = false
            self.view.layoutIfNeeded()
        }
        
       // self.nearestCars = result.data
        //self.nearestTableView.isHidden = false
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Get distance", for: .normal)
      //  self.loadTableView()
        //self.nearestTableView.reloadData()
//        UIView.animate(withDuration: 0.5) {
//            self.nearestTableViewHeight.constant = CGFloat((self.nearestCars?.count)! * 60 + 60)
//            self.view.layoutIfNeeded()
//        }
        
    }
    
    func didFailFethNearesrCars() {
        self.showAlert(title: "", message: "No near by cars found")
    }
    
    func didCompleteWithDistance(_ result: Distance) {
        self.startRide.tag = 1
        UserDefaults.init().setValue(result.cost, forKey: "trip_total")
        self.startRide.setTitle("Confirm ride", for: .normal)
        self.distanceLbl.text = "\(result.distance )" + " Km"
        self.costLbl.text = "\(result.cost )" + " KWD"
        UIView.animate(withDuration: 0.5) {
            self.fromToStack.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    func didFailFetchDistance() {
        
        
    }
    
    func didCompleteConfirmRide() {
        loadingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.loadingView.alpha = 1
        }
        self.lottieContainerView.addLottieLoader()
    }
    
    func didFailConfirmRide() {
        
    }
    
}
