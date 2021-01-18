//
//  CompleteAddressVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 09/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import UITextField_Navigation

class CompleteAddressVC: UIViewController {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var building: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var aprt: UITextField!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var FPNContainer: UIView!
    @IBOutlet weak var confirmPinBtn: UIButton!
    @IBOutlet weak var vcTitle: UILabel!
    @IBOutlet weak var cityLBlb: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var buildingLbl: UILabel!
    @IBOutlet weak var floorLbl: UILabel!
    @IBOutlet weak var aprtLbl: UILabel!
    @IBOutlet weak var landmarkLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    
    
    var FPNTextfield : FPNTextField?
    var dialCode = "+20"
    var selectedFPNContryCode: String?
    var receivedGoogleAddress: GoogleMapsGeocodeAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Confirm address".localized, message: "Please complete your address, to deliver your order properly".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        FPNTextfield = FPNTextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: FPNContainer.frame.height))
        FPNTextfield!.delegate = self
        FPNTextfield!.setCountries(excluding: [FPNCountryCode.IL])
        FPNTextfield!.setFlag(countryCode: FPNCountryCode.EG)
        FPNTextfield!.keyboardType = .asciiCapableNumberPad
       // FPNTextfield!.hasPhoneNumberExample = true
        FPNTextfield!.semanticContentAttribute = .forceLeftToRight
        FPNTextfield!.textAlignment = .left
        FPNContainer.addSubview(FPNTextfield!)
        
        landmark.nextNavigationField = FPNTextfield
        
        confirmPinBtn.layer.cornerRadius = 10
        
        city.text = receivedGoogleAddress?.city
        area.text = receivedGoogleAddress?.area2
        streetName.text = receivedGoogleAddress?.route
        
        if "lang".localized == "ar"{
            vcTitle.text = "استكمال العنوان"
            confirmPinBtn.setTitle("تأكيد", for: .normal)
            cityLBlb.text = "المدينة"
            areaLbl.text = "المنطقة"
            streetLbl.text = "الشارع"
            landmarkLbl.text = "العلامات المميزة او رقم المجموعة السكنية"
            buildingLbl.text = "اسم او رقم البناية"
            floorLbl.text = "اسم او رقم الطابق"
            aprtLbl.text = "رقم الشقة"
            phoneLbl.text = "رقم الهاتف"
        }

    }
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmAction(_ sender: Any){
        guard !city.text!.isEmpty, !area.text!.isEmpty, !streetName.text!.isEmpty, !building.text!.isEmpty, !floor.text!.isEmpty, !aprt.text!.isEmpty, !landmark.text!.isEmpty, !(FPNTextfield?.text!.isEmpty)!
              else {
            showAlert(title: "", message: "Please fill out all fields to ensure that the address is accurate".localized)
            return
        }
        
        let address = UserAddress(
            coordinates: "\(SharedData.userLat ?? 0.0),\(SharedData.userLng ?? 0.0)",
            city: city.text!,
            area: area.text!,
            street: streetName.text!,
            building: building.text!,
            floor: floor.text!,
            flat: aprt.text!,
            landmark: landmark.text!,
            phone: "\(self.dialCode)\((FPNTextfield?.text!)!.replacingOccurrences(of: " ", with: ""))")
        
        let dataModel = try! JSONEncoder.init().encode(address)
        UserDefaults.init().setValue(String(data: dataModel, encoding: .utf8), forKey: "user_address")
        Router.toCheckout(sender: self, total: SharedData.total!)
    }
    
}
