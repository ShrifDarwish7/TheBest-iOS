//
//  SpecialCarsTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class SpecialCarsTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var driverName: UILabel!
    
    func loadUI(){
        container.layer.cornerRadius = 15
        carImageView.layer.cornerRadius = carImageView.frame.height/2
    }
    
    func loadFrom(_ item: SpecialCarData){
        loadUI()
        driverName.text = item.driverName
        if item.selected ?? false{
            container.layer.borderColor = #colorLiteral(red: 0.429972291, green: 0.6741142869, blue: 0.4641811848, alpha: 1)
            container.layer.borderWidth = 1.5
        }else{
            container.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        carImageView.sd_setImage(with: URL(string: item.driverImage))
        distance.text = "\(item.distance)" + " Km "
        cost.text = "\(item.cost)" + " KWD "
    }
    
    func loadFrom(_ item: TruckData){
        loadUI()
        driverName.text = item.driverName
        if item.selected ?? false{
            container.layer.borderColor = #colorLiteral(red: 0.7689641118, green: 0.3155301809, blue: 0.5700523257, alpha: 1)
            container.layer.borderWidth = 1.5
        }else{
            container.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        carImageView.sd_setImage(with: URL(string: item.driverImage))
        distance.text = "\(item.distance)" + " Km "
        cost.text = "\(item.cost)" + " KWD "
    }
    
    func loadFrom(_ item: NearestCar){
        loadUI()
        driverName.text = item.driverName
        if item.selected ?? false{
            container.layer.borderColor = #colorLiteral(red: 0.2392156863, green: 0.7529411765, blue: 0.9333333333, alpha: 1)
            container.layer.borderWidth = 1.5
        }else{
            container.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        carImageView.sd_setImage(with: URL(string: item.driverImage))
        distance.text = "\(item.distance)" + " Km "
        cost.text = "\(item.cost)" + " KWD "
    }
    
}
