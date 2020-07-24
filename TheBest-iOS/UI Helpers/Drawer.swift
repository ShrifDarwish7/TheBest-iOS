//
//  Drawer.swift
//  Tujjar
//
//  Created by Sherif Darwish on 6/8/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

class Drawer{
    
    static func open(_ constraint: NSLayoutConstraint, _ vc: UIViewController){
                
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            constraint.constant = 0
            vc.view.layoutIfNeeded()
            NotificationCenter.default.post(name: NSNotification.Name("opened"), object: nil)
            
        }) { (_) in
            
        }
        
    }
    
    static func close(_ constraint: NSLayoutConstraint, _ vc: UIViewController){
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            
            constraint.constant = vc.view.frame.width
            vc.view.layoutIfNeeded()
            
        }) { (_) in
        }
    }
    
}
