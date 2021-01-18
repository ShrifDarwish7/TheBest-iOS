//
//  MarketPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol MarketsViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didCompleteWithNearByMarkets(_ result: NearByMarkets)
    func didFailFetchNearByMarkets()
    func didCompleteFiltering(_ result: [Item])
    func didFailFiltering()
    
}

extension MarketsViewDelegate{
    
    func showSVProgress() {}
    func dismissSVProgress() {}
    func didCompleteWithNearByMarkets(_ result: NearByMarkets) {}
    func didFailFetchNearByMarkets() {}
    func didCompleteFiltering(_ result: [Item]) {}
    func didFailFiltering() {}
    
}

class MarketsVCPresenter{
    
    private var marketsViewDelegate: MarketsViewDelegate?
    
    init(marketsViewDelegate: MarketsViewDelegate) {
        self.marketsViewDelegate = marketsViewDelegate
    }
    
    func getNearbyMarkets(categoryId: Int){
        
        self.marketsViewDelegate?.showSVProgress()
        
        MarketsServices.getNearByMarkets(categoryId: categoryId) { (nearbyMarkets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = nearbyMarkets{
                self.marketsViewDelegate?.didCompleteWithNearByMarkets(nearbyMarkets!)
            }else{
                self.marketsViewDelegate?.didFailFetchNearByMarkets()
            }
        }
        
    }
    
    func filterMarkets(cat: Int, country: String, government: String, district: String){
        self.marketsViewDelegate?.showSVProgress()
        MarketsServices.filterMarkets(cat: cat, country: country, government: government, district: district) { (markets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = markets{
                self.marketsViewDelegate?.didCompleteFiltering(markets!)
            }else{
                self.marketsViewDelegate?.didFailFiltering()
            }
        }
    }
    
    func getNearbyShera(categoryId: Int){
        
        self.marketsViewDelegate?.showSVProgress()
        
        MarketsServices.getNearByShera(categoryId: categoryId) { (nearbyMarkets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = nearbyMarkets{
                self.marketsViewDelegate?.didCompleteWithNearByMarkets(nearbyMarkets!)
            }else{
                self.marketsViewDelegate?.didFailFetchNearByMarkets()
            }
        }
        
    }
    
    func filterShera(cat: Int, country: String, government: String, district: String){
        self.marketsViewDelegate?.showSVProgress()
        MarketsServices.filterShera(cat: cat, country: country, government: government, district: district) { (markets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = markets{
                self.marketsViewDelegate?.didCompleteFiltering(markets!)
            }else{
                self.marketsViewDelegate?.didFailFiltering()
            }
        }
    }
    
}
