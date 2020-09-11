//
//  CheckoutVC+CheckoutViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/10/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension CheckoutVC: CheckoutViewDelegate{
    
    func showSVProgress() {
        SVProgressHUD.show()
    }
    
    func dismissSVProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompleteFetchingItemWith(_ result: [CartItemModel]) {
        self.cartItems = result
        self.itemsCount.text = "\(result.count)"
        
        var addressToSend: String?
        var totalToSend = 0.0
        var ids = [String]()
        var variations = [String]()
        
        for item in result{
            totalToSend = totalToSend + Double(item.price! * Double(item.quantity!))
            ids.append("\(item.id ?? 0)")
            variations.append("\(item.variation ?? 0)")
        }
        
        if let _ = SharedData.userLat, let _ = SharedData.userLng{
            SVProgressHUD.show()
            TripsServices.getAddressFromGoogleMapsAPI(location: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)") { (address) in
                SVProgressHUD.dismiss()
                if let _ = address{
                    addressToSend = address!
                }
            }
        }
        
        var parameters = [

            "lat": "\(SharedData.userLat ?? 0.0)" ,
            "lng": "\(SharedData.userLng ?? 0.0)",
            "address": addressToSend ?? "",
            "phone": AuthServices.instance.user.user?.phone ?? "",
            "total": "\(totalToSend)",
            "comment": "any comment for the order",
         //   "count": "\(result.count)",
            "cat_id": UserDefaults.init().string(forKey: "food_markets_flag")!

            ] as [String : Any]
        
        for i in 0...ids.count-1{
            parameters.updateValue(ids[i], forKey: "product_id[\(i)]")
        }
        
        for i in 0...variations.count-1{
            parameters.updateValue(variations[i], forKey: "variation_id[\(i)]")
        }
        
        print("hereChekcOutPrms",parameters)
        self.checkoutParameters = parameters
        
    }
    
    func didCompletedWithError() {
        
    }
     
    func didCompletedPlaceOrder() {
        CartServices.clearCart()
        self.orderDoneHint.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.orderDoneHint.alpha = 1
        }) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.orderDoneHint.alpha = 0
                }) { (_) in
                    self.orderDoneHint.isHidden = true
                }
            }
        }
    }
    
    func didFailPlaceOrder() {
        print("didFailPlaceOrder")
    }
    
}
