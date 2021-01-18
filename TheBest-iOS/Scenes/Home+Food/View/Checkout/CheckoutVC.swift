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
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var landmark: UILabel!
    @IBOutlet weak var building: UILabel!
    @IBOutlet weak var floor: UILabel!
    @IBOutlet weak var flat: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var notesTV: UITextView!
    
    
    var cartItems: [CartItemModel]?
    var checkoutPresenter: CheckoutPresenter?
    var checkoutParameters: [String: Any]?
    var receivedTotal: Double?
    var userAddressStr: String?
    var userAddress: UserAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAddressStr = UserDefaults.init().string(forKey: "user_address")
        userAddress = try! JSONDecoder.init().decode(UserAddress.self, from: (userAddressStr?.data(using: .utf8))!)
        
        city.text = userAddress?.city
        area.text = userAddress?.area
        street.text = userAddress?.street
        landmark.text = userAddress?.landmark
        building.text = "Building: ".localized + userAddress!.building
        floor.text = "Floor: ".localized + userAddress!.floor
        flat.text = "Flat: ".localized + userAddress!.flat
        phone.text = "Phone: ".localized + userAddress!.phone
        
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
        
        totalOrder.text = "\(receivedTotal!) KWD"
        totalOrder2.text = "\(receivedTotal!) KWD"
        
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
    
    
}
