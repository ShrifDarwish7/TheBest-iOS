//
//  TripsServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/1/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import GoogleMaps

class TripsServices{
    
    static func getTripBy(_ id: String, _ completed: @escaping (TripByIDResponse?)->Void){
        Alamofire.request(URL(string: GET_TRIP_BY_ID + id)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    
                    let json = JSON(data)
                    print(json)
                    
                    if json["status"].intValue == 200{
                        let dataModel = try JSONDecoder().decode(TripByIDResponse.self, from: data)
                        completed(dataModel)
                    }else{
                        completed(nil)
                    }
                    
                }catch let error{
                    print(error)
                    
                    completed(nil)
                }
            case .failure(let error):
                print(error)
                
                completed(nil)
            }
        }
    }
    
    static func getAddressFromGoogleMapsAPI(location : String , completed: @escaping ( _ address: GoogleMapsGeocodeAddress? )->Void) {
        
        Alamofire.request("https://maps.google.com/maps/api/geocode/json?language=\("lang".localized)&latlng=\(location)&key=\(SharedData.goolgeApiKey)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    let json = JSON(data)
                    print(json)
                    if let result = JSON(data)["results"].array,
                        result.count > 0{
                        let dataModel = GoogleMapsGeocodeAddress(JSON(data)["results"])
                        completed(dataModel)
                    }else{
                        completed(nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
        }
    }
    
    static func getDirectionFromGoogleMapsAPI(origin: String, destination: String, completed: @escaping ( _ polyline: GMSPolyline? )->Void) {
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(SharedData.goolgeApiKey)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    
                    do{
                        
                        let json = try JSON(data: data)
                        print(json)
                        let routes = json["routes"].arrayValue
                        
                        for route in routes{
                            
                            let overviewPolyline = route["overview_polyline"].dictionary
                            let points  = overviewPolyline?["points"]?.string
                            let path = GMSPath(fromEncodedPath: points ?? "")
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5
                            completed(polyline)
                            
                        }
                        
                    }catch{
                        completed(nil)
                    }
                    
                case .failure(let error):
                    print(error)
                    completed(nil)
                }
        }
    }
    
    static func getNearByTaxies(completed: @escaping (Taxi?)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            
        }, to: URL(string: GET_TAXIES_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("nearBy", try! JSON(data: data))
                        do{
                            
                            let dataModel = try JSONDecoder.init().decode(Taxi.self, from: data)
                            completed(dataModel)
                            
                        }catch let error{
                            print("taxiParsErr",error)
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
    
    static func confirmRide(completed: @escaping (Bool)->Void){
        
        print(UserDefaults.init().double(forKey: "trip_total"))
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "lng")
            multipartFormData.append("\(SharedData.userLat ?? 0)".data(using: .utf8)!, withName: "from_lat")
            multipartFormData.append("\(SharedData.userLng ?? 0)".data(using: .utf8)!, withName: "from_lng")
            multipartFormData.append("\(SharedData.userDestinationLat ?? 0)".data(using: .utf8)!, withName: "to_lat")
            multipartFormData.append("\(SharedData.userDestinationLng ?? 0)".data(using: .utf8)!, withName: "to_lng")
            multipartFormData.append("\(SharedData.userFromAddress ?? "")".data(using: .utf8)!, withName: "address_from")
            multipartFormData.append("\(SharedData.userToAddress ?? "")".data(using: .utf8)!, withName: "address_to")
            multipartFormData.append("\(UserDefaults.init().double(forKey: "trip_total") > 9999.0 ? 9999.0 : UserDefaults.init().double(forKey: "trip_total"))".data(using: .utf8)!, withName: "total")
            
        }, to: URL(string: CONFIRM_TRIP_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("confirmRide", try! JSON(data: data))
                        
                        
                        UserDefaults.init().setValue(1, forKey: "ride_type")
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
    
    static func getDistance(completed: @escaping (Distance?)->Void){
        
        let parameters = [
            "latitudeFrom": SharedData.userLat,
            "longitudeFrom": SharedData.userLng,
            "latitudeTo": SharedData.userDestinationLat,
            "longitudeTo": SharedData.userDestinationLng
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key,value) in parameters{
                multipartFormData.append("\(value ?? 0)".data(using: .utf8)!, withName: key)
            }
            
        }, to: URL(string: GET_DISTANCE_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
            
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
    
    static func cancelRide(completed: @escaping (Bool)->Void ){
        
        print(SharedData.headers)
        
        Alamofire.request(URL(string: CANCEL_RIDE_END_POINT)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            
            switch response.result{
                
            case .success(let data):
                
                do{
                    
                    let json = try JSON(data: data)
                    print(json)
                    if let msg = json["message"].string , msg == "Ride Had Been Cancel"{
                        completed(true)
                    }else{
                        print("1")
                        completed(false)
                    }
                    
                }catch{
                    print("2")
                    completed(false)
                }
                
            case .failure(_):
                print("3")
                completed(false)
                
            }
            
        }
    }
    
    static func callDriver(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
        
      }
    }
    
    static func getDriverBy(id: Int, completed: @escaping (DriverByIDResponse?)->Void){
        
        Alamofire.request(DRIVER_BY_ID_END_POINT + "\(id)", method: .get, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                print(JSON(data))
                
                do{
                    let dataModel = try JSONDecoder().decode(DriverByIDResponse.self, from: data)
                    print("getDriverByModel",dataModel)
                    completed(dataModel)
                }catch let error{
                    print("driverParseErr",error)
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
        
    }
    
}
