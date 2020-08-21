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
                    print(json)
                    do{
                        
                        let dataModel = try JSONDecoder().decode(SpecialCars.self, from: data)
                        completed(dataModel)
                        
                    }catch{
                        completed(nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
        }
    }
    
    static func getSpecialCar(id: String, completed: @escaping (SpecialCarResult?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            multipartFormData.append(id.data(using: .utf8)!, withName: "category_id")
            
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
    
}
