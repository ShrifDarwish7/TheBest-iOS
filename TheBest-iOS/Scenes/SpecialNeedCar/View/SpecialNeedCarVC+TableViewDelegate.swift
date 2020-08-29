//
//  SpecialNeedCarVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension SpecialNeedCarVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableView(){
        let nib = UINib(nibName: "SpecialCarsTableViewCell", bundle: nil)
        self.specialCarsTableView.register(nib, forCellReuseIdentifier: "SpecialCarsTableViewCell")
        self.specialCarsTableView.delegate = self
        self.specialCarsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.specialCarData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialCarsTableViewCell", for: indexPath) as! SpecialCarsTableViewCell
        cell.loadFrom(self.specialCarData![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...self.specialCarData!.count - 1{
            self.specialCarData![i].selected = false
        }
        self.specialCarData![indexPath.row].selected = true
        self.selectedDriverID = self.specialCarData![indexPath.row].id
        self.specialCarsTableView.reloadData()
    }
    
}
