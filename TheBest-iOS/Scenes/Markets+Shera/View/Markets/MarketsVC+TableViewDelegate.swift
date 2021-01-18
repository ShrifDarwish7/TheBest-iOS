//
//  MarketsVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension MarketsVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTable(){
        
        let nib = UINib(nibName: "MarketTableViewCell", bundle: nil)
        self.marketsTableView.register(nib, forCellReuseIdentifier: "MarketCell")
        
        self.marketsTableView.delegate = self
        self.marketsTableView.dataSource = self
        
        self.marketsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.marketsTableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketTableViewCell
        cell.loadFrom(item: self.tableDataSource![indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case "markets":
            Router.toStores(pageIcon: "", id: self.tableDataSource![indexPath.row].typeID ?? 0, sender: self, from: "markets")
        default:
            Router.toStores(pageIcon: "", id: self.tableDataSource![indexPath.row].typeID ?? 0, sender: self, from: "vegetable")
        }
        
    }
    
}
