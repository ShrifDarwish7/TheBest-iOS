//
//  CarRentVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class CarRentVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var tripInfoView: UIView!
   // @IBOutlet weak var carsTypesCollectionView: UICollectionView!
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
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var modelTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var brandIcon: UIImageView!
    @IBOutlet weak var nearestTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nearestTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var taxiOrderPresenter: TaxiOrderPresenter?
    var carsRentPresenter: CarsRentPresenter?
    var marker = GMSMarker()
    var camera: GMSCameraPosition?
    var fromAutoCompleteController: GMSAutocompleteViewController?
    var toAutoCompleteController: GMSAutocompleteViewController?
    var selectedDriverID: Int?
    var cars: Cars?
    var brandPicker = UIPickerView()
    var modelPicker = UIPickerView()
    var yearPicker = UIPickerView()
    var selectedBrandIndex = 0
    var selectedModelIndex = 0
    var selectedYearIndex = 0
    var nearestCars: [NearestCar]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "CarRentColor")
        UINavigationBar.appearance().tintColor = UIColor.white
        
        taxiOrderPresenter = TaxiOrderPresenter(taxiOrderViewDelegate: self)
        taxiOrderPresenter?.getAddressFromGoogleMapsApi()
        
        carsRentPresenter = CarsRentPresenter(carsRentViewDelegate: self)
        carsRentPresenter?.getCars()
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        upperView.layer.cornerRadius = upperView.frame.height/2
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
        tripInfoView.layer.cornerRadius = 25
        from_toView.layer.cornerRadius = 25
        confirmBtn.layer.cornerRadius = 10
        startRide.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        upperView.setupShadow()
        
        from_toView.setupShadow()
        tripInfoView.setupShadow()
        driverView.setupShadow()
        
        setupPicker(textField: brandTF, picker: brandPicker)
        setupPicker(textField: modelTF, picker: modelPicker)
        setupPicker(textField: yearTF, picker: yearPicker)
        
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
        
        switch sender.tag {
        case 0:
            
            self.carsRentPresenter?.getNearestCarsWith(car_model: "1", car_list: "2")
            
        case 1:
            
            // self.carsRentPresenter?.getDistance(driverId: "\(self.selectedDriverID ?? 0)")
            self.from_toView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.from_toView.alpha = 1
            }
            
        default:
            break
            
        }
    }
    
    @IBAction func startRideAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.taxiOrderPresenter?.getDirectionFromGoogleMaps(origin: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)", destination: "\(SharedData.userDestinationLat ?? 0),\(SharedData.userDestinationLng ?? 0)")
            let camera = GMSCameraPosition.camera(withLatitude: SharedData.userDestinationLat!, longitude: SharedData.userDestinationLng!, zoom: 12)
            DispatchQueue.main.async {
                self.mapView.animate(to: camera)
            }
            self.carsRentPresenter?.getDistance(driverId: "\(self.selectedDriverID ?? 0)")
        case 1:
            self.carsRentPresenter?.confirmRide()
        default:
            break
        }
        
    }
    
    func loadBrandPicker() {
        
        guard !self.cars!.cars.data.isEmpty else {
            return
        }
        
        self.brandPicker
            .numberOfRowsInComponent() { _ in
                self.cars!.cars.data.count
        }.viewForRow(handler: { (row, _, _) -> UIView in
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            
            label.text =  self.cars?.cars.data[row].name
            
            return label
            
        }).didSelectRow { row, component in
            
            self.brandTF.text = " " + (self.cars?.cars.data[row].name)!
            self.selectedBrandIndex = row
            self.selectedModelIndex = 0
            self.selectedYearIndex = 0
            self.modelTF.text = ""
            self.yearTF.text = ""
            self.loadModelPicker()
            
            self.confirmBtn.tag = 0
            self.confirmBtn.setTitle("Start order", for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.nearestTableView.isHidden = true
            }
            
            self.brandIcon.sd_setImage(with: URL(string: (self.cars?.cars.data[row].image) ?? ""))
            
        }.reloadAllComponents()
        
    }
    
    func loadModelPicker() {
        
        guard !self.cars!.cars.data[self.selectedBrandIndex].carsModels.isEmpty else {
            return
        }
        
        self.modelPicker
            .numberOfRowsInComponent() { _ in
                self.cars!.cars.data[self.selectedBrandIndex].carsModels.count
        }.viewForRow(handler: { (row, _, _) -> UIView in
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            
            label.text =  self.cars!.cars.data[self.selectedBrandIndex].carsModels[row].name
            
            return label
            
        }).didSelectRow { row, component in
            
            self.modelTF.text = self.cars!.cars.data[self.selectedBrandIndex].carsModels[row].name
            self.selectedModelIndex = row
            self.selectedYearIndex = 0
            self.yearTF.text = ""
            self.loadYearPicker()
            
            self.confirmBtn.tag = 0
            self.confirmBtn.setTitle("Start order", for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.nearestTableView.isHidden = true
            }
            
        }.reloadAllComponents()
        
    }
    
    func loadYearPicker() {
        
        guard !self.cars!.cars.data[self.selectedBrandIndex].carsModels[self.selectedModelIndex].carslist.isEmpty else {
            return
        }
        
        self.yearPicker
            .numberOfRowsInComponent() { _ in
                self.cars!.cars.data[self.selectedBrandIndex].carsModels[self.selectedModelIndex].carslist.count
        }.viewForRow(handler: { (row, _, _) -> UIView in
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            
            label.text =  self.cars!.cars.data[self.selectedBrandIndex].carsModels[self.selectedModelIndex].carslist[row].name
            
            return label
            
        }).didSelectRow { row, component in
            
            self.yearTF.text = self.cars!.cars.data[self.selectedBrandIndex].carsModels[self.selectedModelIndex].carslist[row].name
            self.selectedYearIndex = row
            
            self.confirmBtn.tag = 0
            self.confirmBtn.setTitle("Start order", for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.nearestTableView.isHidden = true
            }
            
        }.reloadAllComponents()
        
    }

}
