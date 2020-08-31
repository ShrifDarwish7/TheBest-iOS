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
