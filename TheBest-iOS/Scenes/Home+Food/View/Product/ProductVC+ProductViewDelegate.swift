//
//  ProductVC+ProductViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension ProductVC: ProductViewDelegate{
    
    func didCompleteAddingToCart() {
        self.showAlert(title: "", message: "Product added successfully")
    }
    
    func didFailAddingToCart() {
        print("didFailAddingToCart")
    }
    
    func mustClearCart() {
        
        let alert = UIAlertController(title: "", message: "Cart contains products from another vendor, to add this product you must clear your cart", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { (_) in
            
            CartServices.clearCart()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
