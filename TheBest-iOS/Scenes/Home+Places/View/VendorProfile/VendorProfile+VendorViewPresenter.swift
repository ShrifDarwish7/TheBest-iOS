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
        self.vendorImage.sd_setImage(with: URL(string: result.items.image)!)
        self.bgImage.sd_setImage(with: URL(string: result.items.image)!)
        if (self.menuCategories?.items.menuesCategories.count)! > 0{
            self.menuCategories?.items.menuesCategories[0].selected = true
            //self.storesViewPresenter?.getPlacesBy(categoryId: (self.filters?.items[0].id)!)
        }
        self.loadMenuCollection()
        
    }
    
    func didFailFetchingMenuCategories() {
        self.showAlert(title: "", message: "Please check your network connection")
    }
    
}
