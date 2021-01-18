//
//  SubscriptVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 20/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension SubscriptVC: UITableViewDelegate, UITableViewDataSource{
    func loadDaysTable(){
        daysTableView.delegate = self
        daysTableView.dataSource = self
        daysTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysTableViewCell", for: indexPath) as! DaysTableViewCell
        cell.daysLbl.text = SharedData.days[indexPath.row].day
        if SharedData.days[indexPath.row].selected{
            cell.checkBoxImageView.image = UIImage(named: "checked")
        }else{
            cell.checkBoxImageView.image = UIImage(named: "unchecked")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharedData.days[indexPath.row].selected = !SharedData.days[indexPath.row].selected
        daysTableView.reloadData()
    }
    
}
