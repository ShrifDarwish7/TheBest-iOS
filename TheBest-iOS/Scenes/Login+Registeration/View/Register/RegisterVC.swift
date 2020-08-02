//
//  RegisterVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    var registerViewPresenter: RegisterViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerViewPresenter = RegisterViewPresenter(registerViewDelegate: self)

        registerBtn.layer.cornerRadius = 10
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        registerBtn.onTap {
            
            guard !self.nameTF.text!.isEmpty, !self.passwordTF.text!.isEmpty, !self.emailTF.text!.isEmpty else{
                self.showAlert(title: "", message: "Please fill out all fields to continue registeration")
                return
            }
            
            let registeringParamters = [
                "phone": "+201282866383",
                "password": self.passwordTF.text!,
                "name": self.nameTF.text!,
                "lat": "",
                "lng": "",
                "image:": "",
                "fcm_token": "aaaaaaaaaa",
                "email": self.emailTF.text!
            ]
            
            self.registerViewPresenter?.registerWith(parameters: registeringParamters)
            
        }
       
    }
    
}
