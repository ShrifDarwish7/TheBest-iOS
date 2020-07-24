//
//  LoginVC+LoginViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension LoginVC: LoginViewDelegate{
    
    func showSVProgress() {
        self.view.endEditing(true)
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didSuccessSendingCode() {
        
        SVProgressHUD.dismiss()
        self.codeView.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.phoneContainer.alpha  = 0
            self.codeView.alpha = 1
            
        }) { (_) in
            self.phoneContainer.isHidden = true
            self.code1.becomeFirstResponder()
        }
        
    }
    
    func didSuccessLogin() {
        Router.toRegister(sender: self)
    }
    
    func didFailSendingCode() {
        
        SVProgressHUD.dismiss()
        self.showAlert(title: "", message: "Please make sure you entered a correct phone number")
        
    }
    
    func didFailLogin() {
        
        self.showAlert(title: "", message: "Please make sure you entered a correct code")
        
    }
    
    
    
    
}