//
//  CategoriesCollectionViewCell.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/22/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import SDWebImage

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
  
    func loadFrom(category: MainCategory){
        
        categoryName.text = category.name
        categoryIcon.sd_setImage(with: URL(string: category.image)!)
        container.layer.cornerRadius = 20
        categoryIcon.layer.borderWidth = 5
        categoryIcon.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        categoryIcon.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        categoryIcon.layer.cornerRadius = categoryIcon.frame.height/2
        container.backgroundColor = UIColor(named: "BtnsColor")
        categoryName.textColor = UIColor.white
        
    }
    
    func loadFrom(appCategory: AppCategory){
        
        categoryName.text = appCategory.name
        categoryIcon.image = appCategory.icon
        container.layer.cornerRadius = 20
        
    }
    
}
