//
//  HomePresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol HomeViewDelegate {
    func showSVProgress()
    func dismissSVProgress()
    func didSuccessfulyFetchSubCategories(_ categories: Categories)
    func didFailFetchSubCategories()
    func didCompleteFetchAllMarketsCategories(_ result: MarketTypes)
    func didFailFetchAllMarketsCategories()
    func didCompleteVegetableWith(_ result: [MainCategory]?, _ error: Error?)
    func didCompleteWithRoadServicesCategories(_ categories: RoadServicesCategoriesResponse?)
}

class HomeViewPresenter{
    
    private var homeViewDelegate: HomeViewDelegate?
    
    init(homeViewDelegate: HomeViewDelegate) {
        self.homeViewDelegate = homeViewDelegate
    }
    
    func getMainRestaurantsCategories(){
        
        self.homeViewDelegate?.showSVProgress()
        
        CategoriesServices.getMainCategories { (categories) in
                        
            if let categories = categories{
                self.homeViewDelegate?.didSuccessfulyFetchSubCategories(categories)
            }else{
                self.homeViewDelegate?.didFailFetchSubCategories()
            }
            
            self.homeViewDelegate?.dismissSVProgress()
            
        }
        
    }
    
    func getAllMarketsCategories(){
        
        self.homeViewDelegate?.showSVProgress()
        
        CategoriesServices.getMarketTypes { (marketTypes) in
            self.homeViewDelegate?.dismissSVProgress()
            if let _  = marketTypes{
                self.homeViewDelegate?.didCompleteFetchAllMarketsCategories(marketTypes!)
            }else{
                self.homeViewDelegate?.didFailFetchAllMarketsCategories()
            }
        }
        
    }
    
    func getVegetableCategories(){
        
        self.homeViewDelegate?.showSVProgress()
        
        CategoriesServices.getSheraTypes { (marketTypes) in
            self.homeViewDelegate?.dismissSVProgress()
            if let _  = marketTypes{
                self.homeViewDelegate?.didCompleteVegetableWith(marketTypes!, nil)
            }else{
                self.homeViewDelegate?.didCompleteVegetableWith(marketTypes!, nil)
            }
        }
        
    }
    
    func getRoadServicesCategories(){
        
        self.homeViewDelegate?.showSVProgress()
        
        CategoriesServices.getRoadServicesCategories { (categories) in
                        
            if let categories = categories{
                self.homeViewDelegate?.didCompleteWithRoadServicesCategories(categories)
            }else{
                self.homeViewDelegate?.didCompleteWithRoadServicesCategories(nil)
            }
            
            self.homeViewDelegate?.dismissSVProgress()
            
        }
        
    }
    
}
