//
//  RoadServicesVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SVProgressHUD

class RoadServicesVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var tripInfoView: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var draggableView: UIView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var bottomSheetTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nearstCarsTableView: UITableView!
    @IBOutlet weak var callDriver: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var distanceStack: UIStackView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var carsTypesCollectionView: UICollectionView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    
    @IBOutlet weak var fromToStack: UIStackView!
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var specialCarsTableView: UITableView!
    @IBOutlet weak var startRide: UIButton!
    @IBOutlet weak var from_toView: UIView!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var mapBtmConst: NSLayoutConstraint!
    @IBOutlet weak var serviceNameTF: UITextField!
    @IBOutlet weak var minusCar: UIButton!
    @IBOutlet weak var plusCar: UIButton!
    @IBOutlet weak var carsNumber: UILabel!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var serviceNumber: UILabel!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lottieContainerView: UIView!
    @IBOutlet weak var whatsappBtn: UIButton!
    
    let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height
    let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
    let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top
    var bottomSheetPanStartingTopConstant : CGFloat = 30.0
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    let locationManager = CLLocationManager()
    var taxiOrderPresenter: TaxiOrderPresenter?
    var receivedId: Int?
    var roadServicesPresenter: RoadServicesPresenter?
    var services: [RoadServOption]?
    var nearstCars: [NearestCar]?
    var selectedDriverID: Int?
   // var selectedServiceName: String?
    //var selectedServiceImage: String?
    var selectedService: RoadServOption?
    
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
        
        plus.onTap {
            let count = Int(self.serviceNumber.text!)!
            self.serviceNumber.text = String(count + 1)
        }
        minus.onTap {
            let count = Int(self.serviceNumber.text!)!
            if count > 1 {
                self.serviceNumber.text = String(count - 1)
            }
        }
        
        roadServicesPresenter = RoadServicesPresenter(roadServicesViewDelegate: self)
        roadServicesPresenter?.getOptions(id: receivedId!)
        
        taxiOrderPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.draggableView.addGestureRecognizer(viewPan)
        
        self.bottomSheetTopConstraint.constant = topPadding! + 110
        
        upperView.layer.cornerRadius = upperView.frame.height/2
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
        
        
        upperView.setupShadow()
        
        requestLocationPermission()
        
        marker.isDraggable = true
        mapView.delegate = self
        
        marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))

        NotificationCenter.default.addObserver(self, selector: #selector(receivedDriverId(sender:)), name: NSNotification.Name("ReceivedConfirmationFromDriver"), object: nil)

        
    }
    @IBAction func cancelRide(_ sender: Any) {
        Router.toCancelation(self)
    }
    
    @objc func receivedDriverId(sender: NSNotification){
        
        guard let userInfo = sender.userInfo else { return }
        
        let driver = userInfo["driver"] as! Driver
        
        self.driverName.text = driver.name
        if let image = driver.hasImage,
           !image.contains("no-image"),
           !image.isEmpty
           {
            self.driverImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "driver_temp"))
        }else{
            self.driverImage.image = UIImage(named: "driver_temp")
        }
        //self.carImage.sd_setImage(with: URL(string: driver?.myCar?.first!.hasImage ?? ""))
        self.carNumber.text = driver.myCar?.first?.carNumber
        self.callDriver.addTapGesture { (_) in
            TripsServices.callDriver(phoneNumber: driver.phone ?? "")
        }
        whatsappBtn.onTap {
            SharedData.forwardToWhatsapp(driver.phone ?? "")
        }
        self.driverView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.loadingView.alpha = 0
            self.driverView.alpha = 1
        }) { (_) in
            self.loadingView.isHidden = true
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
       // let velocity = panRecognizer.velocity(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            print("")
            bottomSheetPanStartingTopConstant = self.bottomSheetTopConstraint.constant
        case .changed:
         //   print(translation.y)
        //    print( self.bottomSheetTopConstraint.constant + translation.y)

            if self.bottomSheetTopConstraint.constant + translation.y > 0 {
                self.bottomSheetTopConstraint.constant = self.bottomSheetPanStartingTopConstant + translation.y
            }
            
        case .ended:
            
            if translation.y > -50 {
                self.bottomSheetTopConstraint.constant = safeAreaHeight! - bottomPadding!
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.view.layoutIfNeeded()
                } completion: { (_) in
                    
                }

            }else{
                
                self.bottomSheetTopConstraint.constant = topPadding! + 110
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.view.layoutIfNeeded()
                } completion: { (_) in
                    
                }
                
            }
            
//            if velocity.y > 1500.0 {
//
//                let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height
//             //   let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
//                self.bottomSheetTopConstraint.constant = safeAreaHeight! - CGFloat(35)
//
//              UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
//                  self.view.layoutIfNeeded()
//              }) { (_) in
//
//                }
//            }else if velocity.y < 10{
//
//                self.bottomSheetTopConstraint.constant = UIApplication.shared.statusBarFrame.height + CGFloat(110)
//
//                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
//                    self.view.layoutIfNeeded()
//                }) { (_) in
//
//                }
//
//            }
            
        default:
            break
        }
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            
            let parameters = [
                "latitudeFrom": SharedData.userLat ?? 0.0,
                "longitudeFrom": SharedData.userLng ?? 0.0,
                "latitudeTo": SharedData.userDestinationLat ?? 0.0,
                "longitudeTo": SharedData.userDestinationLng ?? 0.0,
                "service_count": self.serviceNumber.text!,
                "service_id": self.selectedService?.id ?? 0
               // "driver_id": driverId
            ] as [String: Any]
            
            self.roadServicesPresenter?.getDistance(parameters)
        default:
            
            guard (self.selectedService != nil) else {
                showAlert(title: "", message: "Please select service first")
                return
            }
            
            let formData: [String: String] = [
//                "from_lat": "\(SharedData.userLat ?? 0.0)",
//                "from_lng": "\(SharedData.userLng ?? 0.0)",
//                "to_lat": "\(SharedData.userDestinationLat ?? 0.0)",
//                "to_lng": "\(SharedData.userDestinationLng ?? 0.0)",
                "service_image": self.selectedService?.image ?? "",
                "service_count": self.serviceNumber.text!,
                "service_name": self.selectedService?.name ?? "",
                "note": self.notes.text!,
                "service_desc": self.selectedService?.description ?? "",
                "service_price": self.selectedService?.price ?? "",
                "lat": "\(SharedData.userLat ?? 0.0)",
                "lng": "\(SharedData.userLng ?? 0.0)",
                "total": "\(UserDefaults.init().double(forKey: "trip_total") > 9999.0 ? 9999.0 : UserDefaults.init().double(forKey: "trip_total"))"
            ]
            
            self.roadServicesPresenter?.confirmRide(formData)
        }
    }
    
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }

}
