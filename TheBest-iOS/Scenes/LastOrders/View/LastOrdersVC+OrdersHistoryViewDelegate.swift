//
//  LastOrdersVC+OrdersHistoryViewDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SVProgressHUD

extension LastOrdersVC: OrdersHistoryViewDelegate{
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func didCompletedWithFoodOrdersHistory(_ result: FoodOrdersHistory) {
        self.foodOrders = result.data
        self.emptyHistory.isHidden = true
        self.lastOrdersTable.isHidden = false
        self.lastTripsTable.isHidden = true
        self.loadLastOrders()
        self.lastOrdersTable.reloadData()
    }
    
    func didFailFetchFoodOrdersHistory() {
        self.emptyHistory.isHidden = false
        self.lastOrdersTable.isHidden = true
    }
    
    
    func didCompleteTripsWith(_ result: LastTrips?, _ error: Bool) {
        if let _ = result {
            self.trips = result?.trips
            self.loadLastTrips()
            self.lastTripsTable.isHidden = false
        }else{
            self.emptyHistory.isHidden = false
            self.lastOrdersTable.isHidden = true
            self.lastTripsTable.isHidden = true
        }
    }
    
}
