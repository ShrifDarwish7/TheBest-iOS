//
//  HowToUseVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class HowToUseVC: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var catsCollectionView: UICollectionView!
    @IBOutlet weak var foodGuideView: UIScrollView!
    @IBOutlet weak var taxiGuide: UIScrollView!
    
    var appCategories = [AppCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        
        appCategories.append(AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe", selected: true))
        appCategories.append(AppCategory(icon: UIImage(named: "taxi_icon562"), name: "Taxi services"))
        appCategories.append(AppCategory(icon: UIImage(named: "car_icon161"), name: "Car rent"))
        appCategories.append(AppCategory(icon: UIImage(named: "special_need_icon451"), name: "Special need car"))
        appCategories.append(AppCategory(icon: UIImage(named: "market_icon46"), name: "Markets & Associations"))
        //appCategories.append(AppCategory(icon: UIImage(named: "azzount_icon"), name: "Monthly  Account"))
        appCategories.append(AppCategory(icon: UIImage(named: "road_icon6463"), name: "Road rescue services"))
        appCategories.append(AppCategory(icon: UIImage(named: "furniture_icon159"), name: "Furniture transporting"))

        loadCollection()
        loadUI()
        
    }
    
    @objc func closeDrawer(){
        Drawer.close(drawerPosition, self)
    }
    
    func loadUI(){
        
        drawerPosition.constant = self.view.frame.width
        upperView.setupShadow()
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        drawerBtn.onTap {
            Drawer.open(self.drawerPosition, self)
        }
    }

}