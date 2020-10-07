//
//  CheckoutVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/10/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var itemsCount: UILabel!
    @IBOutlet weak var deliveryFees: UILabel!
    @IBOutlet weak var totalOrder: UILabel!
    @IBOutlet weak var totalOrder2: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet var roundView: [UIView]!
    @IBOutlet weak var checkoutBtn: UIView!
    @IBOutlet weak var orderDoneHint: UIView!
    
    var cartItems: [CartItemModel]?
    var checkoutPresenter: CheckoutPresenter?
    var checkoutParameters: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        for view in roundView{
            view.layer.cornerRadius = 15
        }
        
        checkoutPresenter = CheckoutPresenter(checkoutViewDelegate: self)
        checkoutPresenter?.fetchItems()

        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
        
        vendorImage.sd_setImage(with: URL(string: UserDefaults.init().string(forKey: "cart_associated_vendor_image")!))
        vendorName.text = UserDefaults.init().string(forKey: "cart_associated_vendor_name")
        deliveryFees.text = UserDefaults.init().string(forKey: "cart_associated_vendor_delivery_fees")
        if let _ = cartItems{
            updateTotalOrder()
        }
        username.text = AuthServices.instance.user.name
        userPhone.text = AuthServices.instance.user.phone
        
        checkoutBtn.addTapGesture { (_) in
            guard let _ = self.checkoutParameters else{
                return
            }
            self.checkoutPresenter?.placeOrder(parameters: self.checkoutParameters!)
            print("checkoutParameters", self.checkoutParameters!)
        }
        
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
