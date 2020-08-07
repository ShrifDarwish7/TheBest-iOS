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
        price.text = "\((item.price ?? 0) * Double(item.quantity ?? 1))"
        
    }
    
}
