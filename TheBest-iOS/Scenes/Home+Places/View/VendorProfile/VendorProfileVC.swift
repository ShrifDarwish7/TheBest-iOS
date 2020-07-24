//
//  VendorProfileVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class VendorProfileVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var menuCategoriesCollection: UICollectionView!
    
    var menuCategories: MenuCategories?
    var idReceived: Int?
    var vendorViewPresenter: VendorProfilePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vendorViewPresenter = VendorProfilePresenter(vendorViewDelegte: self)
        vendorViewPresenter?.fetchMenuCategories(id: idReceived!)
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
        vendorImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vendorImage.layer.borderWidth = 2
        
        menuContainer.layer.cornerRadius = 30
        filterBtnView.layer.cornerRadius = 10
        filterBtnView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        filterBtnView.layer.borderWidth = 1
        
    }
    
    func loadMenuCollection(){
        
        let nib = UINib(nibName: "MenuFilterCollectionViewCell", bundle: nil)
        self.menuCategoriesCollection.register(nib, forCellWithReuseIdentifier: "MenuFilterCell")
        
        self.menuCategoriesCollection.numberOfItemsInSection { (_) -> Int in
            return (self.menuCategories?.items.menuesCategories.count)!
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell  = self.menuCategoriesCollection.dequeueReusableCell(withReuseIdentifier: "MenuFilterCell", for: index) as! MenuFilterCollectionViewCell
            if self.menuCategories?.items.menuesCategories[index.row].selected ?? false{
                cell.underLine.isHidden = false
                cell.menuCategory.textColor =  UIColor.black
            }else{
                cell.underLine.isHidden = true
                cell.menuCategory.textColor = UIColor(named: "FontGrayColor")
            }
            cell.menuCategory.text = self.menuCategories?.items.menuesCategories[index.row].name
            
            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            return CGSize(width: 80, height:  60)
        }.didSelectItemAt { (index) in
            
            for i in 0...(self.menuCategories?.items.menuesCategories.count)!-1{
                self.menuCategories?.items.menuesCategories[i].selected = false
            }
            
            self.menuCategories?.items.menuesCategories[index.row].selected = true
            self.menuCategoriesCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.menuCategoriesCollection.reloadData()
            
        }
        
    }
    

}
