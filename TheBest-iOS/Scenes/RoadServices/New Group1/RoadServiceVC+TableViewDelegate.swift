//
//  RoadServiceVC+TableViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension RoadServicesVC: UITableViewDelegate, UITableViewDataSource{
    
    func loadTableView(){
        let nib = UINib(nibName: "ServiceTableViewCell", bundle: nil)
        self.servicesTableView.register(nib, forCellReuseIdentifier: "ServiceTableViewCell")
        self.servicesTableView.delegate = self
        self.servicesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.services!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
        cell.loadUI(option: self.services![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...self.services!.count - 1{
            self.services![i].checked = false
        }
        self.services![indexPath.row].checked = true
        self.selectedService = self.services![indexPath.row]
        self.roadServicesPresenter?.getNearestCarsWith()
        self.servicesTableView.reloadData()
    }
    
}
