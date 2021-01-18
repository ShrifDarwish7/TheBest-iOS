//
//  MapVC+GMSMapViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 08/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import GoogleMaps

extension MapVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        markerImage.alpha = 0.5
        addressContainerView.isHidden = true
        dismissHintZoom()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let coordinates = mapView.projection.coordinate(for: mapView.center)
        SharedData.userLat = coordinates.latitude
        SharedData.userLng = coordinates.longitude
        markerImage.alpha = 1
        addressContainerView.isHidden = false
        if mapView.camera.zoom <= 15{
            showHintZoom()
            confirmPinBtn.isEnabled = false
            confirmPinBtn.alpha = 0.5
        }else{
            dismissHintZoom()
            confirmPinBtn.isEnabled = true
            loadingView.isHidden = false
            confirmPinBtn.alpha = 1
            taxiPresenter?.getAddressFromGoogleMapsApi()
        }
    }
    
}
