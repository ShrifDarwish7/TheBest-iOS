//
//  TaxiOrderVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/1/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class TaxiOrderVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var nearbyView: UIView!
    @IBOutlet weak var nearbyDriversTableView: UITableView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    
     let locationManager = CLLocationManager()
    var taxiOrderPresenter: TaxiOrderPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    var fromAutoCompleteController: GMSAutocompleteViewController?
    var toAutoCompleteController: GMSAutocompleteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taxiOrderPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        taxiOrderPresenter?.getNearByTaxies()
        taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        upperView.layer.cornerRadius = upperView.frame.height/2
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
        upperView.setupShadow()
        
        requestLocationPermission()
        
        nearbyView.layer.cornerRadius = 25
        
        loadNearbyDriversTable()
        
        marker.isDraggable = true
        
        mapView.delegate = self
        
        marker.icon = self.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        
        fromLbl.addTapGesture { (_) in
            self.fromAutoCompleteController = GMSAutocompleteViewController()
            self.fromAutoCompleteController!.delegate = self
            self.fromAutoCompleteController?.modalPresentationStyle = .fullScreen
            self.present(self.fromAutoCompleteController!, animated: true, completion: nil)
        }
        
        toLbl.addTapGesture { (_) in
            self.toAutoCompleteController = GMSAutocompleteViewController()
            self.toAutoCompleteController!.delegate = self
            self.toAutoCompleteController?.modalPresentationStyle = .fullScreen
            self.present(self.toAutoCompleteController!, animated: true, completion: nil)
        }
        
    }
    
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
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func loadNearbyDriversTable(){
        
        let nib = UINib(nibName: "DriversTableViewCell", bundle: nil)
        nearbyDriversTableView.register(nib, forCellReuseIdentifier: "DriverCell")
        
        nearbyDriversTableView.numberOfRows { (_) -> Int in
            return 5
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = self.nearbyDriversTableView.dequeueReusableCell(withIdentifier: "DriverCell", for: index) as! DriversTableViewCell
            cell.makeTripBtn.layer.cornerRadius = cell.makeTripBtn.frame.height/2
            
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            
            return UITableView.automaticDimension
            
        }
        
    }

}
