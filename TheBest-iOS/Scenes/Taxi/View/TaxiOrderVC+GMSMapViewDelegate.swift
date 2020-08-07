//
//  TaxiOrderVC+GMSMapViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/3/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

extension TaxiOrderVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        self.mapView.clear()
        SharedData.userLat = marker.position.latitude
        SharedData.userLng = marker.position.longitude
        self.taxiOrderPresenter?.getNearByTaxies()
        self.taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        self.putMyMarker()
        self.toLbl.text = "Select your destination "
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 65, height: 87))
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt = \(coordinate.latitude),\(coordinate.longitude)")
        mapView.clear()
        self.toLbl.text = "Select your destination "
        SharedData.userLat = coordinate.latitude
        SharedData.userLng = coordinate.longitude
        self.taxiOrderPresenter?.getNearByTaxies()
        self.taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        let camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        let marker = GMSMarker()
        marker.isDraggable = true
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        DispatchQueue.main.async {
            self.mapView.animate(to: camera)
        }
        marker.map = mapView
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
