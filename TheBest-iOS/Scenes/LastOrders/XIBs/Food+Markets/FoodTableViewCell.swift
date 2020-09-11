//
//  FoodTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/4/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var vendorImage: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    
    func loadUI(){
        container.layer.cornerRadius = 15
        statusView.layer.cornerRadius = 15
        vendorImage.layer.cornerRadius = vendorImage.frame.height/2
    }
    
    func loadFrom(foodOrder: FoodOrder){
        loadUI()
        status.text = foodOrder.status
        date.text = foodOrder.orderDate
        vendorImage.sd_setImage(with: URL(string: foodOrder.orderItems?.first?.restaurantImage ?? ""))
        vendorName.text = foodOrder.orderItems?.first?.restaurantName ?? ""
    }
    
}
