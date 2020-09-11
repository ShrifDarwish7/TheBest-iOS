//
//  TermsAndConditionsVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/11/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class TermsAndConditionsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.onTap {
                   self.dismiss(animated: true, completion: nil)
               }
       
    }
    

   

}
