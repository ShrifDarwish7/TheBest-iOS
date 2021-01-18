//
//  SubscriptionPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 27/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol SubscriptionViewDelegate {
    func showProgress()
    func dismissProgress()
    func didCompleteWithTypes(_ data: [SubscriptionsType]?)
    func didCompleteConfirmRide(_ error: Bool)
    func didCompleteWithDistanceFromAPI(_ distance: Distance)
    func didCompleteWithErrorDistanceFromAPI()
}

class SubscriptionPresenter{
    var viewDelegate: SubscriptionViewDelegate?
    init(viewDelegate: SubscriptionViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func getTypes(){
        self.viewDelegate?.showProgress()
        SubscriptionServices.getTypes { (result) in
            self.viewDelegate?.dismissProgress()
            if let _ = result{
                self.viewDelegate?.didCompleteWithTypes(result?.subscriptionsTypes)
            }else{
                self.viewDelegate?.didCompleteWithTypes(nil)
            }
        }
    }
    
    func getDistance(_ parameters: [String:Any]){
        
        self.viewDelegate?.showProgress()
        
        SubscriptionServices.getDistance(parameters) { (distance) in
            self.viewDelegate?.dismissProgress()
            if let _ = distance{
                self.viewDelegate?.didCompleteWithDistanceFromAPI(distance!)
            }else{
                self.viewDelegate?.didCompleteWithErrorDistanceFromAPI()
            }
        }
    }
    
    func confirmRide(_ formData: [String: Any]){
        self.viewDelegate?.showProgress()
        SubscriptionServices.confirmRide(formData) { (done) in
            self.viewDelegate?.dismissProgress()
            if done{
                self.viewDelegate?.didCompleteConfirmRide(false)
            }else{
                self.viewDelegate?.didCompleteConfirmRide(true)
            }
        }
    }
}
