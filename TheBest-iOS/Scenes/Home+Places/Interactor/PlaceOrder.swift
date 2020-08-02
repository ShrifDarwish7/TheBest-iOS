//
//  PlaceOrder.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/31/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PlaceOrder{
    
    static func place(){
        
        let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMmU5NzhlNjVlMWRlZDkzNDI2YWVlODc0NmQ3Y2ViOGRmOTkyMjg0OGIxOTg5YzNhMzM3ZmU5OGNjMWRhYTA0M2Q4YTY5MjdmZWEwMDE5YTQiLCJpYXQiOjE1OTU1MDk3MTYsIm5iZiI6MTU5NTUwOTcxNiwiZXhwIjoxNjI3MDQ1NzE2LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.KwXtKsCYAAeZBj2emAvqlMdQbDv5KcUY8szZ6QFPlU0cfUTBlq7GRfzBNZvz3N-IbByilwEcAJhdRRT2oBR8lNNbqdXxzJ4z44WJDWwSsColvy563KtN-AQqHoEKenCBuvSVmuyaURdTGtnVpg8tCovVdNTXQMR8gS_EVE8kYEnJ4GHHixFO1irTvRCFhPtWTwD-T5kG8G4CJ7kxMJVTi7PTOMh7ynQmqHHejlvqTclKfUA-v8xtslNyva9R9HltI7zFMiVngXNUm4auhjhb_WFHQM9phh7ew7Y5dcyRyOEow_Y8-Cw6CKFMUtoh9qYoUMjnwvhmbIfd678RgIq-rWAWZB03MbsvC2rmc_m0dBfHnO04larHqKWTHJwG2rq95wQBy-zVFJo-8E_N8Bk5by8ckTh42qtiajREXC7mkAuZo9usdPPk8PDGpY3K4RfNaAlXMGkkgNsPaLfAPWH3313pLQRDXdFIiWsDrvnv-jSyG6DXEQ9FXiZdyL_aDTmuGRM7ygu8dGUPZMAnVcsLDxyUKlophzvRCw3Ialb_Kbsux9MVRocDbWkCZfzdvk9ZDpXsvc8nWBwolAS_yX3ad0d-BJM2J0Lt_b7S4KkBQZHmGhePuQuJCRyhgrprZmRPOfqEHYY6LWNAWngZTGM9WqpQt76c6Vq1lF48QkaBSMY"
        
        let headers = [
        
            "Authorization": "Bearer \(AuthServices.instance.user.accessToken)",
            "Accept": "application/json"
        ]
        
        let p = [
            
            "product_id": ["1","2","3"],
            "lat": "30.033333",
            "lng": "31.233334",
            "address": "Put text here",
            "phone": "0155122155",
            "total": "4546",
            "comment": "any comment for the order",
            "variation_id": "1",
            "count": "20"
        
            ] as [String : Any]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in p{
                
                switch key {
                case "product_id":
                    
                    for i in value as! Array<String>{
                        multipartFormData.append(i.data(using: .utf8)!, withName: key+"[0]" )
                    }
                    
                default:
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
                
            }
            
        }, to: URL(string: PLACE_ORDER_END_POINT)!, method: .post, headers: headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("Done", try! JSON(data: data))
                        
                    case .failure(let error):
                        
                        print("place error",error)
                        
                    }
                }
                
            case .failure(_):
                print("")
                
            }
            
        }
        
        
    }
    
    
}
