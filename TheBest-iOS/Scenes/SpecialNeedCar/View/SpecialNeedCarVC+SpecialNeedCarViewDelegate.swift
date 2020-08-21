//
//  SpecialNeedCarVC+SpecialNeedCarViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension SpecialNeedCarVC: SpecialNeedCarViewDelegate{
    
    func didCompleteWithSpecialCars(_ result: SpecialCars) {
        self.carsTypes = result.specialCars
        self.registerCollectionView()
        self.carsTypesCollectionView.reloadData()
    }
    
    func didFailFetchSpecialCars() {
       
    }
    
    func didCompleteWithSpecialCarResult(_ result: SpecialCarResult) {
        UIView.animate(withDuration: 0.5) {
            self.tripInfoStackHeight.constant = 100
            self.fromToStack.isHidden = false
            self.view.layoutIfNeeded()
        }
        self.distanceLbl.text = "\(result.data.first?.distance ?? 0)" + " Km"
        self.costLbl.text = "\(result.data.first?.cost ?? 0)" + " KWD"
        self.confirmBtn.tag = 1
        self.confirmBtn.setTitle("Cancel order", for: .normal)
        self.confirmBtn.backgroundColor = UIColor.red
    }
    
    func didFailFetchSpecialCarsResult() {
        UIView.animate(withDuration: 0.5) {
            self.tripInfoStackHeight.constant = 0
            self.fromToStack.isHidden = true
            self.view.layoutIfNeeded()
        }
        self.showAlert(title: "", message: "No near by cars found")
    }
    
}
