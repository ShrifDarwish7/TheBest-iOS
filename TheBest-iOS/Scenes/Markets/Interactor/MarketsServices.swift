//
//  MarketsServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MarketsServices{
    
    static func getNearByMarkets(completed: @escaping (NearByMarkets?)->Void){
        
        let parameters = [
            "lat": "\(SharedData.userLat ?? 0.0)",
            "lng": "\(SharedData.userLng ?? 0.0)"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append((value).data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: NEARBY_MARKETS_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("NEARBY_MARKETS", try! JSON(data: data))
                        do{
                            
                            let dataModel = try JSONDecoder().decode(NearByMarkets.self, from: data)
                            completed(dataModel)
                            
                        }catch let err{
                            print("pars",err)
                            completed(nil)
                        }
                        
                    case .failure(let error):
                        
                        print("NEARBY_MARKETS error",error)
                        completed(nil)
                        
                    }
                }
                
            case .failure(_):
                completed(nil)
                
            }
        }
    }
    
    static func filterMarkets(country: String, government: String, district: String, completed: @escaping (Markets?)->Void){
        
        let parameters = [
            "country": country,
            "government": government,
            "district": district
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append((value).data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: MARKETS_FILTER_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("MARKETS_FILTER", try! JSON(data: data))
                        do{
                            
                            let dataModel = try JSONDecoder().decode(Markets.self, from: data)
                            completed(dataModel)
                            
                        }catch let err{
                            print("pars",err)
                            completed(nil)
                        }
                        
                    case .failure(let error):
                        
                        print("MARKETS_FILTER error",error)
                        completed(nil)
                        
                    }
                }
                
            case .failure(_):
                completed(nil)
                
            }
        }
    }
    
}
