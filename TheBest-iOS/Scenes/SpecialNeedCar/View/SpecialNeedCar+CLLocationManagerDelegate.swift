//
//  SpecialNeedCar+CLLocationManagerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

extension SpecialNeedCarVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
      
      camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
      mapView.camera = camera!
      
      marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
      marker.map = mapView
      
      taxiOrderPresenter?.getAddressFromGoogleMapsApi()
      locationManager.stopUpdatingLocation()
      
    }
    
}
