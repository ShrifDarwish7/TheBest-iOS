//
//  VariationTableViewCell.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/25/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class VariationTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var variationName: UILabel!
    @IBOutlet weak var variationBodyTableView: UITableView!
    @IBOutlet weak var variationBodyTBHeightCnst: NSLayoutConstraint!
    
    func loadUI(){
        containerView.setupShadow()
        containerView.layer.cornerRadius = 15
        viewTop.layer.cornerRadius = 15
    }
    
}
