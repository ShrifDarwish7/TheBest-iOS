//
//  RoadServices+GMSMapViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

extension RoadServicesVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        
        self.mapView.clear()
        SharedData.userLat = marker.position.latitude
        SharedData.userLng = marker.position.longitude
        self.taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        self.putMyMarker()
                
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 65, height: 87))
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt = \(coordinate.latitude),\(coordinate.longitude)")
        mapView.clear()
        SharedData.userLat = coordinate.latitude
        SharedData.userLng = coordinate.longitude
        self.taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        let camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        let marker = GMSMarker()
        marker.isDraggable = true
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        DispatchQueue.main.async {
            self.mapView.animate(to: camera)
        }
        marker.map = mapView
        
    }
    
    func putMyMarker(){
        let camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        let marker = GMSMarker()
        marker.isDraggable = true
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        mapView.camera = camera
        marker.map = mapView
    }
    
}
