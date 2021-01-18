//
//  CartVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class CartVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var itemsCount: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var totalOrder: UILabel!
    @IBOutlet weak var cartItemsTableView: UITableView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var totalOrder2: UILabel!
    @IBOutlet var iconsViews: [UIView]!
    @IBOutlet weak var empty: UILabel!
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var detailsStack: UIStackView!
    
    var cartItems: [CartItemModel]?
    var cartPresenter: CartPresenter?
    var total: Double = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartPresenter = CartPresenter(cartViewDelegate: self)
        cartPresenter?.fetchItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        checkOutView.layer.cornerRadius = 15
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
            
        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
        
        vendorImage.sd_setImage(with: URL(string: UserDefaults.init().string(forKey: "cart_associated_vendor_image")!))
        vendorName.text = UserDefaults.init().string(forKey: "cart_associated_vendor_name")
        deliveryFees.text = UserDefaults.init().string(forKey: "cart_associated_vendor_delivery_fees")
        
        checkOutView.addTapGesture { (_) in
           // Router.toCheckout(sender: self, total: self.total)
            SharedData.total = self.total
            Router.toMap(sender: self)
        }
        
        
        for v in iconsViews{
            v.layer.cornerRadius = v.frame.height/2
        }
        
        switch UserDefaults.init().string(forKey: "food_markets_flag") {
        case "1":
            
            for v in iconsViews{
                v.backgroundColor = UIColor(named: "BtnsColor")
            }
            checkOutView.backgroundColor = UIColor(named: "BtnsColor")
            
        case "2":
            
            for v in iconsViews{
                v.backgroundColor = UIColor(named: "MarketsColor")
            }
            checkOutView.backgroundColor = UIColor(named: "MarketsColor")
            
        default:
            
            for v in iconsViews{
                v.backgroundColor = UIColor(named: "vegColor")
            }
            checkOutView.backgroundColor = UIColor(named: "vegColor")
            
        }
        
    }
    
    func loadTableView(){
        
        let nib = UINib(nibName: "CartItemsTableViewCell", bundle: nil)
        cartItemsTableView.register(nib, forCellReuseIdentifier: "CartItemCell")
        
        cartItemsTableView.numberOfRows { (_) -> Int in
            return (self.cartItems?.count)!
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = self.cartItemsTableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: index) as! CartItemsTableViewCell
            cell.loadCell(item: self.cartItems![index.row])
            
            cell.add.onTap {
                self.cartPresenter?.updateQuantity(newValue: self.cartItems![index.row].quantity!+1, id: Int(self.cartItems![index.row].cartItemId!)!)
                self.updateTotalOrder()
            }
            
            cell.minus.onTap {
                
                if self.cartItems![index.row].quantity! > 1{
                    self.cartPresenter?.updateQuantity(newValue: self.cartItems![index.row].quantity!-1, id: Int(self.cartItems![index.row].cartItemId!)!)
                    self.updateTotalOrder()
                }
                
            }
            
            return cell
        }.heightForRowAt { (_) -> CGFloat in
            return UITableView.automaticDimension
        }.trailingSwipeActionsConfigurationForRowAt { (index) -> UISwipeActionsConfiguration? in
            
            let contextualAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
                self.cartPresenter?.removeAt(id: Int(self.cartItems![index.row].cartItemId!)!)
                self.updateTotalOrder()
            }
            
            return UISwipeActionsConfiguration(actions: [contextualAction])
            
        }
        
        cartItemsTableView.reloadData()
        
    }
    
    func updateTotalOrder(){
        
        var total = 0.0
        for item in self.cartItems!{
            let temp = (item.attributeOnePrice ?? 0.0) + (item.attributeTwoPrice ?? 0.0)
            let totalVariationsPrice =  temp + (item.attributeThreePrice ?? 0.0)
            total = total + Double((item.price! + totalVariationsPrice) * Double(item.quantity!))
        }
        self.total = total
        self.totalOrder.text = "\(total) KWD"
        self.totalOrder2.text = "\(total) KWD"
    }

}
