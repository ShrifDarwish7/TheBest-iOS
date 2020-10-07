//
//  VendorProfile+VendorViewPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension VendorProfileVC: VendorViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didSuccessfullyFetchingMenuCategories(_ result: MenuCategories) {
        
        self.menuCategories = result
        self.vendorName.text = result.items.name
        if let _ = result.items.hasImage{
           self.vendorImage.sd_setImage(with: URL(string: result.items.hasImage ?? "")!)
            self.bgImage.sd_setImage(with: URL(string: result.items.hasImage ?? "")!)
        }        
        if (self.menuCategories?.items.menuesCategories.count)! > 0{
            self.menuCategories?.items.menuesCategories[0].selected = true
            self.vendorViewPresenter?.fetchMenuItems(id: (self.menuCategories?.items.menuesCategories[0].id)!)
        }
        self.loadMenuCollection()
        
    }
    
    func didFailFetchingMenuCategories() {
        self.showAlert(title: "", message: "Please check your network connection")
    }
    
    func didSuccessfullyFetchMenuItems(_ result: MenuIems) {
        
        self.menuItems = result
        if (self.menuItems?.restaurantMenu.isEmpty)!{
            self.emptyProductLabel.isHidden = false
            self.menuTableView.isHidden = true
        }else{
            self.emptyProductLabel.isHidden = true
            self.menuTableView.isHidden = false
            self.loadMenuTable()
        }
         
    }
    
    func didFailFetchMenuItems() {
        self.showAlert(title: "", message: "Please check your network connection")
    }
    
}
