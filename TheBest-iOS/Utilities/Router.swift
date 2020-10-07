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
        sender.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    static func toLogin(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    static func toRegister(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        registerVC.modalPresentationStyle = .fullScreen
       sender.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    static func toStores(pageIcon: String, id: Int, sender: UIViewController, from: String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let storesVC = storyboard.instantiateViewController(withIdentifier: "StoresVC") as! StoresVC
        storesVC.modalPresentationStyle = .fullScreen
        storesVC.idReceived = id
        storesVC.pageIconReceived = pageIcon
        storesVC.from = from
//        if from == "markets"{
//            storesVC.pageIcon.image = UIImage(named: "marketsIcon")
//            storesVC.upperIcon.backgroundColor = UIColor(named: "MarketsColor")
//            SharedData.food_markets_flag = 1
//        }
        sender.navigationController?.pushViewController(storesVC, animated: true)
        
    }
    
    static func toVendorProfile(id: Int, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vendorProfileVC = storyboard.instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
        vendorProfileVC.modalPresentationStyle = .fullScreen
        vendorProfileVC.idReceived = id
       sender.navigationController?.pushViewController(vendorProfileVC, animated: true)
        
    }
    
    static func toProduct(item: RestaurantMenuItem, vendorName: String, vendorImage: String, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productVC = storyboard.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        productVC.modalPresentationStyle = .fullScreen
        productVC.itemReceived = item
        productVC.vendorName = vendorName
        productVC.vendorImage = vendorImage
        sender.navigationController?.pushViewController(productVC, animated: true)
        
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
                    sender.navigationController?.pushViewController(cartVC, animated: true)
                }
            }
        }
        
    }
    
    static func toTaxiOrder(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let taxiOrderVC = storyboard.instantiateViewController(withIdentifier: "TaxiOrderVC") as! TaxiOrderVC
        taxiOrderVC.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(taxiOrderVC, animated: true)
        
    }
    
    static func toCheckout(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        checkoutVC.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(checkoutVC, animated: true)
        
    }
    
    static func toMarkets(sender: UIViewController, id: Int, type: String){
        
        let storyboard = UIStoryboard(name: "Markets", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MarketsVC") as! MarketsVC
        vc.catReceivedId = id
        vc.modalPresentationStyle = .fullScreen
        vc.type = type
        if type == "markets"{
            SharedData.food_markets_flag = 2
        }else{
            SharedData.food_markets_flag = 3
        }
        
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func toFilterMarkets(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Markets", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toSpecialNeedCar(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SpecialNeedCarVC") as! SpecialNeedCarVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toLastOrders(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LastOrdersVC") as! LastOrdersVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toFurniture(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FurnitureVC") as! FurnitureVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toCarRent(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CarRentVC") as! CarRentVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toHowToUse(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Guide+Profile+Balance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HowToUseVC") as! HowToUseVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toShare(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Guide+Profile+Balance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShareVC") as! ShareVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toProfile(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Guide+Profile+Balance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toBalance(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Guide+Profile+Balance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BalanceVC") as! BalanceVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func toTerms(sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Guide+Profile+Balance", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
        vc.modalPresentationStyle = .fullScreen
        sender.navigationController?.pushViewController(vc, animated: true)
        
    }
   
}
