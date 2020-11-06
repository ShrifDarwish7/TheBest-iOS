//
//  ProductVC+UITableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 10/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension ProductVC: UITableViewDataSource, UITableViewDelegate{
    
    func loadVariationTableFromNIB(){
        let nib = UINib(nibName: "VariationTableViewCell", bundle: nil)
        self.variationTableView.register(nib, forCellReuseIdentifier: "VariationTableViewCell")
        self.variationTableView.delegate = self
        self.variationTableView.dataSource = self
        self.variationTableView.reloadData()
        self.viewDidLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemReceived?.variations!.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariationTableViewCell", for: indexPath) as! VariationTableViewCell
        cell.loadUI()
        cell.variationName.text = self.itemReceived?.variations![indexPath.row].titleEn
        
        let bodyNib = UINib(nibName: "VariationBodyTableViewCell", bundle: nil)
        cell.variationBodyTableView.register(bodyNib, forCellReuseIdentifier: "VariationBodyTableViewCell")
        cell.variationBodyTableView.delegate = self
        cell.variationBodyTableView.dataSource = self
        
        cell.variationBodyTableView.numberOfRows { (_) -> Int in
            return (self.itemReceived?.variations![indexPath.row].body.count)!
        }.cellForRow { (bodyIndex) -> UITableViewCell in
            
            let cell = cell.variationBodyTableView.dequeueReusableCell(withIdentifier: "VariationBodyTableViewCell", for: bodyIndex) as! VariationBodyTableViewCell
            cell.variationName.text = self.itemReceived?.variations![indexPath.row].body[bodyIndex.row].nameEn
            cell.price.text = (self.itemReceived?.variations![indexPath.row].body[bodyIndex.row].price) ?? "0.0" + " " + "KWD"
            if self.itemReceived?.variations![indexPath.row].body[bodyIndex.row].selected ?? false {
                cell.check.setImage(UIImage(named: "select"), for: .normal)
            }else{
                cell.check.setImage(UIImage(named: "unselect"), for: .normal)
            }
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 30
        }.didSelectRowAt { (index) in
            for i in 0...((self.itemReceived?.variations![indexPath.row].body.count)!-1){
                self.itemReceived?.variations![indexPath.row].body[i].selected = false
            }
            self.itemReceived?.variations![indexPath.row].body[index.row].selected = true
            switch indexPath.row{
            case 0:
                self.selectedAttributeOneIndex = index.row
                self.selectedAttributeOneIndexPrice = Double(self.itemReceived?.variations![indexPath.row].body[index.row].price ?? "0.0")
                self.selectedAttributeOneIndexName = self.itemReceived?.variations![indexPath.row].titleEn
            case 1:
                self.selectedAttributeTwoIndex = index.row
                self.selectedAttributeTwoIndexPrice = Double(self.itemReceived?.variations![indexPath.row].body[index.row].price ?? "0.0")
                self.selectedAttributeTwoIndexName = self.itemReceived?.variations![indexPath.row].titleEn
            case 2:
                self.selectedAttributeThreeIndex = index.row
                self.selectedAttributeThreeIndexPrice = Double(self.itemReceived?.variations![indexPath.row].body[index.row].price ?? "0.0")
                self.selectedAttributeThreeIndexName = self.itemReceived?.variations![indexPath.row].titleEn
            default:
                break
            }
            self.variationTableView.reloadData()
            self.view.layoutIfNeeded()
            self.viewDidLayoutSubviews()
        }
        
        cell.variationBodyTBHeightCnst.constant = CGFloat(30 * (self.itemReceived?.variations![indexPath.row].body.count)!)
         let contentOffset = scroller.contentOffset
        cell.variationBodyTableView.reloadData()
        self.view.layoutIfNeeded()
        self.viewDidLayoutSubviews()
        scroller.setContentOffset(contentOffset, animated: false)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let variations = self.itemReceived?.variations
        return (CGFloat((variations?[indexPath.row].body.count)! * 30 + 70))
    }
    
}
