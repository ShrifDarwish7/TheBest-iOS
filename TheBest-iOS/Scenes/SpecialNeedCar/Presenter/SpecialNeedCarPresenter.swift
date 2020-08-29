//
//  SpecialNeedCarPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol SpecialNeedCarViewDelegate {
    func showSVProgress()
    func dismissSVProgress()
    func didCompleteWithSpecialCars(_ result: SpecialCars)
    func didFailFetchSpecialCars()
    func didCompleteWithSpecialCarResult(_ result: SpecialCarResult)
    func didFailFetchSpecialCarsResult()
    func didCompleteWithEquipments(_ result: Equipments)
    func didFailFetchEquipments()
    func didCompleteWithDistance(_ result: Distance)
    func didFailFetchDistance()
    func didCompleteConfirmRide(_ result: Drivers)
    func didFailConfirmRide()
}

class SpecialNeedCarsPresenter{
    
    private var specialNeedCarViewDelegate: SpecialNeedCarViewDelegate?
    
    init(specialNeedCarViewDelegate: SpecialNeedCarViewDelegate) {
        self.specialNeedCarViewDelegate = specialNeedCarViewDelegate
    }
    
    func getSpecialCarsType(){
        self.specialNeedCarViewDelegate?.showSVProgress()
        SpecialCarsServices.getSpecialCarsType { (specialCars) in
            if let _ = specialCars{
                self.specialNeedCarViewDelegate?.dismissSVProgress()
                self.specialNeedCarViewDelegate?.didCompleteWithSpecialCars(specialCars!)
            }else{
                self.specialNeedCarViewDelegate?.didFailFetchSpecialCars()
            }
        }
    }
    
    func getSpecialCarWith(id: String, eq: String){
        self.specialNeedCarViewDelegate?.showSVProgress()
        SpecialCarsServices.getSpecialCar(id: id, eq: eq) { (specialCarResult) in
            self.specialNeedCarViewDelegate?.dismissSVProgress()
            if let _ = specialCarResult{
                self.specialNeedCarViewDelegate?.didCompleteWithSpecialCarResult(specialCarResult!)
            }else{
                self.specialNeedCarViewDelegate?.didFailFetchSpecialCarsResult()
            }
        }
    }
    
    func getEquipments(){
        SpecialCarsServices.getEquipments { (equipments) in
            if let _ = equipments{
                self.specialNeedCarViewDelegate?.didCompleteWithEquipments(equipments!)
            }else{
                self.specialNeedCarViewDelegate?.didFailFetchEquipments()
            }
        }
    }
    
    func getDistance(driverId: String){
        self.specialNeedCarViewDelegate?.showSVProgress()
        SpecialCarsServices.getDistance(driverId: driverId) { (distance) in
            self.specialNeedCarViewDelegate?.dismissSVProgress()
            if let _ = distance{
                self.specialNeedCarViewDelegate?.didCompleteWithDistance(distance!)
            }else{
                self.specialNeedCarViewDelegate?.didFailFetchDistance()
            }
        }
    }
    
    func confirmRide(){
        self.specialNeedCarViewDelegate?.showSVProgress()
        SpecialCarsServices.confirmRide { (driver) in
            self.specialNeedCarViewDelegate?.dismissSVProgress()
            if let _ = driver{
                self.specialNeedCarViewDelegate?.didCompleteConfirmRide(driver!)
            }else{
                self.specialNeedCarViewDelegate?.didFailConfirmRide()
            }
        }
        
    }
    
}
