//
//  MapVC+CLLocationManagerDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 08/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

extension MapVC: CLLocationManagerDelegate{
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }else{
            camera = GMSCameraPosition.camera(withLatitude: 29.3117 , longitude: 47.4818, zoom: 8)
            mapView.camera = camera!
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
        camera = GMSCameraPosition.camera(withLatitude: locValue.latitude , longitude: locValue.longitude, zoom: 19)
        mapView.camera = camera!
        locationManager.stopUpdatingLocation()
    }
    
}
