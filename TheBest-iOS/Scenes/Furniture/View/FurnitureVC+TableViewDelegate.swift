//
//  FurnitureVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension FurnitureVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableView(){
        let nib = UINib(nibName: "SpecialCarsTableViewCell", bundle: nil)
        self.specialCarsTableView.register(nib, forCellReuseIdentifier: "SpecialCarsTableViewCell")
        self.specialCarsTableView.delegate = self
        self.specialCarsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trucksData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCarsTableViewCell", for: indexPath) as! SpecialCarsTableViewCell
        cell.loadFrom(self.trucksData![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...self.trucksData!.count - 1{
            self.trucksData![i].selected = false
        }
        self.trucksData![indexPath.row].selected = true
        self.selectedDriverID = self.trucksData![indexPath.row].id
        self.specialCarsTableView.reloadData()
    }
    
}
