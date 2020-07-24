//
//  HomeVC+HomeViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension HomeVC: HomeViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didSuccessfulyFetchSubCategories(_ categories: Categories) {
        
        self.categories = categories
        self.loadSubCategoriesCollection()
        self.subCategories.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.categoriesCollectionView.alpha = 0
            self.subCategories.alpha = 1
        }) { (_) in
            self.categoriesCollectionView.isHidden = true
        }
        
    }
    
    func didFailFetchSubCategories() {
        self.showAlert(title: "", message: "An error occured when fetching restaurants and cafes data")
    }
    
}
