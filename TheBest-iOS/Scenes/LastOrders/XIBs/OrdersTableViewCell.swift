//
//  OrdersTableViewCell.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/6/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var itemsView: UIView!
    @IBOutlet weak var itemsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var itemsTableViewHeight: NSLayoutConstraint!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var changStatusStack: UIStackView!
    
    func loadUI(item: Order){
        statusLbl.layer.cornerRadius = 10

        for v in views{
            v.setupShadow()
            v.layer.cornerRadius = 10
        }
        statusLbl.text = item.status
        name.text = item.username
//        totalLbl.text = item.total + " KWD "
        totalLbl.text = "\(item.id)"
        date.text = item.orderDate
    }
    
}
