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
    
    static func toStores(pageIcon: String, id: Int, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let storesVC = storyboard.instantiateViewController(withIdentifier: "StoresVC") as! StoresVC
        storesVC.modalPresentationStyle = .fullScreen
        storesVC.idReceived = id
        storesVC.pageIconReceived = pageIcon
        sender.present(storesVC, animated: true, completion: nil)
        
    }
    
    static func toVendorProfile(id: Int, sender: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vendorProfileVC = storyboard.instantiateViewController(withIdentifier: "VendorProfileVC") as! VendorProfileVC
        vendorProfileVC.modalPresentationStyle = .fullScreen
        vendorProfileVC.idReceived = id
        sender.present(vendorProfileVC, animated: true, completion: nil)
        
    }
    
}
