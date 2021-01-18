//
//  CarRentVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/18/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension CarRentVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableView(){
        let nib = UINib(nibName: "SpecialCarsTableViewCell", bundle: nil)
        self.nearestTableView.register(nib, forCellReuseIdentifier: "SpecialCarsTableViewCell")
        self.nearestTableView.delegate = self
        self.nearestTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearestCars!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCarsTableViewCell", for: indexPath) as! SpecialCarsTableViewCell
        cell.loadFrom(self.nearestCars![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...self.nearestCars!.count - 1{
            self.nearestCars![i].selected = false
        }
        self.nearestCars![indexPath.row].selected = true
        self.selectedDriverID = self.nearestCars![indexPath.row].id
        self.nearestTableView.reloadData()
    }
    
}
