//
//  SubscriptVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 20/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SVProgressHUD

class SubscriptVC: UIViewController {

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
    @IBOutlet weak var carsTypesCollectionView: UICollectionView!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
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
    @IBOutlet weak var daysContainerView: UIView!
    @IBOutlet weak var daysTableView: UITableView!
   // @IBOutlet weak var confirmDaysBtn: RoundedButton!
    @IBOutlet weak var daysTF: UITextField!
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var fromTimeTF: UITextField!
    @IBOutlet weak var toTimeTF: UITextField!
    @IBOutlet weak var goingAndComingIcon: UIImageView!
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
    let fromDatePicker = UIDatePicker()
    let toDatePicker = UIDatePicker()
    let fromTimePicker = UIDatePicker()
    let toTimePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var subscriptionPresenter: SubscriptionPresenter?
    var carsTypes: [SubscriptionsType]?
    var selectedCarType: String?
    var fromAutoCompleteController: GMSAutocompleteViewController?
    var toAutoCompleteController: GMSAutocompleteViewController?
    var comingAndGoingFlag: Int = 0
    var selectedCarTypeId: Int?
    var selectedFromDate: Date?
    var selectedToDate: Date?
    var prms: [String: Any]?
    var selectedDaysIds = [String]()
    
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
        UINavigationBar.appearance().barTintColor = UIColor(named: "MonthlyColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        
        subscriptionPresenter = SubscriptionPresenter(viewDelegate: self)
        subscriptionPresenter?.getTypes()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        timeFormatter.dateFormat = "h:mm a"
        
        dateFormatter.locale = Locale.init(identifier: "EN")
        timeFormatter.locale = Locale.init(identifier: "EN")
        
        fromDatePicker.datePickerMode = .date
        toDatePicker.datePickerMode = .date
        fromTimePicker.datePickerMode = .time
        toTimePicker.datePickerMode = .time
        
        daysTF.addArrowDownIcon()
        fromDateTF.addArrowDownIcon()
        toDateTF.addArrowDownIcon()
        fromTimeTF.addArrowDownIcon()
        toTimeTF.addArrowDownIcon()
        
        fromDateTF.inputView = fromDatePicker
        toDateTF.inputView = toDatePicker
        fromTimeTF.inputView = fromTimePicker
        toTimeTF.inputView = toTimePicker
        
        if #available(iOS 14, *) {
            fromDatePicker.preferredDatePickerStyle = .wheels
            toDatePicker.preferredDatePickerStyle = .wheels
            fromTimePicker.preferredDatePickerStyle = .wheels
            toTimePicker.preferredDatePickerStyle = .wheels
        }
        
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
        
        fromDatePicker.onChange { [self] (date) in
            self.selectedFromDate = date
            self.fromDateTF.text = dateFormatter.string(from: date)
        }
        
        toDatePicker.onChange { [self] (date) in
            self.selectedToDate = date
            self.toDateTF.text = dateFormatter.string(from: date)
        }
        
        fromTimePicker.onChange { (date) in
            self.fromTimeTF.text = self.timeFormatter.string(from: date)
        }
        
        toTimePicker.onChange { (date) in
            self.toTimeTF.text = self.timeFormatter.string(from: date)
        }
        
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
        
        loadDaysTable()

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
    
    @IBAction func goingAndComingAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.goingAndComingIcon.image = UIImage(named: "checked")
            sender.tag = 1
            self.comingAndGoingFlag = 1
        default:
            self.goingAndComingIcon.image = UIImage(named: "unchecked")
            sender.tag = 0
            self.comingAndGoingFlag = 0
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
        
    
    @IBAction func showDaysSelection(_ sender: Any) {
        daysContainerView.isHidden = false
    }
    
    @IBAction func confirmDaysSelection(_ sender: Any) {
        daysContainerView.isHidden = true
        let selectedDays = SharedData.days.filter({return $0.selected})
        if selectedDays.isEmpty{
            daysTF.placeholder = "No selected days"
        }else{
            var temp = [String]()
            for i in selectedDays{
                temp.append(i.day)
            }
            daysTF.text = "(" + temp.joined(separator: ", ") + ")"
        }
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        
        
        SharedData.days.filter({return $0.selected}).forEach { (day) in
            selectedDaysIds.append("\(day.day)")
        }
        
        guard !selectedDaysIds.isEmpty else {
            showAlert(title: "", message: "Please select working days")
            return
        }
        
        guard (selectedFromDate != nil), (selectedToDate != nil) else {
            showAlert(title: "", message: "Please select from and to date")
            return
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: selectedFromDate!, to: selectedToDate!)
        
        guard components.day! > 0 else {
            showAlert(title: "", message: "Please select date range more than one day")
            return
        }
        
        guard components.day! > 7 else {
            showAlert(title: "", message: "Please select date range more than 7 days")
            return
        }
        
        let days: Int = (components.day! / 7) * selectedDaysIds.count
        print(days)
        
        let parameters = [
            "latitudeFrom": "\(SharedData.userLat ?? 0.0)",
            "longitudeFrom": "\(SharedData.userLng ?? 0.0)",
            "latitudeTo": "\(SharedData.userDestinationLat ?? 0.0)",
            "longitudeTo": "\(SharedData.userDestinationLng ?? 0.0 )",
            "days": days,
            "car_type_id": self.selectedCarTypeId ?? 0,
            "going_coming": "\(self.comingAndGoingFlag)",
            "equipment_id": self.selectedCarTypeId ?? 0
        ] as! [String : Any]
        
        
        self.prms = parameters
        
        self.from_toView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.from_toView.alpha = 1
        }
        
    }
    
    @IBAction func confirmRideAction(_ sender: UIButton) {
                
        switch sender.tag {
        case 0:
           
            self.subscriptionPresenter?.getDistance(self.prms!)
            
        default:
            var formData: [String: Any] = [
                "from_lat": "\(SharedData.userLat ?? 0.0)",
                "from_lng": "\(SharedData.userLng ?? 0.0)",
                "to_lat": "\(SharedData.userDestinationLat ?? 0.0)",
                "to_lng": "\(SharedData.userDestinationLng ?? 0.0)",
                "address_from": SharedData.userFromAddress ?? "",
                "address_to": SharedData.userToAddress ?? "",
                "from_date": fromDateTF.text!,
                "to_date": toDateTF.text!,
                "from_time": fromTimeTF.text!,
                "to_time": toTimeTF.text!,
                "going_coming": "\(self.comingAndGoingFlag)",
                "required_equipment": "\(self.selectedCarType ?? "")",
                "lat": "\(SharedData.userLat ?? 0.0)",
                "lng": "\(SharedData.userLng ?? 0.0)",
                "total": "\(UserDefaults.init().double(forKey: "trip_total") > 9999.0 ? 9999.0 : UserDefaults.init().double(forKey: "trip_total"))"
            ]
            
            for i in 0...(selectedDaysIds.count-1){
                formData.updateValue(selectedDaysIds[i], forKey: "working_days[\(i)]")
            }

            print(formData)
        
            self.subscriptionPresenter?.confirmRide(formData)
        }

    }
    
    
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer){
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = self.bottomSheetTopConstraint.constant
        case .changed:

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
            
        default:
            break
        }
    }
    

}

extension SubscriptVC: CLLocationManagerDelegate{
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
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
    
}



extension SubscriptVC: GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if viewController === self.fromAutoCompleteController{
            
            SharedData.userLat = place.coordinate.latitude
            SharedData.userLng = place.coordinate.longitude
            self.mapView.clear()
            self.putMyMarker()
            self.fromLbl.text = place.formattedAddress ?? ""
            SharedData.userFromAddress = place.formattedAddress ?? ""
            
        }else{
            
            self.mapView.clear()
            self.putMyMarker()
            self.toLbl.text = place.formattedAddress ?? ""
            SharedData.userToAddress = place.formattedAddress ?? ""
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            marker.icon = Images.imageWithImage(image: UIImage(named: "location-icon-png")!, scaledToSize: CGSize(width: 40, height: 55))
            marker.map = mapView
            
            SharedData.userDestinationLat = place.coordinate.latitude
            SharedData.userDestinationLng = place.coordinate.longitude
            
            UIView.animate(withDuration: 0.5) {
                self.confirmBtn.isHidden = false
                self.view.layoutIfNeeded()
            }
            
        }
        
      dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      // TODO: handle the error.
      print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
  
    
}
