//
//  TaxiOrderVC+ GMSAutocompleteViewControllerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GooglePlaces

extension TaxiOrderVC: GMSAutocompleteViewControllerDelegate{
  
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      print("Place name: \(place.name)")
      print("Place ID: \(place.placeID)")
      print("Place attributions: \(place.attributions)")
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
