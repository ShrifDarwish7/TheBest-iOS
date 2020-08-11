//
//  CheckoutPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/10/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol CheckoutViewDelegate {
    
    func didCompleteFetchingItemWith(_ result: [CartItemModel])
    func didCompletedWithError()
    func showSVProgress()
    func dismissSVProgress()
    func didCompletedPlaceOrder()
    func didFailPlaceOrder()
    
}

class CheckoutPresenter{
    
    private var checkoutViewDelegate: CheckoutViewDelegate?
    
    init(checkoutViewDelegate: CheckoutViewDelegate) {
        self.checkoutViewDelegate = checkoutViewDelegate
    }

    func fetchItems(){
        
        CartServices.getCartItems { (items) in
            if let items = items{
                self.checkoutViewDelegate?.didCompleteFetchingItemWith(items)
            }else{
                self.checkoutViewDelegate?.didCompletedWithError()
            }
        }
        
    }
    
    func placeOrder(parameters: [String: Any]){
        
        self.checkoutViewDelegate?.showSVProgress()
        
        PlaceOrder.place(parameters: parameters) { (placed) in
            self.checkoutViewDelegate?.dismissSVProgress()
            if placed{
                self.checkoutViewDelegate?.didCompletedPlaceOrder()
            }else{
                self.checkoutViewDelegate?.didFailPlaceOrder()
            }
        }
        
    }
  
}

