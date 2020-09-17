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
        let nib = UINib(nibName: "FoodTableViewCell", bundle: nil)
        self.lastOrdersTable.register(nib, forCellReuseIdentifier: "FoodTableViewCell")
        self.lastOrdersTable.delegate = self
        self.lastOrdersTable.dataSource = self
    }
    
    func loadLastTrips(){
        let nib = UINib(nibName: "LastTripsTableViewCell", bundle: nil)
        self.lastTripsTable.register(nib, forCellReuseIdentifier: "LastTripsTableViewCell")
        self.lastTripsTable.delegate = self
        self.lastTripsTable.dataSource = self
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
            cell.loadFrom(foodOrder: self.foodOrders![indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastTripsTableViewCell", for: indexPath) as! LastTripsTableViewCell
            cell.loadFrom(trip: self.trips![indexPath.row])
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
