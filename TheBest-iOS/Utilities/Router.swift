//
//  Router.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

class Router{
    
    static func toHome(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC.modalPresentationStyle = .fullScreen
        sender.present(homeVC, animated: true, completion: nil)
        
    }
    
    static func toLogin(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        sender.present(loginVC, animated: true, completion: nil)
        
    }
    
    static func toRegister(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        registerVC.modalPresentationStyle = .fullScreen
        sender.present(registerVC, animated: true, completion: nil)
        
    }
    
    static func toStores(pageIcon: String, id: Int, sender: UIViewController, from: String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let storesVC = storyboard.instantiateViewController(withIdentifier: "StoresVC") as! StoresVC
        storesVC.modalPresentationStyle = .fullScreen
        storesVC.idReceived = id
        storesVC.pageIconReceived = pageIcon
//        if from == "markets"{
//            storesVC.pageIcon.image = UIImage(named: "marketsIcon")
//            storesVC.upperIcon.backgroundColor = UIColor(named: "MarketsColor")
//        }
        sender.present(storesVC, animated: true, completion: nil)
        
    }
    
    static func toVendorProfile(id: Int, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vendorProfileVC = storyboard.instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
        vendorProfileVC.modalPresentationStyle = .fullScreen
        vendorProfileVC.idReceived = id
        sender.present(vendorProfileVC, animated: true, completion: nil)
        
    }
    
    static func toProduct(item: RestaurantMenuItem, vendorName: String, vendorImage: String, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productVC = storyboard.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        productVC.modalPresentationStyle = .fullScreen
        productVC.itemReceived = item
        productVC.vendorName = vendorName
        productVC.vendorImage = vendorImage
        sender.present(productVC, animated: true, completion: nil)
        
    }
    
    static func toCart(sender: UIViewController){
        
        CartServices.getCartItems { (result) in
            if let result = result{
                
                if result.isEmpty{
                    sender.showAlert(title: "", message: "Your cart is empty")
                    return
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let cartVC = storyboard.instantiateViewController(withIdentifier: "CartVC") as! CartVC
                    cartVC.modalPresentationStyle = .fullScreen
                    sender.present(cartVC, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    static func toTaxiOrder(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let taxiOrderVC = storyboard.instantiateViewController(withIdentifier: "TaxiOrderVC") as! TaxiOrderVC
        taxiOrderVC.modalPresentationStyle = .fullScreen
        sender.present(taxiOrderVC, animated: true, completion: nil)
        
    }
    
    static func toCheckout(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        checkoutVC.modalPresentationStyle = .fullScreen
        sender.present(checkoutVC, animated: true, completion: nil)
        
    }
    
    static func toMarkets(sender: UIViewController, id: Int){
        
        let storyboard = UIStoryboard(name: "Markets", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MarketsVC") as! MarketsVC
        vc.catReceivedId = id
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
        
    }
    
    static func toFilterMarkets(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Markets", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
        
    }
    
    static func toSpecialNeedCar(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SpecialNeedCarVC") as! SpecialNeedCarVC
        vc.modalPresentationStyle = .fullScreen
        sender.present(vc, animated: true, completion: nil)
        
    }
   
}
