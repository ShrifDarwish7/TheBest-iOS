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
    
    func getSpecialCarWith(id: String){
        self.specialNeedCarViewDelegate?.showSVProgress()
        SpecialCarsServices.getSpecialCar(id: id) { (specialCarResult) in
            self.specialNeedCarViewDelegate?.dismissSVProgress()
            if let _ = specialCarResult{
                self.specialNeedCarViewDelegate?.didCompleteWithSpecialCarResult(specialCarResult!)
            }else{
                self.specialNeedCarViewDelegate?.didFailFetchSpecialCarsResult()
            }
        }
    }
    
}
