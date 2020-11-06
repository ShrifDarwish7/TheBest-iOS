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
    func didCompleteWithDistanceFromAPI(_ distance: Distance)
    func didCompleteWithErrorDistanceFromAPI()
    func didCompleteConfirmRide()
    func didFailConfirmRide()
    func didCompleteCancelRide()
    func didFailCancelRide()
    func didAcceptRideFromDriver(_ driver: Driver?)
}

extension TaxiOrderViewDelegate{
    
    func showSVProgress(){}
    func dismissSVProgress(){}
    func didCompleteWith(_ taxies: Taxi){}
    func didCompleteWithError(){}
    func didCompleteWithAddressFromGoogleMaps(_ address: String){}
    func didFailWithErrorAddressFromGoogleMaps(){}
    func didCompleteWithDirectionFromGoogleMaps(_ polyline: GMSPolyline){}
    func didFailWithErrorDirectionFromGoogleMaps(){}
    func didCompleteWithDistanceFromAPI(_ distance: Distance){}
    func didCompleteWithErrorDistanceFromAPI(){}
    func didCompleteConfirmRide(){}
    func didFailConfirmRide(){}
    func didCompleteCancelRide(){}
    func didFailCancelRide(){}
    func didAcceptRideFromDriver(_ driver: Driver?){}
    
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
    
    func getDistance(){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.getDistance { (distance) in
            self.taxiOrderViewDelegate?.dismissSVProgress()
            
            if let _ = distance{
                self.taxiOrderViewDelegate?.didCompleteWithDistanceFromAPI(distance!)
            }else{
                self.taxiOrderViewDelegate?.didCompleteWithErrorDistanceFromAPI()
            }
        }
    }
    
    func confirmRide(){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.confirmRide { (completed) in
            self.taxiOrderViewDelegate?.dismissSVProgress()
            if completed{
                self.taxiOrderViewDelegate?.didCompleteConfirmRide()
            }else{
                self.taxiOrderViewDelegate?.didFailConfirmRide()
            }
        }
        
    }
    
    func cancelRide(){
        
        self.taxiOrderViewDelegate?.showSVProgress()
        
        TripsServices.cancelRide { (cancelled) in
            self.taxiOrderViewDelegate?.dismissSVProgress()
            if cancelled{
                self.taxiOrderViewDelegate?.didCompleteCancelRide()
            }else{
                self.taxiOrderViewDelegate?.didFailCancelRide()
            }
        }
        
    }
    
    func getDriverBy(id: Int){
        //self.taxiOrderViewDelegate?.showSVProgress()
        TripsServices.getDriverBy(id: id) { (response) in
           // self.taxiOrderViewDelegate?.dismissSVProgress()
            if let _ = response{
                self.taxiOrderViewDelegate?.didAcceptRideFromDriver(response?.driver)
            }else{
                self.taxiOrderViewDelegate?.didAcceptRideFromDriver(nil)
            }
        }
    }
    
}
