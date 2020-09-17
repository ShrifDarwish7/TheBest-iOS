//
//  OrdersHistoryPresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol OrdersHistoryViewDelegate {
    func showProgress()
    func dismissProgress()
    func didCompletedWithFoodOrdersHistory(_ result: FoodOrdersHistory)
    func didFailFetchFoodOrdersHistory()
    func didCompleteTripsWith(_ result: LastTrips?, _ error: Bool)
}

class OrdersHistoryPresenter{
    
    private var ordersHistoryViewDelegate: OrdersHistoryViewDelegate?
    
    init(ordersHistoryViewDelegate: OrdersHistoryViewDelegate) {
        self.ordersHistoryViewDelegate = ordersHistoryViewDelegate
    }
    
    func getFoodOrdersHistory(id: Int){
        self.ordersHistoryViewDelegate?.showProgress()
        OrdersHistoryServices.getFoodOrdersHistory(id: id) { (result) in
            self.ordersHistoryViewDelegate?.dismissProgress()
            if let _ = result{
                self.ordersHistoryViewDelegate?.didCompletedWithFoodOrdersHistory(result!)
            }else{
                self.ordersHistoryViewDelegate?.didFailFetchFoodOrdersHistory()
            }
        }
    }
    
    func getLastTripsHistory(id: Int){
        self.ordersHistoryViewDelegate?.showProgress()
        OrdersHistoryServices.getTripsHistory(id: id) { (lastTrips) in
            self.ordersHistoryViewDelegate?.dismissProgress()
            if let _ = lastTrips{
                self.ordersHistoryViewDelegate?.didCompleteTripsWith(lastTrips!, false)
            }else{
                self.ordersHistoryViewDelegate?.didCompleteTripsWith(nil, true)
            }
        }
    }
    
}
