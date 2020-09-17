//
//  ProfileVC+ProfileViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension ProfileVC: ProfileViewDelegate{
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteUpdateProfileWith(_ updated: Bool) {
        if updated{
            self.showAlert(title: "", message: "Your date updated successfully")
        }else{
            self.showAlert(title: "", message: "An error occured when updating your data")
        }
    }
    
    
}
