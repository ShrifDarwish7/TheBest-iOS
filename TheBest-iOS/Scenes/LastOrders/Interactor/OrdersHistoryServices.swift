//
//  OrdersHistoryServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrdersHistoryServices{
    
    static func getFoodOrdersHistory(id: Int, completed: @escaping (FoodOrdersHistory?)->Void){
        
        URLCache.shared.removeAllCachedResponses()
        
        Alamofire.request(FOOD_ORDERS_HISTORY_END_POINT + "\(id)", method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                print(JSON(data))
                do{
                    let dataModel = try JSONDecoder().decode(FoodOrdersHistory.self, from: data)
                    if !dataModel.data.isEmpty{
                        completed(dataModel)
                    }else{
                        completed(nil)
                    }
                }catch let error{
                    print(error)
                    completed(nil)
                }
            case .failure(let error):
                print(error)
                completed(nil)
            }
        }
        
    }
    
}
