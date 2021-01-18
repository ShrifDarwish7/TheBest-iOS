//
//  RoadServices+CollectionViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension RoadServicesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func registerCollectionView(){
        
        let nib = UINib(nibName: "CarsTypesCollectionViewCell", bundle: nil)
        self.servicesCollectionView.register(nib, forCellWithReuseIdentifier: "CarsTypesCell")
        
        self.servicesCollectionView.delegate = self
        self.servicesCollectionView.dataSource = self
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarsTypesCell", for: indexPath) as! CarsTypesCollectionViewCell
        cell.typeImageView.isHidden = true
        cell.typeName.text = self.services![indexPath.row].name
        
        
//        if self.services![indexPath.row].selected ?? false{
//            cell.container.alpha = 1
//        }else{
//            cell.container.alpha = 0.3
//        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 70)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        for i in 0...self.services!.count-1{
//            self.services![i].selected = false
//        }
//        self.services![indexPath.row].selected = true
//        self.servicesCollectionView.reloadData()
//        self.servicesCollectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: .centeredHorizontally, animated: true  )
//        self.roadServicesPresenter?.getNearestCarsWith()
//        self.selectedServiceName = self.services![indexPath.row].name
//        self.selectedServiceImage = self.services![indexPath.row].image ?? ""
//       // self.selectedDriverID = nil
//       // self.furniturePresenter?.getTruckResultsWith(id: "\(self.truckTypes![indexPath.row].id)")
//      //  self.specialNeedCarsPresenter?.getSpecialCarWith(id: "\(self.carsTypes![indexPath.row].id)", eq: "\(self.selectedEquipmentID ?? 0)")
//
//    }
}
