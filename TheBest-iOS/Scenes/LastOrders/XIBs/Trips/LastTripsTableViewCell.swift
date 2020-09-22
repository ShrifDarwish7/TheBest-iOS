//
//  LastTripsTableViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/17/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class LastTripsTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromAddress: UILabel!
    @IBOutlet weak var toAddress: UILabel!
    
    func loadUI(){
        container.layer.cornerRadius = 15
        statusView.layer.cornerRadius = 15
        fromView.layer.cornerRadius = fromView.frame.height/2
        fromView.layer.borderWidth = 1.5
        fromView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toView.layer.cornerRadius = toView.frame.height/2
    }
    
    func loadFrom(trip: Trip){
        loadUI()
        self.fromAddress.text = trip.addressFrom
        self.toAddress.text = trip.addressTo
        self.status.text = trip.status
        self.date.text = trip.createdAt
    }
    
}
