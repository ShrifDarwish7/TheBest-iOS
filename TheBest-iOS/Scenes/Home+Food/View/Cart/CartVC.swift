//
//  CartVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var itemsCount: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var totalOrder: UILabel!
    @IBOutlet weak var cartItemsTableView: UITableView!
    @IBOutlet weak var checkOutView: UIView!
    @IBOutlet weak var totalOrder2: UILabel!
    
    var cartItems: [CartItemModel]?
    var cartPresenter: CartPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartPresenter = CartPresenter(cartViewDelegate: self)
        cartPresenter?.fetchItems()

        checkOutView.layer.cornerRadius = 15
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
            
        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
        
        vendorImage.sd_setImage(with: URL(string: UserDefaults.init().string(forKey: "cart_associated_vendor_image")!))
        vendorName.text = UserDefaults.init().string(forKey: "cart_associated_vendor_name")
        deliveryFees.text = UserDefaults.init().string(forKey: "cart_associated_vendor_delivery_fees")
        updateTotalOrder()
        
        checkOutView.addTapGesture { (_) in
            Router.toCheckout(sender: self)
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
                self.cartPresenter?.updateQuantity(newValue: self.cartItems![index.row].quantity!+1, id: self.cartItems![index.row].id!)
                self.updateTotalOrder()
            }
            
            cell.minus.onTap {
                
                if self.cartItems![index.row].quantity! > 1{
                    self.cartPresenter?.updateQuantity(newValue: self.cartItems![index.row].quantity!-1, id: self.cartItems![index.row].id!)
                    self.updateTotalOrder()
                }
                
            }
            
            return cell
        }.heightForRowAt { (_) -> CGFloat in
            return 85
        }.trailingSwipeActionsConfigurationForRowAt { (index) -> UISwipeActionsConfiguration? in
            
            let contextualAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
                self.cartPresenter?.removeAt(id: self.cartItems![index.row].id!)
                self.updateTotalOrder()
            }
            
            return UISwipeActionsConfiguration(actions: [contextualAction])
            
        }
        
        cartItemsTableView.reloadData()
        
    }
    
    func updateTotalOrder(){
        
        var temp = 0.0
        for item in self.cartItems!{
            temp = temp + Double(item.price! * Double(item.quantity!))
        }
        self.totalOrder.text = "\(temp) KWD"
        self.totalOrder2.text = "\(temp) KWD"
    }

}
