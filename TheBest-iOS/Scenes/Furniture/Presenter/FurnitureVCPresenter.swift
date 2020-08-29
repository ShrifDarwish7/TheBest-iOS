//
//  FurnitureVCPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol FurnitureViewDelegate {
    func ShowProgress()
    func dismissProgress()
    func didCompleteWithTruckTypes(_ result: TruckeTypes)
    func didFailFetchTruckTypes()
    func didCompleteWithTrucksResults(_ result: TrucksResult)
    func didFailFethTrucksResult()
    func didCompleteWithDistance(_ result: Distance)
    func didFailFetchDistance()
    func didCompleteConfirmRide(_ result: Drivers)
    func didFailConfirmRide()
}

class FurnitureVCPresenter{
    
    private var furnitureViewDelegate: FurnitureViewDelegate?
    
    init(furnitureViewDelegate: FurnitureViewDelegate) {
        self.furnitureViewDelegate = furnitureViewDelegate
    }
    
    func getTruckTypes(){
        self.furnitureViewDelegate?.ShowProgress()
        FurnitureServices.getTruckTypes { (result) in
            self.furnitureViewDelegate?.dismissProgress()
            if let _ = result{
                self.furnitureViewDelegate?.didCompleteWithTruckTypes(result!)
            }else{
                self.furnitureViewDelegate?.didFailFetchTruckTypes()
            }
        }
    }
    
    func getTruckResultsWith(id: String){
        self.furnitureViewDelegate?.ShowProgress()
        FurnitureServices.getTruck(id: id) { (result) in
            self.furnitureViewDelegate?.dismissProgress()
            if let _ = result{
                self.furnitureViewDelegate?.didCompleteWithTrucksResults(result!)
            }else{
                self.furnitureViewDelegate?.didFailFethTrucksResult()
            }
        }
    }
    
    func getDistance(driverId: String){
        self.furnitureViewDelegate?.ShowProgress()
        FurnitureServices.getDistance(driverId: driverId) { (distance) in
            self.furnitureViewDelegate?.dismissProgress()
            if let _ = distance{
                self.furnitureViewDelegate?.didCompleteWithDistance(distance!)
            }else{
                self.furnitureViewDelegate?.didFailFetchDistance()
            }
        }
    }
    
    func confirmRide(){
        self.furnitureViewDelegate?.ShowProgress()
        FurnitureServices.confirmRide { (driver) in
            self.furnitureViewDelegate?.dismissProgress()
            if let _ = driver{
                self.furnitureViewDelegate?.didCompleteConfirmRide(driver!)
            }else{
                self.furnitureViewDelegate?.didFailConfirmRide()
            }
        }
        
    }
    
}
