//
//  CategoriesServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoriesServices{
    
    static func getMainCategories(completed: @escaping (Categories?)->Void){
        
        let headers = [
        
            "Authorization": "Bearer \(AuthServices.instance.user.accessToken)",
            "Accept": "application/json"
        ]
              
        Alamofire.request(URL(string: MAIN_CATEGORIES_END_POINT)!, method: .get, parameters: nil, headers: headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                do {
                    let dataModel = try JSONDecoder().decode(Categories.self, from: data)
                    print("mainCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getCategoriesBy(id: Int, completed: @escaping (SubCategories?)->Void){

        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmU5NzhlNjVlMWRlZDkzNDI2YWVlODc0NmQ3Y2ViOGRmOTkyMjg0OGIxOTg5YzNhMzM3ZmU5OGNjMWRhYTA0M2Q4YTY5MjdmZWEwMDE5YTQiLCJpYXQiOjE1OTU1MDk3MTYsIm5iZiI6MTU5NTUwOTcxNiwiZXhwIjoxNjI3MDQ1NzE2LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.KwXtKsCYAAeZBj2emAvqlMdQbDv5KcUY8szZ6QFPlU0cfUTBlq7GRfzBNZvz3N-IbByilwEcAJhdRRT2oBR8lNNbqdXxzJ4z44WJDWwSsColvy563KtN-AQqHoEKenCBuvSVmuyaURdTGtnVpg8tCovVdNTXQMR8gS_EVE8kYEnJ4GHHixFO1irTvRCFhPtWTwD-T5kG8G4CJ7kxMJVTi7PTOMh7ynQmqHHejlvqTclKfUA-v8xtslNyva9R9HltI7zFMiVngXNUm4auhjhb_WFHQM9phh7ew7Y5dcyRyOEow_Y8-Cw6CKFMUtoh9qYoUMjnwvhmbIfd678RgIq-rWAWZB03MbsvC2rmc_m0dBfHnO04larHqKWTHJwG2rq95wQBy-zVFJo-8E_N8Bk5by8ckTh42qtiajREXC7mkAuZo9usdPPk8PDGpY3K4RfNaAlXMGkkgNsPaLfAPWH3313pLQRDXdFIiWsDrvnv-jSyG6DXEQ9FXiZdyL_aDTmuGRM7ygu8dGUPZMAnVcsLDxyUKlophzvRCw3Ialb_Kbsux9MVRocDbWkCZfzdvk9ZDpXsvc8nWBwolAS_yX3ad0d-BJM2J0Lt_b7S4KkBQZHmGhePuQuJCRyhgrprZmRPOfqEHYY6LWNAWngZTGM9WqpQt76c6Vq1lF48QkaBSMY"
        
        let headers = [
        
            "Authorization": "Bearer \(AuthServices.instance.user.accessToken)",
            "Accept": "application/json"
        ]
              
        Alamofire.request(URL(string: CATEGORIES_BY_ID_END_POINT + "\(id)")!, method: .get, parameters: nil, headers: headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("here",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(SubCategories.self, from: data)
                    print("SubCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getPlacesBy(categoryId: Int, completed: @escaping (Places?)->Void){

        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmU5NzhlNjVlMWRlZDkzNDI2YWVlODc0NmQ3Y2ViOGRmOTkyMjg0OGIxOTg5YzNhMzM3ZmU5OGNjMWRhYTA0M2Q4YTY5MjdmZWEwMDE5YTQiLCJpYXQiOjE1OTU1MDk3MTYsIm5iZiI6MTU5NTUwOTcxNiwiZXhwIjoxNjI3MDQ1NzE2LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.KwXtKsCYAAeZBj2emAvqlMdQbDv5KcUY8szZ6QFPlU0cfUTBlq7GRfzBNZvz3N-IbByilwEcAJhdRRT2oBR8lNNbqdXxzJ4z44WJDWwSsColvy563KtN-AQqHoEKenCBuvSVmuyaURdTGtnVpg8tCovVdNTXQMR8gS_EVE8kYEnJ4GHHixFO1irTvRCFhPtWTwD-T5kG8G4CJ7kxMJVTi7PTOMh7ynQmqHHejlvqTclKfUA-v8xtslNyva9R9HltI7zFMiVngXNUm4auhjhb_WFHQM9phh7ew7Y5dcyRyOEow_Y8-Cw6CKFMUtoh9qYoUMjnwvhmbIfd678RgIq-rWAWZB03MbsvC2rmc_m0dBfHnO04larHqKWTHJwG2rq95wQBy-zVFJo-8E_N8Bk5by8ckTh42qtiajREXC7mkAuZo9usdPPk8PDGpY3K4RfNaAlXMGkkgNsPaLfAPWH3313pLQRDXdFIiWsDrvnv-jSyG6DXEQ9FXiZdyL_aDTmuGRM7ygu8dGUPZMAnVcsLDxyUKlophzvRCw3Ialb_Kbsux9MVRocDbWkCZfzdvk9ZDpXsvc8nWBwolAS_yX3ad0d-BJM2J0Lt_b7S4KkBQZHmGhePuQuJCRyhgrprZmRPOfqEHYY6LWNAWngZTGM9WqpQt76c6Vq1lF48QkaBSMY"
        
        let headers = [
        
            "Authorization": "Bearer \(AuthServices.instance.user.accessToken)",
            "Accept": "application/json"
        ]
              
        Alamofire.request(URL(string: PLACES_BY_CATEGORY_END_POINT + "\(categoryId)")!, method: .get, parameters: nil, headers: headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("herePlaces",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(Places.self, from: data)
                    print("SubCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    
}
