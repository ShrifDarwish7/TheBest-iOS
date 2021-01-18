//
//  CarRentPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol CarsRentViewDelegate {
    func ShowProgress()
    func dismissProgress()
    func didCompleteWithCars(_ result: Cars)
    func didFailFetchCars()
    func didCompleteWithNearesrCars(_ result: NearestCars)
    func didFailFethNearesrCars()
    func didCompleteWithDistance(_ result: Distance)
    func didFailFetchDistance()
    func didCompleteConfirmRide()
    func didFailConfirmRide()
}

class CarsRentPresenter{
    
    private var carsRentViewDelegate: CarsRentViewDelegate?
    
    init(carsRentViewDelegate: CarsRentViewDelegate) {
        self.carsRentViewDelegate = carsRentViewDelegate
    }
    
    func getCars(){
        self.carsRentViewDelegate?.ShowProgress()
        CarRentServices.getCars { (result) in
            self.carsRentViewDelegate?.dismissProgress()
            if let _ = result{
                self.carsRentViewDelegate?.didCompleteWithCars(result!)
            }else{
                self.carsRentViewDelegate?.didFailFetchCars()
            }
        }
    }
    
    func getNearestCarsWith(car_model: String, car_list: String){
        self.carsRentViewDelegate?.ShowProgress()
        CarRentServices.getNearestCars(car_model: car_model, car_list: car_list) { (result) in
            self.carsRentViewDelegate?.dismissProgress()
            if let _ = result{
                self.carsRentViewDelegate?.didCompleteWithNearesrCars(result!)
            }else{
                self.carsRentViewDelegate?.didFailFethNearesrCars()
            }
                
        }
    }
    
    func getDistance(_ parameters: [String:Any]){
        self.carsRentViewDelegate?.ShowProgress()
        CarRentServices.getDistance(parameters) { (distance) in
            self.carsRentViewDelegate?.dismissProgress()
            if let _ = distance{
                self.carsRentViewDelegate?.didCompleteWithDistance(distance!)
            }else{
                self.carsRentViewDelegate?.didFailFetchDistance()
            }
        }
    }
    
    func confirmRide(_ parameters: [String:Any]){
        self.carsRentViewDelegate?.ShowProgress()
        CarRentServices.confirmRide(parameters) { (done) in
            self.carsRentViewDelegate?.dismissProgress()
            if done{
                self.carsRentViewDelegate?.didCompleteConfirmRide()
            }else{
                self.carsRentViewDelegate?.didFailConfirmRide()
            }
        }
    }
}
