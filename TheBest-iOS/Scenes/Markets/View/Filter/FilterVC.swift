//
//  FilterVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class FilterVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var detectBtn: UIButton!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var governTF: UITextField!
    @IBOutlet weak var districtTF: UITextField!
    
    var marketsVCPresenter: MarketsVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        marketsVCPresenter = MarketsVCPresenter(marketsViewDelegate: self)
        
        detectBtn.layer.cornerRadius = 15
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        detectBtn.onTap {
            
            guard !self.countryTF.text!.isEmpty, !self.governTF.text!.isEmpty, !self.districtTF.text!.isEmpty else{
                self.showAlert(title: "", message: "please fill required fields to return correct result")
                return
            }
            
            self.marketsVCPresenter?.filterMarkets(country: self.countryTF.text!, government: self.governTF.text!, district: self.districtTF.text!)
            
        }
        
    }
    

}
