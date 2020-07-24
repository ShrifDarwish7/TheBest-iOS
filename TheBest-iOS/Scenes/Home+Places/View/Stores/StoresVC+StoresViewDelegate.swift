//
//  StoresVC+StoresViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension StoresVC: StoresViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didSuccessfullyFetchingFilters(_ result: SubCategories) {
        
        self.filters = result
        if (self.filters?.items.count)! > 0{
            self.filters?.items[0].selected = true
            self.storesViewPresenter?.getPlacesBy(categoryId: (self.filters?.items[0].id)!)
        }
        self.loadFiltersCollectionView()
        
    }
    
    func didFailFetchingFilters() {
        self.showAlert(title: "", message: "Please check your network connection")        
    }
    
    func didSuccessfullyFetchingFilteringResult(_ result: Places) {
        
        self.places = result
        if (self.places?.items.count)! > 0{
            self.storeTableView.isHidden = false
            self.emptyCategoryLabel.isHidden = true
        }else{
            self.emptyCategoryLabel.isHidden = false
            self.storeTableView.isHidden = true
        }
        self.loadPlacesTable()
        
    }
    
    func didFailFetchingFilteringResult() {
        self.showAlert(title: "", message: "Please check your network connection")
    }
    
}
