//
//  FurnitureVC+FurnitureViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension FurnitureVC: FurnitureViewDelegate{
    
    func ShowProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithTruckTypes(_ result: TruckeTypes) {
        self.truckTypes = result.truckCarTypes
        self.registerCollectionView()
        self.carsTypesCollectionView.reloadData()
    }
    
    func didFailFetchTruckTypes() {
        
    }
    
    func didCompleteWithTrucksResults(_ result: TrucksResult) {
        self.trucksData = result.data
      //  self.specialCarsTableView.isHidden = false
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
//        self.loadTableView()
//        self.specialCarsTableView.reloadData()
//        UIView.animate(withDuration: 0.5) {
//            self.tableViewHeight.constant = CGFloat((self.trucksData?.count)! * 60 + 15)
//            self.view.layoutIfNeeded()
//        }
    }
    
    func didFailFethTrucksResult() {
        self.showAlert(title: "", message: "No near by cars found")
    }
    
    func didCompleteWithDistance(_ result: Distance) {
        UserDefaults.init().setValue(result.cost, forKey: "trip_total")
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
//        self.driverName.text = " " + (driver.drivers.name ?? "")
//        self.driverImage.sd_setImage(with: URL(string: driver.drivers.hasImage ?? ""))
//      //  self.carImage.sd_setImage(with: URL(string: driver.drivers.myCar.first!.image))
//        self.carNumber.text = driver.drivers.myCar?.first?.carNumber
//        self.callDriver.onTap {
//            TripsServices.callDriver(phoneNumber: driver.drivers.phone ?? "")
//        }
//        self.driverView.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.driverView.alpha = 1
//        }
    }
    
    func didFailConfirmRide() {
    }
    
}
