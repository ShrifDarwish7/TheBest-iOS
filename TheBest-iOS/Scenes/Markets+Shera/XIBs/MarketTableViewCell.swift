//
//  MarketTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class MarketTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var desc: UILabel!
    
    func loadFrom(item: Item){
        self.name.text = item.name ?? ""
        self.desc.text = "lang".localized == "en" ? item.itemDescriptionEn : item.itemDescription
        self.imagView?.sd_setImage(with: URL(string: item.hasImage ?? "")!)
        self.imagView?.layer.cornerRadius = (self.imagView?.frame.height)!/2
        self.container.layer.cornerRadius = 15
    }
    
}