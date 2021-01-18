//
//  SpecialCarsServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/20/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class SpecialCarsServices{
    
    static func getSpecialCarsType(_ completed: @escaping (SpecialCars?)->Void){
        
        Alamofire.request(SPECIAL_CARS_TYPES_END_POINT, method: .get, parameters: nil, headers: SharedData.headers)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    
                    let json = JSON(data)
                    do{
                        
                        let dataModel = try JSONDecoder().decode(SpecialCars.self, from: data)
                        completed(dataModel)
                        
                    }catch{
                        completed(nil)
                    }
                    
                case .failure(_):
                    completed(nil)
                }
        }
    }
    
    static func getSpecialCar(id: String, eq: String, completed: @escaping (SpecialCarResult?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            multipartFormData.append(id.data(using: .utf8)!, withName: "category_id")
            multipartFormData.append(eq.data(using: .utf8)!, withName: "equipment_id")
            
        }, to: URL(string: GET_SPECIAL_CAR_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("getSpecialCar", try! JSON(data: data))
                        
                        do{
                            
                            
                            if let code = (try JSON(data: data))["code"].int, code == 105{
                                completed(nil)
                            }else{
                                let dataModel = try JSONDecoder.init().decode(SpecialCarResult.self, from: data)
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
    
    static func getEquipments(_ completed: @escaping (Equipments?)->Void){
        
        Alamofire.request(EQUIPMENTS_END_POINT, method: .get, parameters: nil, headers: SharedData.headers)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                                        
                    do{
                        
                        let dataModel = try JSONDecoder().decode(Equipments.self, from: data)
                        completed(dataModel)
                        
                    }catch{
                        completed(nil)
                    }
                    
                case .failure(_):
                    completed(nil)
                }
        }
    }
    
    static func getDistance(parameters: [String: Any], completed: @escaping (Distance?)->Void){
        
//        let parameters = [
//            "latitudeFrom": SharedData.userLat ?? 0.0,
//            "longitudeFrom": SharedData.userLng ?? 0.0,
//            "latitudeTo": SharedData.userDestinationLat ?? 0.0,
//            "longitudeTo": SharedData.userDestinationLng ?? 0.0,
//            "driver_id": driverId
//        ] as [String: Any]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append("\(value )".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: GET_DISTANCE_SP_CAR_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
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
    
    static func confirmRide(_ carType: String,_ requiredEquipment: String,_ priceMethod: String, completed: @escaping (Bool)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "from_lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "from_lng")
            multipartFormData.append("\(SharedData.userDestinationLat ?? 0)".data(using: .utf8)!, withName: "to_lat")
            multipartFormData.append("\(SharedData.userDestinationLng ?? 0)".data(using: .utf8)!, withName: "to_lng")
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            multipartFormData.append(carType.data(using: .utf8)!, withName: "car_type")
            multipartFormData.append(requiredEquipment.data(using: .utf8)!, withName: "required_equipment")
            multipartFormData.append(priceMethod.data(using: .utf8)!, withName: "price_method")
            multipartFormData.append("\(UserDefaults.init().double(forKey: "trip_total") > 9999.0 ? 9999.0 : UserDefaults.init().double(forKey: "trip_total"))".data(using: .utf8)!, withName: "total")
            
        
        }, to: URL(string: CONFIRM_SP_RIDE_CAR)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                      //  print("confirmRide", try! JSON(data: data))
                        UserDefaults.init().setValue(4, forKey: "ride_type")
                        completed(true)
//                        do{
//
//                            let dataModel = try JSONDecoder.init().decode(Drivers.self, from: data)
//                            completed(dataModel)
//
//                        }catch let error{
//                            print("confirmRideParsErr",error)
//                            completed(nil)
//                        }
                        
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
                
        Alamofire.request(URL(string: SP_CANCEL_RIDE)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            
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
