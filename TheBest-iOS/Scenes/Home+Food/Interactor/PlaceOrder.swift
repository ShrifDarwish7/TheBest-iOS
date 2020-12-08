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
                
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
 
            }
            
        }, to: URL(string: PLACE_ORDER_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    switch response.result{
                        
                    case .success(let data):
                        print(JSON(data))
                        //                        if JSON(data)["message"].string == "Done"{
                        //                            completed(true)
                        //                        }else{
                        //                             completed(false)
                        //                        }
                        do{
                            let _ = try JSONDecoder.init().decode(PlaceOrderResponse.self, from: data)
                            completed(true)
                        }catch let err{
                            print(err)
                            completed(false)
                        }
                        
                    case .failure(_):
                        
                        completed(false)
                        
                    }
                }
                
            case .failure(_):
                completed(false)
                
            }
            
        }
        
        
    }
    
    
}
