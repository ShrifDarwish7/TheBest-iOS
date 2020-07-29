//
//  ProductPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreData

protocol ProductViewDelegate {
    
    func didCompleteAddingToCart()
    func didFailAddingToCart()
    func mustClearCart()
    
}

class ProductPresenter{
    
    private var productViewDelegate: ProductViewDelegate?
    
    init(productViewDelegate: ProductViewDelegate) {
        self.productViewDelegate = productViewDelegate
    }
    
    func addToCart(vendorId: Int, arg: CartItemModel){
        
        if vendorId == UserDefaults.init().integer(forKey: "cart_associated_vendorId") && UserDefaults.init().integer(forKey: "cart_associated_vendorId") != 0{
            CartServices.addToCart(vendorId: vendorId, arg: arg) { (completed) in
                if completed{
                    self.productViewDelegate?.didCompleteAddingToCart()
                }else{
                    self.productViewDelegate?.didFailAddingToCart()
                }
            }
        }else{
            self.productViewDelegate?.mustClearCart()
        }
         
    }
    
}
