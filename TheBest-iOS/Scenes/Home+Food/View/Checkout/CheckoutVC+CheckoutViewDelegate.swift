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
        
//        var addressToSend: String?
        var totalToSend = 0.0
        
//        if let _ = SharedData.userLat, let _ = SharedData.userLng{
//            SVProgressHUD.show()
//            TripsServices.getAddressFromGoogleMapsAPI(location: "\(SharedData.userLat ?? 0),\(SharedData.userLng ?? 0)") { (address) in
//                SVProgressHUD.dismiss()
//                if let _ = address{
//                    addressToSend = address?.formattedAddress
//                }
//            }
//        }
        
        
        var parameters = [

            "lat": userAddress!.coordinates.split(separator: ",")[0] ,
            "lng": userAddress!.coordinates.split(separator: ",")[1],
            "address": String(data: try! JSONEncoder.init().encode(userAddress!), encoding: .utf8)!,
            "phone": AuthServices.instance.user.phone ?? "" ,
            "comment": self.notesTV.text!,
         //   "count": "\(result.count)",
            "cat_id": UserDefaults.init().string(forKey: "food_markets_flag")!

            ] as [String : Any]
        
        for i in 0...result.count-1{
            let temp = (result[i].attributeOnePrice ?? 0.0) + (result[i].attributeTwoPrice ?? 0.0)
            let totalVariationsPrice =  temp + (result[i].attributeThreePrice ?? 0.0)
            totalToSend = totalToSend + Double((result[i].price! + totalVariationsPrice) * Double(result[i].quantity!))
            parameters.updateValue(result[i].id!, forKey: "product_id[\(i)]")
            
            if let _ = result[i].attributeOne{
                parameters.updateValue(result[i].attributeOne!, forKey: "attribute_body[\(i)]")
            }
            if let _ = result[i].attributeTwo{
                parameters.updateValue(result[i].attributeTwo!, forKey: "attribute_body_two[\(i)]")
            }
            if let _ = result[i].attributeThree{
                parameters.updateValue(result[i].attributeThree!, forKey: "attribute_body_three[\(i)]")
            }
            parameters.updateValue(result[i].quantity ?? 1, forKey: "count[\(i)]")
            
        }
        
        parameters.updateValue("\(totalToSend)", forKey: "total")
        
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
