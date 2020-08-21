//
//  HomeVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var welcomeMsg: UILabel!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var subCategories: UICollectionView!
    @IBOutlet weak var blurBlockView: UIVisualEffectView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var allowBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    
    var appCategories = [AppCategory]()
    var homeViwPresenter: HomeViewPresenter?
    var categories: [MainCategory]?
    let locationManager = CLLocationManager()
    var nextView: Next = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeMsg.text = "Hey " + (AuthServices.instance.user.user?.name ?? "") + ", Choose your category"
        
        homeViwPresenter = HomeViewPresenter(homeViewDelegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeDrawer), name: NSNotification.Name(rawValue: "CloseDrawer"), object: nil)
        
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon1"), name: "Restaurants & Cafe"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon2"), name: "Taxi services"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon3"), name: "Car rent"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon4"), name: "Special need car"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon5"), name: "Markets & Associations"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon6"), name: "Monthly  Account"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon7"), name: "Road rescue services"))
        appCategories.append(AppCategory(icon: UIImage(named: "category_icon8"), name: "Furniture transporting"))
        
        loadUI()
        loadCategoriesCollection()
                
        popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
        popupView.layer.cornerRadius = 15
        allowBtn.layer.cornerRadius = 15
        denyBtn.layer.cornerRadius = 15
        
        denyBtn.onTap {
            self.blurBlockView.isHidden = true
            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        
        allowBtn.onTap {
           if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            self.blurBlockView.isHidden = true
            self.popupView.transform = CGAffineTransform(scaleX: 0, y: 0    )
        }
        
        backBtn.onTap {
            
            self.categoriesCollectionView.isHidden = false
            
            UIView.animate(withDuration: 0.1) {
                self.backBtn.isHidden = true
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.categoriesCollectionView.alpha = 1
                self.subCategories.alpha = 0
                
            }) { (_) in
                self.subCategories.isHidden = true
            }
            
        }
        
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
    
    
    func loadCategoriesCollection(){
        
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        
        categoriesCollectionView.numberOfItemsInSection { (_) -> Int in
            
            return self.appCategories.count
            
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: index) as! CategoriesCollectionViewCell
            cell.loadFrom(appCategory: self.appCategories[index.row])

            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            
            return CGSize(width: self.categoriesCollectionView.frame.width/2 - 10, height: 200)
            
        }.didSelectItemAt { (index) in
            
            switch index.row{
                
            case 0:
                
                self.homeViwPresenter?.getMainRestaurantsCategories()
                
            case 1:
                
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways , .authorizedWhenInUse:
                    Router.toTaxiOrder(sender: self)
                default:
                    self.askForLocationAlert()
                }
                
            case 3:
                
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways , .authorizedWhenInUse:
                    Router.toSpecialNeedCar(sender: self)
                default:
                    self.askForLocationAlert()
                }
                
            case 4:
                
                self.homeViwPresenter?.getAllMarketsCategories()
                
            default:
                break
                
            }
            
        }
        
        
    }
    
    func askForLocationAlert(){
        self.blurBlockView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [], animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (_) in
            
        }
    }
    
    func loadSubCategoriesCollection(color: UIColor){
        
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        subCategories.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        
        subCategories.numberOfItemsInSection { (_) -> Int in
            
            return (self.categories?.count)!
            
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.subCategories.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: index) as! CategoriesCollectionViewCell
            cell.loadFrom(category: (self.categories?[index.row])!)
            cell.container.backgroundColor = color

            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            
            return CGSize(width: self.categoriesCollectionView.frame.width/2 - 10, height: 200)
            
        }.didSelectItemAt { (index) in
            
            switch self.nextView{
                
            case .markets:
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways , .authorizedWhenInUse:
                    Router.toMarkets(sender: self, id: self.categories![index.row].id)
                default:
                    self.askForLocationAlert()
                }
            case .restaurants:
                Router.toStores(pageIcon: (self.categories?[index.row].image)! , id: (self.categories?[index.row].id)!, sender: self, from: "")
            default:
                break
                
            }
            
        }
        
    }

}

enum Next{
    
    case restaurants
    case markets
    case none
    
}
