//
//  RoadServicesVC+RoadServicesViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD
import GoogleMaps

extension RoadServicesVC: RoadServicesViewDelegate{
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteWithOptions(data: [RoadServOption]?) {
        if let _ = data{
            self.services = data
            self.registerCollectionView()
            self.loadTableView()
            self.servicesCollectionView.reloadData()
        }
    }
    
    func didCompleteWithNearesrCars(_ result: NearestCars?) {
        if let _ = result{
            for i in 0...(result?.data.count)!-1{
                if let lat = result?.data[i].lat,
                   let lng = result?.data[i].lng{
                    let marker = GMSMarker()
                    marker.icon = Images.imageWithImage(image: UIImage(named: "car-marker")!, scaledToSize: CGSize(width: 40, height: 55))
                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    marker.map = mapView
                                        
                }
            }
            UIView.animate(withDuration: 0.5) {
                self.confirmBtn.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func didCompleteWithDistance(_ result: Distance?) {
        if let _ = result{
            self.confirmBtn.tag = 1
            self.confirmBtn.setTitle("Confirm ride", for: .normal)
            self.distanceLbl.text = "\(result!.distance )" + " Km"
            self.costLbl.text = "\(result!.cost )" + " KWD"
            UserDefaults.init().setValue(result?.cost, forKey: "trip_total")
            UIView.animate(withDuration: 0.5) {
                self.distanceStack.isHidden = false
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    func didCompleteConfirmRide() {
        loadingView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.loadingView.alpha = 1
        }
        self.lottieContainerView.addLottieLoader()
    }
    
}
