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
        self.brandTF.text = self.cars?.cars.data.first?.name
        self.brandIcon.sd_setImage(with: URL(string: self.cars?.cars.data.first?.image ?? ""))
    }
    
    func didFailFetchCars() {
        
    }
    
    func didCompleteWithNearesrCars(_ result: NearestCars) {
        
    }
    
    func didFailFethNearesrCars() {
        
    }
    
    func didCompleteWithDistance(_ result: Distance) {
        
    }
    
    func didFailFetchDistance() {
        
    }
    
    
}
