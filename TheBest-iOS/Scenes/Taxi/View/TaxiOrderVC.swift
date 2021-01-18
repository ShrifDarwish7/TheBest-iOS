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
import Lottie
import SVProgressHUD

class TaxiOrderVC: UIViewController, CLLocationManagerDelegate , UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var setupTripView: UIView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var tripFees: UILabel!
    @IBOutlet weak var tripInfoStack: UIStackView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var tripScrollView: UIScrollView!
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var cancelTripBtn: UIButton!
    @IBOutlet weak var callDriver: UIImageView!
    @IBOutlet weak var cancelationView: UIView!
    @IBOutlet weak var reasonsCollectionView: UICollectionView!
    @IBOutlet weak var cancelLbl: UILabel!
    @IBOutlet weak var tripInfoStackHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lottieContainerView: UIView!
    @IBOutlet weak var whatsappBtn: UIButton!
    
    let locationManager = CLLocationManager()
    var taxiOrderPresenter: TaxiOrderPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    var fromAutoCompleteController: GMSAutocompleteViewController?
    var toAutoCompleteController: GMSAutocompleteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let trip = SharedData.currentTrip{
            switch trip.status {
            case SharedData.arrivedStatus, SharedData.inProgressStatus:
                SVProgressHUD.show()
                TripsServices.getDriverBy(id: trip.driverID!) { (response) in
                    SVProgressHUD.dismiss()
                    if let _ = response?.driver{
                        NotificationCenter.default.post(name: NSNotification.Name("ReceivedConfirmationFromDriver"), object: nil, userInfo: ["driver": response!.driver as Driver])
                    }
                }
            default:
                break
            }
        }

        NotificationCenter.default.addObserver(self, selector: #selector(receivedDriverId(sender:)), name: NSNotification.Name("ReceivedConfirmationFromDriver"), object: nil)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "TaxiGoldColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        
//        mapView.setStyle()
        
        taxiOrderPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        taxiOrderPresenter?.getNearByTaxies()
        taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        confirmBtn.layer.cornerRadius = 10
        upperView.layer.cornerRadius = upperView.frame.height/2
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
        upperView.setupShadow()
        
        requestLocationPermission()
        
        setupTripView.layer.cornerRadius = 25
        cancelationView.layer.cornerRadius = 25
        loadingView.layer.cornerRadius = 25
        driverView.layer.cornerRadius = 25
        driverImage.layer.cornerRadius = 35
        cancelTripBtn.layer.cornerRadius = 10
        
        //lottieContainerView.addLottieLoader()
        
        marker.isDraggable = true
                
        mapView.delegate = self
        
        marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
        
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
//
//        cancelTripBtn.onTap {
//            self.taxiOrderPresenter?.cancelRide()
//        }
        
        tripInfoStackHeight.constant = 0
        
//        if let _ = SharedData.receivedDriverId{
//            SVProgressHUD.show()
//            taxiOrderPresenter?.getDriverBy(id: Int(SharedData.receivedDriverId!)!)
//            SharedData.receivedDriverId = nil
//        }
        
    }
    
    @IBAction func cancelRide(_ sender: Any) {
        Router.toCancelation(self)
    }
    
    
    @objc func receivedDriverId(sender: NSNotification){
        
        guard let userInfo = sender.userInfo else { return }
//        taxiOrderPresenter?.getDriverBy(id: Int(sender.userInfo!["driver_id"] as! String)!)
//        SharedData.receivedDriverId = nil
        let driver = userInfo["driver"] as! Driver
        loadDriver(driver: driver)
        
    }
    
    func loadDriver(driver: Driver){
        self.driverName.text = driver.name
        if let image = driver.hasImage,
           !image.contains("no-image"),
           !image.isEmpty
           {
            self.driverImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "driver_temp"))
        }else{
            self.driverImage.image = UIImage(named: "driver_temp")
        }
        
        self.carImage.sd_setImage(with: URL(string: driver.myCar?.first!.hasImage ?? ""))
        self.carNumber.text = driver.myCar?.first?.carNumber
        self.callDriver.addTapGesture { (_) in
            TripsServices.callDriver(phoneNumber: driver.phone ?? "")
        }
        whatsappBtn.onTap {
            SharedData.forwardToWhatsapp(driver.phone?.replacingOccurrences(of: " ", with: "") ?? "")
        }
        self.driverView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.loadingView.alpha = 0
            self.driverView.alpha = 1
        }) { (_) in
            self.loadingView.isHidden = true
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
    
    func resetConfirmBtn(){
        DispatchQueue.main.async {
            self.confirmBtn.tag = 0
            self.confirmBtn.setTitle("Confirm", for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.tripInfoStackHeight.constant = 0
                self.view.layoutIfNeeded()
//                self.tripInfoStack.isHidden = true
//                self.confirmBtn.isHidden = true
            }
        }
    }
    
    @IBAction func confirmActionBtn(_ sender: UIButton) {
        switch sender.tag {
            
        case 0:
            
            self.taxiOrderPresenter?.getDirectionFromGoogleMaps(origin: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)", destination: "\(SharedData.userDestinationLat ?? 0),\(SharedData.userDestinationLng ?? 0)")
            let camera = GMSCameraPosition.camera(withLatitude: SharedData.userDestinationLat!, longitude: SharedData.userDestinationLng!, zoom: 12)
            DispatchQueue.main.async {
                self.mapView.animate(to: camera)
            }
            self.taxiOrderPresenter?.getDistance()
            
        case 1:
            
            self.taxiOrderPresenter?.confirmRide()
            
        default:
            break
        }
    }
    
    func loadReasonsCollection(){
        
        reasonsCollectionView.numberOfSectionsIn(handler: { () -> Int in
            return 1
        }).numberOfItemsInSection { (_) -> Int in
            return 2
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            switch index.row{
                
            case 0:
                
                let nib = UINib(nibName: "ReasonsCollectionViewCell", bundle: nil)
                self.reasonsCollectionView.register(nib, forCellWithReuseIdentifier: "ReasonCell")
                let cell = self.reasonsCollectionView.dequeueReusableCell(withReuseIdentifier: "ReasonCell", for: index) as! ReasonsCollectionViewCell
                for btn in cell.reasonsButtons{
                    btn.onTap {
                        btn.setImage(UIImage(named: "reason_select"), for: .normal)
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            self.reasonsCollectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
                            UIView.animate(withDuration: 0.5) {
                                self.cancelLbl.alpha = 0
                            }
                        }
                    }
                }
                return cell
                
            case 1:
                
                let nib = UINib(nibName: "AfterCancelCollectionViewCell", bundle: nil)
                self.reasonsCollectionView.register(nib, forCellWithReuseIdentifier: "AfterCancelCell")
                let cell = self.reasonsCollectionView.dequeueReusableCell(withReuseIdentifier: "AfterCancelCell", for: index) as! AfterCancelCollectionViewCell
                return cell
                
            default:
                return UICollectionViewCell()
                
            }
            
        }.sizeForItemAt { (_) -> CGSize in
            return CGSize(width: self.reasonsCollectionView.frame.width, height: self.reasonsCollectionView.frame.height)
        }
        
    }
    
//    func loadNearbyDriversTable(){
//
//        let nib = UINib(nibName: "DriversTableViewCell", bundle: nil)
//        nearbyDriversTableView.register(nib, forCellReuseIdentifier: "DriverCell")
//
//        nearbyDriversTableView.numberOfRows { (_) -> Int in
//            return 5
//        }.cellForRow { (index) -> UITableViewCell in
//
//            let cell = self.nearbyDriversTableView.dequeueReusableCell(withIdentifier: "DriverCell", for: index) as! DriversTableViewCell
//            cell.makeTripBtn.layer.cornerRadius = cell.makeTripBtn.frame.height/2
//
//            return cell
//
//        }.heightForRowAt { (_) -> CGFloat in
//
//            return UITableView.automaticDimension
//
//        }
//
//    }

}
