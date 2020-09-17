//
//  ProfileVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var days: UITextField!
    @IBOutlet weak var months: UITextField!
    @IBOutlet weak var years: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    let daysForPicker = (1...31).map({String($0)})
    let yearsForPicker = (1960...MAX_YEARS).map({String($0)})
    var daysPicker = UIPickerView()
    var monthsPicker = UIPickerView()
    var yearsPicker = UIPickerView()
    var countryPicker = UIPickerView()
    
    var profilePresenter: ProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePresenter = ProfilePresenter(profileViewDelegate: self)
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        saveBtn.layer.cornerRadius = 15
        
        setupPicker(textField: countryTF, picker: countryPicker)
        
        loadCountryPicker()
        loadDaysPicker()
        loadYearsPicker()
        loadMonthsPicker()
        
        setupPicker(textField: days, picker: daysPicker)
        setupPicker(textField: months, picker: monthsPicker)
        setupPicker(textField: years, picker: yearsPicker)
        
        saveBtn.onTap {
            
            guard !self.firstNameTF.text!.isEmpty, !self.emailTF.text!.isEmpty, !self.countryTF.text!.isEmpty, !self.days.text!.isEmpty, !self.years.text!.isEmpty, !self.months.text!.isEmpty else{
                self.showAlert(title: "", message: "Please fill out required fields")
                return
            }
            
            let dof = (self.years.text ?? "") + "-" + (MONTHS_EN[self.months.text!]! )
            let dof_ = dof  + "-" + (self.days.text ?? "")
            
            let updateParamters = [
                "name": self.firstNameTF.text!,
                "image:": "",
                "email": self.emailTF.text!,
                "nationality": self.countryTF.text ?? "",
                "birth_date": dof_
                ] as [String : Any]
            
            self.profilePresenter?.updateProfile(parameters: updateParamters as! [String : String])
            
        }
        
    }
    

    func loadCountryPicker() {
        
        self.countryPicker
            .numberOfRowsInComponent() { _ in
                COUNTRIES_EN.count
        }.viewForRow(handler: { (row, _, _) -> UIView in
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            label.numberOfLines = 0
            label.textAlignment = .center
            label.sizeToFit()
            
            label.text =  Array(COUNTRIES_EN.keys).sorted()[row]
            
            return label
            
        }).didSelectRow { row, component in
            
            self.countryTF.text = Array(COUNTRIES_EN.keys).sorted()[row]
            
        }.reloadAllComponents()
        
    }
    
    func loadDaysPicker() {
        
        self.daysPicker
            .numberOfRowsInComponent() { _ in
                return self.daysForPicker.count
        }.didSelectRow { row, component in
            
            self.days.text = self.daysForPicker[row]
            
        }.titleForRow(handler: { (row, _) -> String? in
            
            return self.daysForPicker[row]
            
        })
        .reloadAllComponents()
        
    }
    
    func loadYearsPicker() {
        
        self.yearsPicker
            .numberOfRowsInComponent() { _ in
                return self.yearsForPicker.count
        }.didSelectRow { row, component in
            
            self.years.text = self.yearsForPicker[row]
            
        }.titleForRow(handler: { (row, _) -> String? in
            
            return self.yearsForPicker[row]
            
        })
        .reloadAllComponents()
        
    }
    
    func loadMonthsPicker() {
        
        self.monthsPicker
            .numberOfRowsInComponent() { _ in
                return MONTHS_EN.count
        }.didSelectRow { row, component in
            
            self.months.text = Array(MONTHS_EN.keys).sorted()[row]
            
        }.titleForRow(handler: { (row, _) -> String? in
            
            return Array(MONTHS_EN.keys).sorted()[row]
            
        })
        .reloadAllComponents()
        
    }

    
    

}
