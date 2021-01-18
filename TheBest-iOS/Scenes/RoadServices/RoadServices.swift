//
//  RoadServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 18/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RoadServices{
    static func getServices(_ id: Int,_ completed: @escaping (RoadServicesOptions?)->Void ){
        Alamofire.request(ROAD_SERVICES_OPTIONS_END_POINT+"\(id)", method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder().decode(RoadServicesOptions.self, from: data)
                    completed(dataModel)
                }catch{
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
    }
    
    static func getNearestCars(_ completed: @escaping (NearestCars?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            
        }, to: URL(string: ROAD_SERVICES_NEARST_CARS_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("getTruck", try! JSON(data: data))
                        
                        do{
                            
                            
                            if let code = (try JSON(data: data))["code"].int, code == 105{
                                completed(nil)
                            }else{
                                let dataModel = try JSONDecoder.init().decode(NearestCars.self, from: data)
                                completed(dataModel)
                            }
                            
                        }catch{
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
    
    static func confirmRide(_ formData: [String:String], completed: @escaping (Bool)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
//            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
//            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            
            for (key,value) in formData{
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
            
            
            
        }, to: URL(string: CONFIRM_RIDE_ROAD_SERVICES_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        UserDefaults.init().setValue(15, forKey: "ride_type")
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
    
    static func getDistance(parameters: [String: Any],_ completed: @escaping (Distance?)->Void){
        
//        let parameters = [
//            "latitudeFrom": SharedData.userLat ?? 0.0,
//            "longitudeFrom": SharedData.userLng ?? 0.0,
//            "latitudeTo": SharedData.userDestinationLat ?? 0.0,
//            "longitudeTo": SharedData.userDestinationLng ?? 0.0,
//           // "driver_id": driverId
//        ] as [String: Any]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append("\(value )".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: GET_DISTANCE_ROAD_SERVICES_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        print(JSON(data))
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
    
    static func cancelRide(completed: @escaping (Bool)->Void ){
                
        Alamofire.request(URL(string: RS_CANCEL_RIDE)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            
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
    
}
