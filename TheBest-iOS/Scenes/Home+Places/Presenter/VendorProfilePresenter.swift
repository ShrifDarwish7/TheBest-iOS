//
//  VendorProfilePresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol VendorViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didSuccessfullyFetchingMenuCategories(_ result: MenuCategories)
    func didFailFetchingMenuCategories()
    
    func didSuccessfullyFetchMenuItems(_ result: MenuIems)
    func didFailFetchMenuItems()
    
}

class VendorProfilePresenter{
    
    private var vendorViewDelegte: VendorViewDelegate?
    
    init(vendorViewDelegte: VendorViewDelegate) {
        self.vendorViewDelegte = vendorViewDelegte
    }
    
    func fetchMenuCategories(id: Int){
        
        self.vendorViewDelegte?.showSVProgress()
        
        VendorServices.getPlaceMenuCategoriesBy(id: id) { (menuCategories) in
            
            if let menuCategories = menuCategories{
                self.vendorViewDelegte?.didSuccessfullyFetchingMenuCategories(menuCategories)
            }else{
                self.vendorViewDelegte?.didFailFetchingMenuCategories()
            }
            
            self.vendorViewDelegte?.dismissSVProgress()
            
        }
        
    }
    
    func fetchMenuItems(id: Int){
        
        self.vendorViewDelegte?.showSVProgress()
        
        VendorServices.getMenuItems(id: id) { (menuItems) in
            
            if let menuItems = menuItems{
                self.vendorViewDelegte?.didSuccessfullyFetchMenuItems(menuItems)
            }else{
                self.vendorViewDelegte?.didFailFetchMenuItems()
            }
            
            self.vendorViewDelegte?.dismissSVProgress()
            
        }
        
    }
    
}
