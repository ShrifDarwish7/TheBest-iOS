//
//  CarRentVC+CarsRentViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/31/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        
        self.nearestCars = result.data
        self.nearestTableView.isHidden = false
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Get distance", for: .normal)
        self.loadTableView()
        self.nearestTableView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.nearestTableViewHeight.constant = CGFloat((self.nearestCars?.count)! * 60 + 60)
            self.view.layoutIfNeeded()
        }
        
    }
    
    func didFailFethNearesrCars() {
        self.showAlert(title: "", message: "No near by cars found")
    }
    
    func didCompleteWithDistance(_ result: Distance) {
        self.startRide.tag = 1
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
    
    func didCompleteConfirmRide(_ driver: Drivers) {
        self.driverName.text = " " + (driver.drivers.name ?? "")
        self.driverImage.sd_setImage(with: URL(string: driver.drivers.hasImage ?? ""))
        //  self.carImage.sd_setImage(with: URL(string: driver.drivers.myCar.first!.image))
        self.carNumber.text = driver.drivers.myCar?.first?.carNumber
          self.callDriver.onTap {
            TripsServices.callDriver(phoneNumber: driver.drivers.phone ?? "")
          }
          self.driverView.isHidden = false
          UIView.animate(withDuration: 0.5) {
              self.driverView.alpha = 1
          }
    }
    
    func didFailConfirmRide() {
        
    }
    
}
