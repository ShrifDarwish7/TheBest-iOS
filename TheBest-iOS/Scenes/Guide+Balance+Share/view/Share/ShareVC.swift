//
//  ShareVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ShareVC: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        
        for v in views{
            v.layer.cornerRadius = 15
            v.setupShadow()
        }
        
        loadUI()
    }
    
    func loadUI(){
        
        drawerPosition.constant = "lang".localized == "ar" ? self.view.frame.width : -self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
    }
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }

}
