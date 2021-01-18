//
//  SubscriptVC+SubscriptionViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 27/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SubscriptVC: SubscriptionViewDelegate{
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithTypes(_ data: [SubscriptionsType]?) {
        if let _ = data{
            self.carsTypes = data
            self.registerCollectionView()
        }
    }
    
    func didCompleteConfirmRide(_ error: Bool) {
        if !error{
            loadingView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.loadingView.alpha = 1
            }
            self.lottieContainerView.addLottieLoader()
        }
    }
    
    func didCompleteWithDistanceFromAPI(_ distance: Distance) {
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Confirm ride", for: .normal)
        self.distanceLbl.text = "\(distance.distance )" + " Km"
        self.costLbl.text = "\(distance.cost )" + " KWD"
        UserDefaults.init().setValue(distance.cost, forKey: "trip_total")
        UIView.animate(withDuration: 0.5) {
            self.distanceStack.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
}
