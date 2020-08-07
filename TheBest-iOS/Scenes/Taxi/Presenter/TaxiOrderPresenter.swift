//
//  TaxiOrderPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/1/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

protocol TaxiOrderViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didCompleteWith(_ taxies: Taxi)
    func didCompleteWithError()
    func didCompleteWithAddressFromGoogleMaps(_ address: String)
    func didFailWithErrorAddressFromGoogleMaps()
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline)
    func didFailWithErrorDirectionFromGoogleMaps()
    
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
    
    func getAddressFromGoogleMapsApi(){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.getAddressFromGoogleMapsAPI(location: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)") { (address) in
            
            self.taxiOrderViewDelegate?.dismissSVProgress()
            
            if let _ = address{
                self.taxiOrderViewDelegate?.didCompleteWithAddressFromGoogleMaps(address ?? "")
            }else{
                self.taxiOrderViewDelegate?.didFailWithErrorAddressFromGoogleMaps()
            }
            print("here address",address ?? "")
        }
    }
    
    func getDirectionFromGoogleMaps(origin: String, destination: String){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.getDirectionFromGoogleMapsAPI(origin: origin, destination: destination) { (polyline) in
            
            self.taxiOrderViewDelegate?.dismissSVProgress()
            
            if let _ = polyline{
                self.taxiOrderViewDelegate?.didCompleteWithDirectionFromGoogleMaps(polyline!)
            }else{
                self.taxiOrderViewDelegate?.didFailWithErrorDirectionFromGoogleMaps()
            }
            
        }
        
    }
    
}
