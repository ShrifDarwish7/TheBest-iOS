//
//  CartVC+CartViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

extension CartVC: CartViewDelegate{
   
    func didCompleteFetchingItemWith(_ result: [CartItemModel]) {
        
        self.cartItems = result
        self.loadTableView()
        
    }
    
    func didCompletedWithError() {
        print("didCompletedWithError")
    }
    
    func didUpdateQuantity() {
        self.cartPresenter?.fetchItems()
    }
    
    func didFailUpdatingQuantity() {
        print("didFailUpdatingQuantity")
    }
    
    func didRemoveItem() {
           self.cartPresenter?.fetchItems()
       }
       
       func didFailRemoveItem() {
           
       }

}
