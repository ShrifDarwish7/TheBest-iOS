//
//  SpecialNeedCarsVC+CollectionViewDelegates.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension SpecialNeedCarVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func registerCollectionView(){
        
        let nib = UINib(nibName: "CarsTypesCollectionViewCell", bundle: nil)
        self.carsTypesCollectionView.register(nib, forCellWithReuseIdentifier: "CarsTypesCell")
        
        self.carsTypesCollectionView.delegate = self
        self.carsTypesCollectionView.dataSource = self
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carsTypes!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarsTypesCell", for: indexPath) as! CarsTypesCollectionViewCell
        cell.typeImageView.sd_setImage(with: URL(string: self.carsTypes![indexPath.row].hasImage ?? "")!)
        cell.typeName.text = self.carsTypes![indexPath.row].name
        
        if self.carsTypes![indexPath.row].selected ?? false{
            cell.container.alpha = 1
        }else{
            cell.container.alpha = 0.3
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for i in 0...self.carsTypes!.count-1{
            self.carsTypes![i].selected = false
        }
        self.carsTypes![indexPath.row].selected = true
        self.carsTypesCollectionView.reloadData()
        self.carsTypesCollectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: .centeredHorizontally, animated: true  )
        self.selectedDriverID = nil
        self.specialNeedCarsPresenter?.getSpecialCarWith(id: "\(self.carsTypes![indexPath.row].id)", eq: "\(self.selectedEquipmentID ?? 0)")
    
    }
    
}
