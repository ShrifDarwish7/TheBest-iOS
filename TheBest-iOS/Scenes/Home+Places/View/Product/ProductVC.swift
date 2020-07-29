//
//  ProductVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var productImageVIew: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet var roundView: [UIView]!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var quantityNumer: UILabel!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var customerNote: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var sizeStack1: UIStackView!
    @IBOutlet weak var sizeStack2: UIStackView!
    @IBOutlet weak var sizeStack3: UIStackView!
    @IBOutlet weak var size1: UIButton!
    @IBOutlet weak var size2: UIButton!
    @IBOutlet weak var size3: UIButton!
    
    var itemReceived: RestaurantMenuItem?
    var productPresenter: ProductPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productPresenter = ProductPresenter(productViewDelegate: self)
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        for view in roundView{
            view.layer.cornerRadius = 15
        }
        
        addToCartView.layer.cornerRadius = 15
        
        productImageVIew.sd_setImage(with: URL(string: itemReceived?.image ?? ""))
        productName.text = itemReceived?.name
        productDesc.text = itemReceived?.restaurantMenuDescription
        
        sizeStack1.addTapGesture { (_) in
            self.unselectAll()
            self.size1.setImage(UIImage(named: "select"), for: .normal)
        }
        
        sizeStack2.addTapGesture { (_) in
            self.unselectAll()
            self.size2.setImage(UIImage(named: "select"), for: .normal)
        }
        
        sizeStack3.addTapGesture { (_) in
            self.unselectAll()
            self.size3.setImage(UIImage(named: "select"), for: .normal)
        }
        
        plus.onTap {
            let count = Int(self.quantityNumer.text!)!
            self.quantityNumer.text = String(count + 1)
        }
        minus.onTap {
            let count = Int(self.quantityNumer.text!)!
            if count > 1 {
                self.quantityNumer.text = String(count - 1)
            }
        }
        
        addToCartView.addTapGesture { (_) in
            
            self.productPresenter?.addToCart(vendorId: self.itemReceived!.restaurantID, arg: CartItemModel(id: self.itemReceived!.id,
                                                                name: self.itemReceived!.name,
                                                                image: self.itemReceived!.image,
                                                                price: self.itemReceived!.price,
                                                                quantity: Int(self.quantityNumer.text!)!))
            
        }
        
    }

    func unselectAll(){
        size1.setImage(UIImage(named: "unselect"), for: .normal)
        size2.setImage(UIImage(named: "unselect"), for: .normal)
        size3.setImage(UIImage(named: "unselect"), for: .normal)
    }

}
