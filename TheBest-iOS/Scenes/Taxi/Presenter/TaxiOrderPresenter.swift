//
//  TaxiOrderPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/1/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol TaxiOrderViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didCompleteWith(_ taxies: Taxi)
    func didCompleteWithError()
    
}

class TaxiOrderPresenter{
    
    var taxiOrderViewDelegate: TaxiOrderViewDelegate?
    
    init(taxiOrderViewDelegate: TaxiOrderViewDelegate) {
        self.taxiOrderViewDelegate = taxiOrderViewDelegate
    }
    
    func getNearByTaxies(){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.getNearByTaxies { (taxies) in
            
            self.taxiOrderViewDelegate?.dismissSVProgress()
            
            if let taxies = taxies{
                self.taxiOrderViewDelegate?.didCompleteWith(taxies)
            }else{
                self.taxiOrderViewDelegate?.didCompleteWithError()
            }
            
        }
        
    }
    
}
