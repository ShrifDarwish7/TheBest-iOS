//
//  SubscriptionServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 27/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SubscriptionServices{
    
    static func getTypes(completed: @escaping (SubTypes?)->Void){
        Alamofire.request(SUB_TYPES_END_POINT, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder.init().decode(SubTypes.self, from: data)
                    completed(dataModel)
                }catch let err{
                    print(err)
                    completed(nil)
                }
            default:
                completed(nil)
            }
        }
    }
    
    static func confirmRide(_ formData: [String:Any], completed: @escaping (Bool)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in formData.sorted(by: { $0.key < $1.key }){
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: SUB_CONFIRM_RIDE_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
            
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("confirmRide", try! JSON(data: data))
                        UserDefaults.init().setValue(17, forKey: "ride_type")
                        completed(true)
                        
                    case .failure(_):
                        completed(false)
                    }
                    
                }
                
            case .failure(_):
                completed(false)
            }
            
        }
        
    }
    
    static func cancelRide(completed: @escaping (Bool)->Void ){
                
        Alamofire.request(URL(string: SUBSCRIPT_CANCEL_RIDE)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            
            switch response.result{
                
            case .success(let data):
                
                let json = JSON(data)
                print(json)
                completed(true)
                
            case .failure(_):
                completed(false)
                
            }
            
        }
    }
    
    
    static func getDistance(_ parameters: [String:Any], completed: @escaping (Distance?)->Void){
        
//        let parameters = [
//            "latitudeFrom": "\(SharedData.userLat ?? 0.0)",
//            "longitudeFrom": "\(SharedData.userLng ?? 0.0)",
//            "latitudeTo": "\(SharedData.userDestinationLat ?? 0.0)",
//            "longitudeTo": "\(SharedData.userDestinationLng ?? 0.0 )",
//            "RoadServiceOption_id": "\(id)"
//        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: SUBSCRIPT_DISTANCE)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("getDistance", try! JSON(data: data))
                        do{
                            
                            let dataModel = try JSONDecoder.init().decode(Distance.self, from: data)
                            completed(dataModel)
                            
                        }catch let error{
                            print("getDistanceParsErr",error)
                            completed(nil)
                        }
                        
                    case .failure(_):
                        completed(nil)
                    }
                    
                }
                
            case .failure(_):
                completed(nil)
            }
            
        }
        
    }
    
}
