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
        
        self.categories = categories.mainCategories
        self.loadSubCategoriesCollection(color: UIColor(named: "BtnsColor")!)
        self.nextView = .restaurants
        self.subCategories.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.categoriesCollectionView.alpha = 0
            self.subCategories.alpha = 1
            self.backBtn.isHidden = false
        }) { (_) in
            self.categoriesCollectionView.isHidden = true
        }
        
    }
    
    func didFailFetchSubCategories() {
        self.showAlert(title: "", message: "An error occured when fetching restaurants and cafes data")
    }
    
    func didCompleteFetchAllMarketsCategories(_ result: MarketTypes) {
        self.categories = result.items
        self.loadSubCategoriesCollection(color: UIColor(named: "MarketsColor")!)
        self.nextView = .markets
        self.subCategories.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.categoriesCollectionView.alpha = 0
            self.subCategories.alpha = 1
            self.backBtn.isHidden = false
        }) { (_) in
            self.categoriesCollectionView.isHidden = true
        }
    }
    
    func didFailFetchAllMarketsCategories() {
        
    }
    
    func didCompleteVegetableWith(_ result: MarketTypes?, _ error: Error?) {
        if let result = result{
            
            self.categories = result.items
            self.loadSubCategoriesCollection(color: UIColor(named: "vegColor")!)
            self.nextView = .vegetable
            self.subCategories.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.categoriesCollectionView.alpha = 0
                self.subCategories.alpha = 1
                self.backBtn.isHidden = false
            }) { (_) in
                self.categoriesCollectionView.isHidden = true
            }
            
        }
    }
    
}
