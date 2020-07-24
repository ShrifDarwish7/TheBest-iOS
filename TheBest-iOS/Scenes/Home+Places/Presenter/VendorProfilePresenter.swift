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
    
}
