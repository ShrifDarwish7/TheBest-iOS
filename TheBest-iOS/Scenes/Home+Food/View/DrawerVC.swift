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
    @IBOutlet weak var howToUse: UIStackView!
    @IBOutlet weak var share: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var balance: UIStackView!
    @IBOutlet weak var aboutUs: UIStackView!
    @IBOutlet weak var changeLang: UIStackView!
    @IBOutlet weak var chngeLngLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBlockView), name: NSNotification.Name("opened"), object: nil)
        
        blockView.addTapGesture { (_) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        drawerView.setupShadow()
        chngeLngLbl.text = "Change language".localized
        
        backBtn.onTap {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            self.blockView.alpha = 0
            
        }
        
        username.text = AuthServices.instance.user.name
        loadActions()
    }
    
    func loadActions(){
        
        logout.addTapGesture { (_) in
            //AuthServices.logout()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
           Router.toLogin(sender: self)
           // self.navigationController?.popToRootViewController(animated: true)
            AuthServices.instance.isLogged = false
        }
        
        changeLang.addTapGesture { (_) in
            let alert = UIAlertController(title: "", message: "Choose language".localized, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "English US".localized, style: .default, handler: { (_) in
                AppDelegate.changeLangTo("en")
            }))
            alert.addAction(UIAlertAction(title: "Arabic".localized, style: .default, handler: { (_) in
                AppDelegate.changeLangTo("ar")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        lastOrders.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toLastOrders(sender: self)
        }
        
        home.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toHome(sender: self)
        }
        
        howToUse.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toHowToUse(sender: self)
        }
        
        share.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toShare(sender: self)
        }
        
        profileImage.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toProfile(sender: self)
        }
        
        balance.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toBalance(sender: self)
        }
        
        aboutUs.addTapGesture { (_) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
            Router.toTerms(sender: self)
        }
        
    }
    
    @objc func showBlockView(){
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
             self.blockView.alpha = 0.5
        }) { (_) in
            
        }
    }

}
