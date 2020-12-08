//
//  LastOrdersVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/4/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension LastOrdersVC: UITableViewDataSource, UITableViewDelegate{
    
    func loadLastOrders(){
        let nib = UINib(nibName: "OrdersTableViewCell", bundle: nil)
        self.lastOrdersTable.register(nib, forCellReuseIdentifier: "OrdersTableViewCell")
        self.lastOrdersTable.delegate = self
        self.lastOrdersTable.dataSource = self
        self.lastOrdersTable.reloadData()
    }
    
    func loadLastTrips(){
        let nib = UINib(nibName: "LastTripsTableViewCell", bundle: nil)
        self.lastTripsTable.register(nib, forCellReuseIdentifier: "LastTripsTableViewCell")
        self.lastTripsTable.delegate = self
        self.lastTripsTable.dataSource = self
        self.lastTripsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case lastOrdersTable:
            return self.foodOrders!.count
        default:
            return self.trips!.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case lastOrdersTable:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
            cell.loadUI(item: foodOrders![indexPath.row])
            
            
            let nib = UINib(nibName: "OrdersItemsTableViewCell", bundle: nil)
            cell.itemsTableView.register(nib, forCellReuseIdentifier: "OrdersItemsTableViewCell")
            
            cell.itemsTableView.numberOfRows { (_) -> Int in
                return self.foodOrders![indexPath.row].orderItems.count
            }.cellForRow { (index) -> UITableViewCell in
                
                let cell = cell.itemsTableView.dequeueReusableCell(withIdentifier: "OrdersItemsTableViewCell", for: index) as! OrdersItemsTableViewCell
                cell.loadUI(item: self.foodOrders![indexPath.row].orderItems[index.row])
                return cell
                
            }.heightForRowAt { (_) -> CGFloat in
                return 150
            }
            
            cell.itemsTableView.reloadData()
            
            if foodOrders![indexPath.row].expanded ?? false{
                cell.expandBtn.setImage(UIImage(named: "up-arrow"), for: .normal)
                UIView.animate(withDuration: 0.25) {
                    cell.itemsTableView.isHidden = false
                    cell.itemsViewHeight.constant = CGFloat((150 * self.foodOrders![indexPath.row].orderItems.count) + 80)
                    cell.itemsTableViewHeight.constant = CGFloat((150 * self.foodOrders![indexPath.row].orderItems.count))
                    self.view.layoutIfNeeded()
                }
            }else{
                cell.expandBtn.setImage(UIImage(named: "down-arrow"), for: .normal)
                UIView.animate(withDuration: 0.25) {
                    cell.itemsTableView.isHidden = true
                    cell.itemsViewHeight.constant = 70
                    cell.itemsTableViewHeight.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            
            cell.itemsView.addTapGesture { (_) in
                self.foodOrders![indexPath.row].expanded = !(self.foodOrders![indexPath.row].expanded ?? false)
                let offset = self.lastOrdersTable.contentOffset
                self.lastOrdersTable.reloadData()
                self.lastOrdersTable.setContentOffset(offset, animated: false)
            }
            
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastTripsTableViewCell", for: indexPath) as! LastTripsTableViewCell
            cell.loadFrom(trip: self.trips![indexPath.row])
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case lastOrdersTable:
            if foodOrders![indexPath.row].expanded ?? false{
                return CGFloat((150 * foodOrders![indexPath.row].orderItems.count) + 230)
            }else{
                return 230
            }
        default:
            return 100
        }
    }
    
}
