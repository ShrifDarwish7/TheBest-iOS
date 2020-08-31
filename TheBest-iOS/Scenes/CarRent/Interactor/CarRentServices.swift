//
//  CarRentServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CarRentServices{
    
    static func getCars(completed: @escaping (Cars?)->Void){
        Alamofire.request(GET_CARS_END_POINT, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder().decode(Cars.self, from: data)
                    completed(dataModel)
                }catch{
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
    }
    
    static func getNearestCars(car_model: String, car_list: String, completed: @escaping (NearestCars?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            multipartFormData.append(car_model.data(using: .utf8)!, withName: "car_model")
            multipartFormData.append(car_list.data(using: .utf8)!, withName: "car_list")
            
        }, to: URL(string: NEAREST_CARS_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
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
    
    static func getDistance(driverId: String, completed: @escaping (Distance?)->Void){
        
        let parameters = [
            "latitudeFrom": SharedData.userLat ?? 0.0,
            "longitudeFrom": SharedData.userLng ?? 0.0,
            "latitudeTo": SharedData.userDestinationLat ?? 0.0,
            "longitudeTo": SharedData.userDestinationLng ?? 0.0,
            "driver_id": driverId
        ] as [String: Any]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append("\(value )".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: CARS_DISTNCE_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
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
    
    static func confirmRide(completed: @escaping (Drivers?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            
        }, to: URL(string: CARS_CONFIRM_RIDE_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("confirmRide", try! JSON(data: data))
                        do{
                            
                            let dataModel = try JSONDecoder.init().decode(Drivers.self, from: data)
                            completed(dataModel)
                            
                        }catch let error{
                            print("confirmRideParsErr",error)
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
