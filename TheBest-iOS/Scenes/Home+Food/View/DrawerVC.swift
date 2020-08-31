//
//  DrawerVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class DrawerVC: UIViewController {

    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var drawerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logout: UIStackView!
    @IBOutlet weak var lastOrders: UIStackView!
    @IBOutlet weak var home: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBlockView), name: NSNotification.Name("opened"), object: nil)
        
        blockView.addTapGesture { (_) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        drawerView.setupShadow()
        
        backBtn.onTap {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        username.text = AuthServices.instance.user.user?.name
        loadActions()
    }
    
    func loadActions(){
        
        logout.addTapGesture { (_) in
            //AuthServices.logout()
            Router.toLogin(sender: self)
            AuthServices.instance.isLogged = false
        }
        
        lastOrders.addTapGesture { (_) in
            Router.toLastOrders(sender: self)
        }
        
        home.addTapGesture { (_) in
            Router.toHome(sender: self)
        }
        
    }
    
    @objc func showBlockView(){
        UIView.animate(withDuration: 0.2, delay: 0.35, options: [], animations: {
             self.blockView.alpha = 0.5
        }) { (_) in
            
        }
    }

}
