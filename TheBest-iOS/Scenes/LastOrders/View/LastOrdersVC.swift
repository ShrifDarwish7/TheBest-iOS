//
//  LastOrdersVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/25/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class LastOrdersVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var catsCollectionView: UICollectionView!
    @IBOutlet weak var lastOrdersTable: UITableView!
    @IBOutlet weak var emptyHistory: UILabel!
    @IBOutlet weak var lastTripsTable: UITableView!
    
    var appCategories = [AppCategory]()
    var foodOrders: [Order]?
    var trips: [Trip]?
    var ordersHistoryPresenter: OrdersHistoryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon1"), name: "Restaurants & Cafe".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon2"), name: "Taxi services".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon3"), name: "Car rent".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon4"), name: "Special need car".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon5"), name: "Markets & Associations".localized))
        //appCategories.append(AppCategory(icon: UIImage(named: "category_icon6"), name: "Monthly  Account".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon7"), name: "Road rescue services".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon8"), name: "Furniture transporting".localized))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon5"), name: "Vegetable".localized))
        
        ordersHistoryPresenter = OrdersHistoryPresenter(ordersHistoryViewDelegate: self)
        ordersHistoryPresenter?.getFoodOrdersHistory(id: 1)
        
        loadUI()
        loadCollection()
        
    }
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }
    
    func loadUI(){
        
        drawerPosition.constant = "lang".localized == "ar" ? self.view.frame.width : -self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
