//
//  RegisterVC+RegisterViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension RegisterVC: RegisterViewDelegate{
    
    func showSVProgess() {
        SVProgressHUD.show()
    }
    
    func didSuccessfulyRegistering() {
        print("didSuccessfulyRegistering")
        Router.toHome(sender: self)
    }
    
    func didFailRegistering() {
        print("didFailRegistering")
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
}
