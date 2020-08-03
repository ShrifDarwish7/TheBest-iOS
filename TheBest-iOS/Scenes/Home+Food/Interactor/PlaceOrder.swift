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
