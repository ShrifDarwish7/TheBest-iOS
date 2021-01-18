//
//  FilterVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD

class FilterVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var detectBtn: UIButton!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var governTF: UITextField!
    @IBOutlet weak var districtTF: UITextField!
    
    var marketsVCPresenter: MarketsVCPresenter?
    var type: String?
    var cat: Int?
    let cityPicker = UIPickerView()
    let distPicker = UIPickerView()
    var selectedCityId: Int?
    var selectedDistId: Int?
    var cities: [District]?
    var dists: [District]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicker(textField: governTF, picker: cityPicker)
        setupPicker(textField: districtTF, picker: distPicker)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        marketsVCPresenter = MarketsVCPresenter(marketsViewDelegate: self)
        
        detectBtn.layer.cornerRadius = 15
        
        switch type {
        case "shera":
            detectBtn.backgroundColor = UIColor(named: "vegColor")
        default:
            break
        }
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        detectBtn.onTap {
            
            guard !self.countryTF.text!.isEmpty, !self.governTF.text!.isEmpty, !self.districtTF.text!.isEmpty else{
                self.showAlert(title: "", message: "please fill required fields to return correct result")
                return
            }
            
            switch self.type {
            case "shera":
                self.marketsVCPresenter?.filterShera(cat: self.cat!, country: self.countryTF.text!, government: "\(self.selectedCityId ?? 0)", district: "\(self.selectedDistId ?? 0)")
            default:
                self.marketsVCPresenter?.filterMarkets(cat: self.cat!, country: self.countryTF.text!, government: "\(self.selectedCityId ?? 0)", district: "\(self.selectedDistId ?? 0)")
            }
            
            
            
        }
        
        SVProgressHUD.show()
        
        CategoriesServices.getCities { (res) in
            SVProgressHUD.dismiss()
            if let _ = res{
                self.cities = res
                self.loadCityPicker()
            }else{
                self.governTF.isHidden = true
            }
        }
                
    }
    
    func loadCityPicker(){
        cityPicker.numberOfRowsInComponent { (_) -> Int in
            return (self.cities?.count)!
        }.titleForRow { (row, _) -> String? in
            return self.cities![row].name
        }.didSelectRow { (row, _) in
            self.governTF.text = self.cities![row].name
            self.selectedCityId = self.cities![row].id
            SVProgressHUD.show()
            CategoriesServices.getDistricts(id: self.selectedCityId!) { (res) in
                SVProgressHUD.dismiss()
                if let _ = res{
                    self.dists = res
                    self.loadDistsPicker()
                }else{
                    self.districtTF.isHidden = true
                }
            }
        }
    }
    
    func loadDistsPicker(){
        distPicker.numberOfRowsInComponent { (_) -> Int in
            return (self.dists?.count)!
        }.titleForRow { (row, _) -> String? in
            return self.dists![row].name
        }.didSelectRow { (row, _) in
            self.districtTF.text = self.dists![row].name
            self.selectedDistId = self.dists![row].id
            
        }
    }
    

}
