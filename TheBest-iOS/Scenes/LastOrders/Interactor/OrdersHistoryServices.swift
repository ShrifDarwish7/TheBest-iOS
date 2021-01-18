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
    
    static func getTripsHistory(id: Int, completed: @escaping (LastTrips?)->Void){
                
        let headers = [
            "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYzJjY2JhODFiYjJhNzE4ZDQyZjA4Y2U5MjVmM2RjMDg3YTVlODk3ZTk2OTkxY2YzMTEzMzA5ODAwODUyMTQ0YTdjZGM3ZjUxZGFlMzM3NWUiLCJpYXQiOjE2MDA4MDk5MzgsIm5iZiI6MTYwMDgwOTkzOCwiZXhwIjoxNjMyMzQ1OTM4LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.lz8zOPFhGk71x_li1Js5O0WfCoU4T2ICj0eRQ7hZ8uVEmYZidvTNDHFp19eio8zZHtHCmi-4sq6zBZ-LGdg15LzrKEP_2U_BeJ8jZ-WRKG1S6ns7LGa3cvm8BwFSPI2e8LVPPvGxOQb99d5XvKRtnz1yoMAywCci_nnhB796lnp6mRDnO0zF7p5v5lHRCiGbe_dsQ7uFgUfMkUhz8JRYVqCA0-UA61nUaWnuaRBYlvtVJPzujWW61zGbfiO9iU-tFDHB8dWILBnEPNEZEBVJhpWL6817R2C5aiV88B05rY1vUe62rLaSg8994Q8yTk_LEAvgZecdawUgGxSU_2ZzJHSyQFaPVwCyfo0YsdS-5fiqeHxeTa4WvNO62cTkmVpHaivbDpJvR6eYpR4m34U4Tg7T_7YKWG6dJ1SBCqlzsBvOI3GiD8Iu-NSi64cH5rEe_hg-yN06BRBae1eYXwAUYBTv1YUWosgSXNt1Jp3JKe2tR-Hzsov10htqbPIIEnlDY6o8ja7yGB9LkBCRu-8S6qACV-t3pr5evA22zDrR8v-fwv9lDyH1NgA1LXRst4Uv6cCjRYPfAxswXfumuJsfa13xP8FeIg8n12C4SAy8ITE3LTa7QJaUoqTTOmx61Tykda0wHnH2rw-MqoSFmgcx8Fx-htvE-R7yGVGWy7teWsY",
            "Accept": "application/json"
        ]
        
        Alamofire.request(MY_TRIPS_END_POINT + "\(id)", method: .get, parameters: nil, headers: headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                
                print(SharedData.headers)
                print(JSON(data))
                
                do{
                    let dataModel = try JSONDecoder().decode(LastTrips.self, from: data)
                    if !dataModel.trips.isEmpty{
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
