//
//  RoadServicesPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol RoadServicesViewDelegate {
    func showProgress()
    func dismissProgress()
    func didCompleteWithOptions(data: [RoadServOption]?)
    func didCompleteWithNearesrCars(_ result: NearestCars?)
    func didCompleteConfirmRide()
    func didCompleteWithDistance(_ result: Distance?)
}

class RoadServicesPresenter{
    
    private var roadServicesViewDelegate: RoadServicesViewDelegate?
    
    init(roadServicesViewDelegate: RoadServicesViewDelegate) {
        self.roadServicesViewDelegate = roadServicesViewDelegate
    }
    
    func getOptions(id: Int){
        self.roadServicesViewDelegate?.showProgress()
        RoadServices.getServices(id) { (response) in
            self.roadServicesViewDelegate?.dismissProgress()
            if let _ = response{
                self.roadServicesViewDelegate?.didCompleteWithOptions(data: response?.roadServOptions)
            }else{
                self.roadServicesViewDelegate?.didCompleteWithOptions(data: nil)
            }
        }
    }
    
    func getNearestCarsWith(){
        self.roadServicesViewDelegate?.showProgress()
        RoadServices.getNearestCars() { (result) in
            self.roadServicesViewDelegate?.dismissProgress()
            if let _ = result{
                self.roadServicesViewDelegate?.didCompleteWithNearesrCars(result!)
            }else{
                self.roadServicesViewDelegate?.didCompleteWithNearesrCars(nil)
            }
                
        }
    }
    
    func confirmRide(_ formData: [String:String]){
        self.roadServicesViewDelegate?.showProgress()
        RoadServices.confirmRide(formData) { (done) in
            self.roadServicesViewDelegate?.dismissProgress()
            if done{
                self.roadServicesViewDelegate?.didCompleteConfirmRide()
            }else{
               // self.roadServicesViewDelegate?.didCompleteConfirmRide(nil)
            }
        }
        
    }
    
    func getDistance(_ parameters: [String: Any]){
        self.roadServicesViewDelegate?.showProgress()
        RoadServices.getDistance(parameters: parameters) { (distance) in
            self.roadServicesViewDelegate?.dismissProgress()
            if let _ = distance{
                self.roadServicesViewDelegate?.didCompleteWithDistance(distance!)
            }else{
                self.roadServicesViewDelegate?.didCompleteWithDistance(nil)
            }
        }
    }
    
}
