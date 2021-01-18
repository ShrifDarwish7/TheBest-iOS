//
//  MapVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 08/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var confirmPinBtn: UIButton!
    @IBOutlet weak var hintZoomLbl: UILabel!
    @IBOutlet weak var hintZoomView: UIView!
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var addressContainerView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var hintZoomSubView: UIView!
    
    let locationManager = CLLocationManager()
    var camera: GMSCameraPosition?
    var autocompleteVC: GMSAutocompleteViewController?
    var taxiPresenter: TaxiOrderPresenter?
    var selectedGoogleMapsAddress: GoogleMapsGeocodeAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
        taxiPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        
        mapView.delegate = self
        requestLocationPermission()
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways , .authorizedWhenInUse:
            print("")
        default:
            camera = GMSCameraPosition.camera(withLatitude: 29.3117, longitude: 47.4818, zoom: 8)
            mapView.camera = camera!
        }
        
    }
    
    func loadUI(){
        hintZoomView.transform = CGAffineTransform(scaleX: 0, y: 0)
        showHintZoom()
        hintZoomView.layer.cornerRadius = 10
        hintZoomSubView.layer.cornerRadius = 10
        addressContainerView.roundCorners([.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 15)
        confirmPinBtn.layer.cornerRadius = 10
        loadingView.layer.cornerRadius = 10
        if "lang".localized == "ar"{
            confirmPinBtn.setTitle("تأكيد عنوان التوصيل", for: .normal)
            hintZoomLbl.text = "الرجاء التقريب اكثر لتحديد عنوانك بدقة"
        }
    }
    
    func showHintZoom(){
        self.hintZoomView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            self.hintZoomView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }) { (_) in
            
        }
    }
    
    func dismissHintZoom(){
        self.hintZoomView.isHidden = true
        self.hintZoomView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.view.layoutIfNeeded()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmPinAction(_ sender: Any) {
        guard let _ = self.selectedGoogleMapsAddress else { return }
        Router.toCompleteAddress(sender: self, googleAddress: self.selectedGoogleMapsAddress!)
    }
    
    
    
}
