//
//  CartPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol CartViewDelegate {
    
    func didCompleteFetchingItemWith(_ result: [CartItemModel])
    func didCompletedWithError()
    func didUpdateQuantity()
    func didFailUpdatingQuantity()
    func didRemoveItem()
    func didFailRemoveItem()
    
}

class CartPresenter{
    
    private var cartViewDelegate: CartViewDelegate?
    
    init(cartViewDelegate: CartViewDelegate) {
        self.cartViewDelegate = cartViewDelegate
    }
  
    func fetchItems(){
        
        CartServices.getCartItems { (items) in
            if let items = items{
                self.cartViewDelegate?.didCompleteFetchingItemWith(items)
            }else{
                self.cartViewDelegate?.didCompletedWithError()
            }
        }
        
    }
    
    func updateQuantity(newValue: Int, id: Int){
        
        CartServices.updateQuantity(newValue: newValue, id: id) { (updated) in
            if updated{
                self.cartViewDelegate?.didUpdateQuantity()
            }else{
                self.cartViewDelegate?.didFailUpdatingQuantity()
            }
        }
        
    }
    
    func removeAt(id: Int){
        
        CartServices.removeAt(id: id) { (removed) in
            if removed{
                self.cartViewDelegate?.didRemoveItem()
            }else{
                self.cartViewDelegate?.didFailRemoveItem()
            }
        }
        
    }
    
}
