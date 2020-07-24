//
//  StoresPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol StoresViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didSuccessfullyFetchingFilters(_ result: SubCategories)
    func didFailFetchingFilters()
    func didSuccessfullyFetchingFilteringResult(_ result: Places)
    func didFailFetchingFilteringResult()
    
}

class StoresViewPresenter{
    
    private var storesViewDelegate: StoresViewDelegate?
    
    init(storesViewDelegate: StoresViewDelegate) {
        self.storesViewDelegate = storesViewDelegate
    }
    
    func getCategoriesBy(id: Int){
        
        self.storesViewDelegate?.showSVProgress()
        
        CategoriesServices.getCategoriesBy(id: id) { (subCategories) in
            
            if let subCategories = subCategories{
                self.storesViewDelegate?.didSuccessfullyFetchingFilters(subCategories)
            }else{
                self.storesViewDelegate?.didFailFetchingFilters()
            }
            
            self.storesViewDelegate?.dismissSVProgress()
            
        }
        
    }
    
    func getPlacesBy(categoryId: Int){
        
        storesViewDelegate?.showSVProgress()
        
        CategoriesServices.getPlacesBy(categoryId: categoryId) { (places) in
            
            if let places = places{
                self.storesViewDelegate?.didSuccessfullyFetchingFilteringResult(places)
            }else{
                self.storesViewDelegate?.didFailFetchingFilteringResult()
            }
            
            self.storesViewDelegate?.dismissSVProgress()
            
        }
        
    }
    
}
