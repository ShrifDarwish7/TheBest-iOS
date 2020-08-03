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
        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
        SharedData.userLat = marker.position.latitude
        SharedData.userLng = marker.position.longitude
        self.taxiOrderPresenter?.getNearByTaxies()
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 65, height: 87))
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt = \(coordinate.latitude),\(coordinate.longitude)")
        mapView.clear()
        SharedData.userLat = coordinate.latitude
        SharedData.userLng = coordinate.longitude
        self.taxiOrderPresenter?.getNearByTaxies()
        let camera = GMSCameraPosition.camera(withLatitude: SharedData.userLat ?? 0 , longitude: SharedData.userLng ?? 0, zoom: 15)
        let marker = GMSMarker()
        marker.isDraggable = true
        marker.position = CLLocationCoordinate2D(latitude: SharedData.userLat ?? 0, longitude: SharedData.userLng ?? 0)
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        mapView.camera = camera
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
