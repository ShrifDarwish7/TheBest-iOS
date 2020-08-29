//
//  FurnitureVC+GMSAutocompleteViewControllerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

extension FurnitureVC: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if viewController === self.fromAutoCompleteController{
            
            SharedData.userLat = place.coordinate.latitude
            SharedData.userLng = place.coordinate.longitude
            self.mapView.clear()
            self.putMyMarker()
            self.fromLbl.text = place.formattedAddress ?? ""
           // resetConfirmBtn()
            
        }else{
            
            self.mapView.clear()
            self.putMyMarker()
            self.toLbl.text = place.formattedAddress ?? ""
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
            marker.map = mapView
            
            SharedData.userDestinationLat = place.coordinate.latitude
            SharedData.userDestinationLng = place.coordinate.longitude
                        
//            self.confirmBtn.setTitle("Confirm ride", for: .normal)
//            self.confirmBtn.backgroundColor = UIColor(named: "SpecialNeedCarColor")
            
            UIView.animate(withDuration: 0.5) {
                self.startRide.isHidden = false
                self.view.layoutIfNeeded()
            }
            
        }
        
      dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      // TODO: handle the error.
      print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
