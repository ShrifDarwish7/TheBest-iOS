//
//  TaxiOrderVC+ GMSAutocompleteViewControllerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

extension TaxiOrderVC: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if viewController === self.fromAutoCompleteController{
            SharedData.userLat = place.coordinate.latitude
            SharedData.userLng = place.coordinate.longitude
            self.mapView.clear()
            self.putMyMarker()
            self.fromLbl.text = place.formattedAddress ?? ""
        }else{
            self.mapView.clear()
            self.putMyMarker()
            self.toLbl.text = place.formattedAddress ?? ""
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
            marker.map = mapView
            self.taxiOrderPresenter?.getDirectionFromGoogleMaps(origin: "\(place.coordinate.latitude),\(place.coordinate.longitude)", destination: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)")
            let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 12)
            DispatchQueue.main.async {
                self.mapView.animate(to: camera)
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
    
    func putMyMarker(){
        let camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        let marker = GMSMarker()
        marker.isDraggable = true
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        mapView.camera = camera
        marker.map = mapView
    }
    
}
