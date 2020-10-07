//
//  TermsAndConditionsVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/11/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        backBtn.onTap {
                   self.navigationController?.popViewController(animated: true)
               }
       
    }
    

   

}
