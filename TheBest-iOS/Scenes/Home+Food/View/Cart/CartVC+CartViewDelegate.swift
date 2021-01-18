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
        
        if result.isEmpty{
            self.empty.isHidden = false
            self.cartItemsTableView.isHidden = true
            self.checkOutView.isHidden = true
            self.detailsStack.isHidden = true
            for img in images{
                img.isHidden = true
            }
        }else{
            self.cartItems = result
            self.itemsCount.text = "\(self.cartItems?.count ?? 1)"
            updateTotalOrder()
            self.loadTableView()
        }
        
    }
    
    func didCompletedWithError() {
        self.empty.isHidden = false
        self.cartItemsTableView.isHidden = true
        self.checkOutView.isHidden = true
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
