//
//  SpecialNeedCarVC+SpecialNeedCarViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension SpecialNeedCarVC: SpecialNeedCarViewDelegate{
    
    func didCompleteWithSpecialCars(_ result: SpecialCars) {
        self.carsTypes = result.specialCars
        self.registerCollectionView()
        self.carsTypesCollectionView.reloadData()
    }
    
    func didFailFetchSpecialCars() {
       
    }
    
    func didCompleteWithSpecialCarResult(_ result: SpecialCarResult) {
       // self.specialCarData = result.data
        //self.specialCarsTableView.isHidden = false
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
       // self.loadTableView()
      //  self.specialCarsTableView.reloadData()
//        UIView.animate(withDuration: 0.5) {
//            self.tableViewHeight.constant = CGFloat((self.specialCarData?.count)! * 60 + 15)
//            self.view.layoutIfNeeded()
//        }
//        UIView.animate(withDuration: 0.5) {
//            self.tripInfoStackHeight.constant = 100
//            self.fromToStack.isHidden = false
//            self.view.layoutIfNeeded()
//        }
//        self.distanceLbl.text = "\(result.data.first?.distance ?? 0)" + " Km"
//        self.costLbl.text = "\(result.data.first?.cost ?? 0)" + " KWD"
//        self.confirmBtn.tag = 1
//        self.confirmBtn.setTitle("Cancel order", for: .normal)
//        self.confirmBtn.backgroundColor = UIColor.red
    }
    
    func didFailFetchSpecialCarsResult() {
//        UIView.animate(withDuration: 0.5) {
//            self.tripInfoStackHeight.constant = 0
//            self.fromToStack.isHidden = true
//            self.view.layoutIfNeeded()
//        }
        self.showAlert(title: "", message: "No near by cars found")
    }
    
    func didCompleteWithEquipments(_ result: Equipments) {
        self.equipments = result.requerdEquipment
        loadEquipmentsPicker()
        if !self.equipments!.isEmpty{
            UIView.animate(withDuration: 0.5) {
                self.equipmentsStack.isHidden = false
            }
        }
    }
    
    func didFailFetchEquipments() {
        UIView.animate(withDuration: 0.5) {
            self.equipmentsStack.isHidden = true
        }
    }
    
    func didCompleteWithDistance(_ result: Distance) {
        UserDefaults.init().setValue(result.cost, forKey: "trip_total")
        self.distanceLbl.text = "\(result.distance )" + " Km"
        self.costLbl.text = "\(result.cost )" + " KWT"
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
