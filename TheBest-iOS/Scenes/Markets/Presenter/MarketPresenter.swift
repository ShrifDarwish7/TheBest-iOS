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
    func didCompleteFiltering(_ result: Markets)
    func didFailFiltering()
    
}

extension MarketsViewDelegate{
    
    func showSVProgress() {}
    func dismissSVProgress() {}
    func didCompleteWithNearByMarkets(_ result: NearByMarkets) {}
    func didFailFetchNearByMarkets() {}
    func didCompleteFiltering(_ result: Markets) {}
    func didFailFiltering() {}
    
}

class MarketsVCPresenter{
    
    private var marketsViewDelegate: MarketsViewDelegate?
    
    init(marketsViewDelegate: MarketsViewDelegate) {
        self.marketsViewDelegate = marketsViewDelegate
    }
    
    func getNearbyMarkets(){
        
        self.marketsViewDelegate?.showSVProgress()
        
        MarketsServices.getNearByMarkets { (nearbyMarkets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = nearbyMarkets{
                self.marketsViewDelegate?.didCompleteWithNearByMarkets(nearbyMarkets!)
            }else{
                self.marketsViewDelegate?.didFailFetchNearByMarkets()
            }
        }
        
    }
    
    func filterMarkets(country: String, government: String, district: String){
        self.marketsViewDelegate?.showSVProgress()
        MarketsServices.filterMarkets(country: country, government: government, district: district) { (markets) in
            self.marketsViewDelegate?.dismissSVProgress()
            if let _ = markets{
                self.marketsViewDelegate?.didCompleteFiltering(markets!)
            }else{
                self.marketsViewDelegate?.didFailFiltering()
            }
        }
    }
    
}
