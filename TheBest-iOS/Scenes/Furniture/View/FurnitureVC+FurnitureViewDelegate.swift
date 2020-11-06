//
//  FurnitureVC+FurnitureViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        self.specialCarsTableView.isHidden = false
        self.confirmBtn.isHidden = false
        self.loadTableView()
        self.specialCarsTableView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.tableViewHeight.constant = CGFloat((self.trucksData?.count)! * 60 + 15)
            self.view.layoutIfNeeded()
        }
    }
    
    func didFailFethTrucksResult() {
        self.showAlert(title: "", message: "No near by cars found")
    }
    
    func didCompleteWithDistance(_ result: Distance) {
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
