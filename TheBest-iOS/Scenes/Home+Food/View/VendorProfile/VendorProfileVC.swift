//
//  VendorProfileVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class VendorProfileVC: UIViewController , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var menuCategoriesCollection: UICollectionView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var emptyProductLabel: UILabel!
    @IBOutlet weak var menuContainerViewHeight: NSLayoutConstraint!
    
    var menuCategories: MenuCategories?
    var idReceived: Int?
    var vendorViewPresenter: VendorProfilePresenter?
    var menuItems: MenuIems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        vendorViewPresenter = VendorProfilePresenter(vendorViewDelegte: self)
        vendorViewPresenter?.fetchMenuCategories(id: idReceived == 3 ? 42 : idReceived!)
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
        vendorImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vendorImage.layer.borderWidth = 2
        
        menuContainer.layer.cornerRadius = 30
        filterBtnView.layer.cornerRadius = 10
        filterBtnView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        filterBtnView.layer.borderWidth = 1
        
        menuContainerViewHeight.constant = self.view.frame.height - UIApplication.shared.statusBarFrame.height - 280
    }
    
    func loadMenuCollection(){
        
        let nib = UINib(nibName: "MenuFilterCollectionViewCell", bundle: nil)
        self.menuCategoriesCollection.register(nib, forCellWithReuseIdentifier: "MenuFilterCell")
        
        self.menuCategoriesCollection.numberOfItemsInSection { (_) -> Int in
            return (self.menuCategories?.items.menuesCategories.count)!
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell  = self.menuCategoriesCollection.dequeueReusableCell(withReuseIdentifier: "MenuFilterCell", for: index) as! MenuFilterCollectionViewCell
            cell.underLine.layer.cornerRadius = 1.5
            if self.menuCategories?.items.menuesCategories[index.row].selected ?? false{
                cell.underLine.isHidden = false
                cell.menuCategory.textColor =  UIColor.black
            }else{
                cell.underLine.isHidden = true
                cell.menuCategory.textColor = UIColor(named: "FontGrayColor")
            }
            cell.menuCategory.text = self.menuCategories?.items.menuesCategories[index.row].name
            
            return cell
            
        }/*.sizeForItemAt { (_) -> CGSize in
            return CGSize(width: 80, height:  60)
        }*/.didSelectItemAt { (index) in
            
            for i in 0...(self.menuCategories?.items.menuesCategories.count)!-1{
                self.menuCategories?.items.menuesCategories[i].selected = false
            }
            
            self.menuCategories?.items.menuesCategories[index.row].selected = true
            self.menuCategoriesCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.menuCategoriesCollection.reloadData()
            
            self.vendorViewPresenter?.fetchMenuItems(id: (self.menuCategories?.items.menuesCategories[index.row].id)!)
            
        }
        
        if let flowLayout = menuCategoriesCollection?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
    }
    
    func loadMenuTable(){
        
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        self.menuTableView.register(nib, forCellReuseIdentifier: "MenuCell")
        
        self.menuTableView.numberOfRows { (_) -> Int in
            return (self.menuItems?.restaurantMenu.count)!
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = self.menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: index) as! MenuTableViewCell
            cell.container.layer.cornerRadius = 15
            cell.logoImage.sd_setImage(with: URL(string: (self.menuItems?.restaurantMenu[index.row].hasImage)!))
            cell.itemName.text = self.menuItems?.restaurantMenu[index.row].name
            cell.desc.text = "\(self.menuItems?.restaurantMenu[index.row].price ?? "0.0")"
            cell.logoImage.layer.cornerRadius = cell.logoImage.frame.height/2
//            cell.addToCartBtn.onTap {
//                
//                if (self.menuItems?.restaurantMenu[index.row].restaurantID)! == UserDefaults.init().integer(forKey: "cart_associated_vendorId") || UserDefaults.init().integer(forKey: "cart_associated_vendorId") == 0{
//                    CartServices.addToCart(vendorId: (self.menuItems?.restaurantMenu[index.row].restaurantID)!,
//                                           vendorName: self.vendorName.text!,
//                                           vendorImage: self.menuCategories!.items.image,
//                                           deliveryFees: "20",
//                                           arg: CartItemModel(id: (self.menuItems?.restaurantMenu[index.row].id)!,
//                                                              name: (self.menuItems?.restaurantMenu[index.row].name)!,
//                                                              image: (self.menuItems?.restaurantMenu[index.row].image)!,
//                                                              price: Double(self.menuItems?.restaurantMenu[index.row].price ?? "0.0")!,
//                                                              quantity: 1)) { (_) in }
//                }else{
//                    let alert = UIAlertController(title: "", message: "Cart contains products from another vendor, to add this product you must clear your cart", preferredStyle: .actionSheet)
//                    alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { (_) in
//
//                        CartServices.clearCart()
//
//                    }))
//
//                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }
//
//            }
            
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 70
        }.didSelectRowAt { (index) in
            Router.toProduct(item: (self.menuItems?.restaurantMenu[index.row])!, vendorName: self.vendorName.text!, vendorImage: (self.menuCategories?.items.hasImage) ?? "", sender: self)
        }.didScroll { (scroller) in
            let maxHeight: CGFloat = self.view.frame.height - UIApplication.shared.statusBarFrame.height - 30
            let minHeight: CGFloat = self.view.frame.height - UIApplication.shared.statusBarFrame.height - 280
            let y: CGFloat = scroller.contentOffset.y
            let newViewHeight = self.menuContainerViewHeight.constant + y
            if newViewHeight > maxHeight{
                self.menuContainerViewHeight.constant = maxHeight
            }else if newViewHeight < minHeight{
                self.menuContainerViewHeight.constant = minHeight
            }else{
                self.menuContainerViewHeight.constant = newViewHeight
                scroller.contentOffset.y = 0
            }
        }.didScrollToTop { (_) in
            self.menuContainerViewHeight.constant = self.view.frame.height - UIApplication.shared.statusBarFrame.height - 280
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        
        self.menuTableView.reloadData()
        
    }
    
    
}
