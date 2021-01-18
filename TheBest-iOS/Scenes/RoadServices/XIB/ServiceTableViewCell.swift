//
//  ServiceTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 03/01/2021.
//  Copyright © 2021 Sherif Darwish. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var checkedIcon: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceDesc: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    
    func loadUI(option: RoadServOption){
        checkedIcon.image = option.checked == true ? UIImage(named: "checked_rs") : UIImage(named: "unchecked_rs")
        serviceName.text = option.name
        serviceDesc.text = option.description
        servicePrice.text = option.price + " " + "KWD"
        serviceImage.sd_setImage(with: URL(string: option.image ?? ""))
    }
    
}
