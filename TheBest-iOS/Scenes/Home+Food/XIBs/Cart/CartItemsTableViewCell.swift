//
//  CartItemsTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class CartItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var attributeOne: UILabel!
    @IBOutlet weak var attributeTwo: UILabel!
    @IBOutlet weak var attributeThree: UILabel!
    @IBOutlet weak var attributesStack: UIStackView!
    
    func loadUI(){
        
        itemImageView.layer.cornerRadius = itemImageView.frame.height/2
        itemImageView.layer.borderWidth = 1.5
        itemImageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        container.layer.cornerRadius = 15
        container.setupShadow()
        
    }
    
    func loadCell(item: CartItemModel){
        
        loadUI()
        itemImageView.sd_setImage(with: URL(string: item.image!))
        itemName.text = item.name
        quantity.text = "\(item.quantity ?? 1)"
        
        let temp = (item.attributeOnePrice ?? 0.0) + (item.attributeTwoPrice ?? 0.0)
        let totalVariationsPrice =  temp + (item.attributeThreePrice ?? 0.0)
        
        price.text = "\((item.price! + totalVariationsPrice) * Double(item.quantity ?? 1))"
        
        if let _ = item.attributeOneName, let _ = item.attributeOnePrice, let _ = item.attributeOne{
            self.attributeOne.isHidden = false
            self.attributesStack.isHidden = false
            self.attributeOne.text = "\(item.attributeOneName!): \(item.attributeOnePrice!) KWD"
        }
        if let _ = item.attributeTwoName, let _ = item.attributeTwoPrice, let _ = item.attributeTwo{
            self.attributeTwo.isHidden = false
            self.attributesStack.isHidden = false
            self.attributeTwo.text = "\(item.attributeTwoName!): \(item.attributeTwoPrice!) KWD"
        }
        if let _ = item.attributeThreeName, let _ = item.attributeThreePrice, let _ = item.attributeThree{
            self.attributeThree.isHidden = false
            self.attributesStack.isHidden = false
            self.attributeThree.text = "\(item.attributeThreeName!): \(item.attributeThreePrice!) KWD"
        }
        
    }
    
}
