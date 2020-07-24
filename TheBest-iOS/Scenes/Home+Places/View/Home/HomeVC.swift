//
//  HomeVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var drawerBtn: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var drawerPosition: NSLayoutConstraint!
    @IBOutlet weak var subCategories: UICollectionView!
    
    var appCategories = [AppCategory]()
    var homeViwPresenter: HomeViewPresenter?
    var categories: Categories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
            default:
                break
                
            }
            
        }
        
        
    }
    
    func loadSubCategoriesCollection(){
        
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        subCategories.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        
        subCategories.numberOfItemsInSection { (_) -> Int in
            
            return (self.categories?.mainCategories.count)!
            
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.subCategories.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: index) as! CategoriesCollectionViewCell
            cell.loadFrom(category: (self.categories?.mainCategories[index.row])!)

            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            
            return CGSize(width: self.categoriesCollectionView.frame.width/2 - 10, height: 200)
            
        }.didSelectItemAt { (index) in
            
            Router.toStores(pageIcon: (self.categories?.mainCategories[index.row].image)! , id: (self.categories?.mainCategories[index.row].id)!, sender: self)
            
        }
        
        
    }

}
