//
//  HowToUseVC+CollectionViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/9/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension HowToUseVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func loadCollection(){
        
        let nib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        catsCollectionView.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        
        catsCollectionView.delegate = self
        catsCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.categoryIcon.image = appCategories[indexPath.row].icon
        cell.categoryName.text = appCategories[indexPath.row].name
        cell.categoryName.font = UIFont(name: "lato", size: 12)
        if appCategories[indexPath.row].selected ?? false{
            cell.container.backgroundColor = getColor(indexPath.row)
            cell.container.alpha = 1
            cell.categoryName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            cell.container.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.categoryName.textColor = UIColor.lightGray
            cell.container.alpha = 0.5
        }
        cell.container.layer.cornerRadius = 15

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...appCategories.count-1{
            appCategories[i].selected = false
        }
        appCategories[indexPath.row].selected = true
        catsCollectionView.reloadData()
        catsCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        
        self.foodGuideView.isHidden = true
        self.taxiGuide.isHidden = true
        
        switch indexPath.row{
        case 0:
            self.foodGuideView.isHidden = false
        case 1:
            self.taxiGuide.isHidden = false
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    private func getColor(_ index: Int)->UIColor{
        switch index{
        case 0:
            return UIColor(named: "BtnsColor")!
        case 1:
            return UIColor(named: "TaxiGoldColor")!
        case 2:
            return UIColor(named: "CarRentColor")!
        case 3:
            return UIColor(named: "SpecialNeedCarColor")!
        case 4:
            return UIColor(named: "MarketsColor")!
        case 5:
            return UIColor(named: "RoadServicesColor")!
        case 6:
            return UIColor(named: "FurnitureColor")!
        default:
            return UIColor()
        }
    }
    
}
