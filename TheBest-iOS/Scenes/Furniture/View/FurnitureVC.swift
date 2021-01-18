//
//  FurnitureVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SVProgressHUD


class FurnitureVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var tripInfoView: UIView!
    @IBOutlet weak var carsTypesCollectionView: UICollectionView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var fromToStack: UIStackView!
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var specialCarsTableView: UITableView!
    @IBOutlet weak var callDriver: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var startRide: UIButton!
    @IBOutlet weak var from_toView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var draggableView: UIView!
    @IBOutlet weak var bottomSheetTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var mapBtmConst: NSLayoutConstraint!
    @IBOutlet weak var serviceNameTF: UITextField!
    @IBOutlet weak var minusCar: UIButton!
    @IBOutlet weak var plusCar: UIButton!
    @IBOutlet weak var carsNumber: UILabel!
    @IBOutlet weak var minusWorker: UIButton!
    @IBOutlet weak var plusWorker: UIButton!
    @IBOutlet weak var workersNumber: UILabel!
    @IBOutlet weak var minusSpec: UIButton!
    @IBOutlet weak var plusSpec: UIButton!
    @IBOutlet weak var specsNumber: UILabel!
    @IBOutlet weak var scheduleTF: UITextField!
    @IBOutlet weak var orderDateImg1: UIImageView!
    @IBOutlet weak var orderDateImg2: UIImageView!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lottieContainerView: UIView!
    @IBOutlet weak var whatsappBtn: UIButton!
    
    let locationManager = CLLocationManager()
    var taxiOrderPresenter: TaxiOrderPresenter?
    var furniturePresenter: FurnitureVCPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    var fromAutoCompleteController: GMSAutocompleteViewController?
    var toAutoCompleteController: GMSAutocompleteViewController?
    var truckTypes: [TruckCarType]?
    var trucksData: [TruckData]?
    var bottomSheetPanStartingTopConstant : CGFloat = 30.0
    var selectedDriverID: Int?
    let safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame.size.height
    let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
    let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top
    let servicePicker = UIPickerView()
    let services = ["منقولات منزل", "سيارة معطلة", "محتويات مكتب", "ادوات شخصية"]
    let datePicker = UIDatePicker()
    var pickedDate: String?
    var selectedServiceImage: String?
    var selectedCarTypeId: Int?
    
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
                
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.draggableView.addGestureRecognizer(viewPan)
        
        self.bottomSheetTopConstraint.constant = topPadding! + 110
        
//        mapView.setStyle()
        setupPicker(textField: serviceNameTF, picker: servicePicker)
        servicePicker.delegate = self
        servicePicker.reloadAllComponents()
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        scheduleTF.inputView = datePicker
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        let icon = UIImageView(frame : CGRect(x: 5, y: 5, width: 30, height: 15))
        icon.image = UIImage(named: "drop-down-arrow")
        icon.contentMode = .scaleAspectFit
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        scheduleTF.rightViewMode = .always
        scheduleTF.rightView = icon
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "FurnitureColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        
        taxiOrderPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        
        furniturePresenter = FurnitureVCPresenter(furnitureViewDelegate: self)
        furniturePresenter?.getTruckTypes()
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        upperView.layer.cornerRadius = upperView.frame.height/2
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
       // tripInfoView.layer.cornerRadius = 25
       // from_toView.layer.cornerRadius = 25
        confirmBtn.layer.cornerRadius = 10
        startRide.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        upperView.setupShadow()
        
//        from_toView.setupShadow()
//        tripInfoView.setupShadow()
//        driverView.setupShadow()
        
        requestLocationPermission()
        
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
        
        driverImageView.layer.cornerRadius = driverImageView.frame.height/2
        driverImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        driverImageView.layer.borderWidth = 1.5
        driverView.layer.cornerRadius = 25
        
        
        plusCar.onTap {
            let count = Int(self.carsNumber.text!)!
            self.carsNumber.text = String(count + 1)
        }
        minusCar.onTap {
            let count = Int(self.carsNumber.text!)!
            if count > 1 {
                self.carsNumber.text = String(count - 1)
            }
        }
        
        plusWorker.onTap {
            let count = Int(self.workersNumber.text!)!
            self.workersNumber.text = String(count + 1)
        }
        minusWorker.onTap {
            let count = Int(self.workersNumber.text!)!
            if count > 1 {
                self.workersNumber.text = String(count - 1)
            }
        }
        
        plusSpec.onTap {
            let count = Int(self.specsNumber.text!)!
            self.specsNumber.text = String(count + 1)
        }
        minusSpec.onTap {
            let count = Int(self.specsNumber.text!)!
            if count > 1 {
                self.specsNumber.text = String(count - 1)
            }
        }

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
    
    @IBAction func sceduleAction(_ sender: UIButton) {
        
        orderDateImg1.image = UIImage(named: "unselect")
        orderDateImg2.image = UIImage(named: "unselect")
        
        switch sender.tag {
        case 0:
            orderDateImg1.image = UIImage(named: "select")
            scheduleTF.text = ""
        case 1:
            orderDateImg2.image = UIImage(named: "select")
            scheduleTF.becomeFirstResponder()
        default:
            break
        }
    }
    
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateStr = dateFormatter.string(from: datePicker.date)
        self.pickedDate = dateStr
        scheduleTF.text = dateStr.replacingOccurrences(of: "T", with: " ")
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
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func tripButtonAction(_ sender: UIButton) {
//            guard let _ = selectedDriverID else {
//                self.showAlert(title: "", message: "Select driver first")
//                return
//            }
            self.from_toView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.from_toView.alpha = 1
            }
    //        switch sender.tag {
    //        case 0:
    //            self.taxiOrderPresenter?.getDirectionFromGoogleMaps(origin: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)", destination: "\(SharedData.userDestinationLat ?? 0),\(SharedData.userDestinationLng ?? 0)")
    //            let camera = GMSCameraPosition.camera(withLatitude: SharedData.userDestinationLat!, longitude: SharedData.userDestinationLng!, zoom: 12)
    //            DispatchQueue.main.async {
    //                self.mapView.animate(to: camera)
    //            }
    //        default:
    //            break
    //        }
        }
    
    @IBAction func startRideAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.taxiOrderPresenter?.getDirectionFromGoogleMaps(origin: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)", destination: "\(SharedData.userDestinationLat ?? 0),\(SharedData.userDestinationLng ?? 0)")
            let camera = GMSCameraPosition.camera(withLatitude: SharedData.userDestinationLat!, longitude: SharedData.userDestinationLng!, zoom: 12)
            DispatchQueue.main.async {
                self.mapView.animate(to: camera)
            }
            
            let parameters = [
                "latitudeFrom": SharedData.userLat ?? 0.0,
                "longitudeFrom": SharedData.userLng ?? 0.0,
                "latitudeTo": SharedData.userDestinationLat ?? 0.0,
                "longitudeTo": SharedData.userDestinationLng ?? 0.0,
                "driver_id": "\(self.selectedDriverID ?? 0)",
                "workerscount": self.workersNumber.text!,
                "spcialistscount": self.specsNumber.text!,
                "car_type_id": self.selectedCarTypeId ?? 0,
                "quantity": self.carsNumber.text!
            ] as [String: Any]
            
            self.furniturePresenter?.getDistance(parameters)
        case 1:
            
            let formData: [String: String] = [
                "from_lat": "\(SharedData.userLat ?? 0.0)",
                "from_lng": "\(SharedData.userLng ?? 0.0)",
                "to_lat": "\(SharedData.userDestinationLat ?? 0.0)",
                "to_lng": "\(SharedData.userDestinationLng ?? 0.0)",
                "address_from": SharedData.userFromAddress ?? "",
                "address_to": SharedData.userToAddress ?? "",
                "number_workers": self.workersNumber.text!,
                "number_technicians": self.specsNumber.text!,
                "service_count": self.carsNumber.text!,
                "service_name": self.serviceNameTF.text!,
                "service_image": self.selectedServiceImage ?? "",
                "note": self.note.text!,
                "date": self.pickedDate ?? "",
                "lat": "\(SharedData.userLat ?? 0.0)",
                "lng": "\(SharedData.userLng ?? 0.0)",
                "total": "\(UserDefaults.init().double(forKey: "trip_total") > 9999.0 ? 9999.0 : UserDefaults.init().double(forKey: "trip_total"))"
            ]
            self.furniturePresenter?.confirmRide(formData: formData)
            
        default:
            break
        }
        
    }

}
