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
    
    static func place(parameters: [String: Any], completed: @escaping (Bool)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                
                switch key {
                case "product_id","variation_id":
                    
                    for i in value as! Array<String>{
                        multipartFormData.append(i.data(using: .utf8)!, withName: key+"[0]" )
                    }
                    
                default:
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
                
            }
            
        }, to: URL(string: PLACE_ORDER_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("Done", try! JSON(data: data))
                        completed(true)
                        
                    case .failure(let error):
                        
                        print("place error",error)
                        completed(false)
                        
                    }
                }
                
            case .failure(_):
                completed(false)
                
            }
            
        }
        
        
    }
    
    
}
