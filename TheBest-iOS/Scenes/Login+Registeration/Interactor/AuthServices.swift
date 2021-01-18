//
//  AuthServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthServices{
    
    static let instance = AuthServices()
    let defaults = UserDefaults.standard
    var isLogged: Bool{
        set{
            self.defaults.set(newValue, forKey: "isLogged")
        }
        get{
            return self.defaults.bool(forKey: "isLogged")
        }
    }
    var user: UserModel{
        get{
            return try! JSONDecoder().decode(UserModel.self, from: defaults.object(forKey: "user") as? Data ?? Data())
        }
        set{
            let userEncoded = try! JSONEncoder().encode(newValue)
            self.defaults.set(userEncoded, forKey: "user")
        }
    }
    
    static func loginWith(phone: String, fcmToken: String, completed: @escaping (Bool, _ newUser: Bool)->Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(phone.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(fcmToken.data(using: String.Encoding.utf8)!, withName: "fcm_token")
            
        }, to: URL(string: LOGIN_END_POINT)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        print("user",try? JSON(data: data))
                        
                        do{
                            
                            if let message = try JSON(data: data)["message"].string, message == "This Phone Number Is Not Used Before"{
                                
                                completed(true,true)
                                return
                                
                            }else{
                                
                                let dataModel = try JSONDecoder().decode(User.self, from: data)
                                self.instance.user = dataModel.user!
                                UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                                print(dataModel)
                                self.instance.isLogged = true
                                completed(true,false)
                                
                            }
                            
                        }catch let error{
                            print("parsErrr",error)
                            self.instance.isLogged = false
                            completed(false,false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false,false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.instance.isLogged = false
                completed(false,false)
                
            }
            
        }
        
    }
    
    static func registerWith(parameters: [String: String], completed: @escaping (Bool)->Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
                
            for (key,value) in parameters{
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
                
            }, to: URL(string: REGISTER_END_POINT)!, method: .post, headers: HEADERS) { (encodingResult) in
                
                switch encodingResult{
                    
                case .success(let uploadRequest,_,_):
                    
                    uploadRequest.responseData { (response) in
                        
                        switch response.result{
                            
                        case .success(let data):
                                   
                            print("regJSON", try! JSON(data: data))
                            
                            do{
                                
                                let dataModel = try JSONDecoder().decode(User.self, from: data)
                                print("registerDatamodel",dataModel)
                                self.instance.user = dataModel.user!
                                UserDefaults.init().set(JSON(data)["accessToken"].stringValue, forKey: "accessToken")
                                self.instance.isLogged = true
                                completed(true)
                                
                            }catch let error{
                                print("userParseError",error)
                                self.instance.isLogged = false
                                completed(false)
                            }
                            
                        case .failure(_):
                            
                            self.instance.isLogged = false
                            completed(false)
                            
                        }
                        
                    }
                    
                case .failure(let error):
                    
                    print("error",error)
                    completed(false)
                    
                }
                
            }
        
    }
    
    static func updateProfileWith(parameters: [String: String], completed: @escaping (Bool)->Void){
        URLCache.shared.removeAllCachedResponses()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
                
            for (key,value) in parameters{
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
                
        }, to: URL(string: UPDATE_PROFILE_END_POINT)!, method: .post, headers: SharedData.headers) { (encodingResult) in
                
                switch encodingResult{
                    
                case .success(let uploadRequest,_,_):
                    
                    uploadRequest.responseData { (response) in
                        
                        switch response.result{
                            
                        case .success(let data):
                                   
                            print("updateProfileWith", try! JSON(data: data))
                            
                            if JSON(data)["code"].intValue == 100{
                                
                                do{
                                    
                                    
                                    let dataModel = try JSONDecoder().decode(UpdateResponse.self, from: data)
                                    self.instance.user = dataModel.item
                                    completed(true)
                                    
                                }catch{
                                    completed(false)
                                }
                                
                            }else{
                                completed(false)
                            }
                            
                        case .failure(_):
                            
                            self.instance.isLogged = false
                            completed(false)
                            
                        }
                        
                    }
                    
                case .failure(let error):
                    
                    print("error",error)
                    completed(false)
                    
                }
                
            }
        
    }
    
    static func logout(){
        
        let dictionary = AuthServices.instance.defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
                AuthServices.instance.defaults.removeObject(forKey: key)
        }
    }
    
    static func getMyProfile(completed: @escaping (MyProfileResponse?)->Void){
        Alamofire.request(MY_PROFILE, method: .get, parameters: nil, headers: SharedData.headers).responseData { (res) in
            switch res.result{
            case .success(let data):
                do{
                    print(JSON(data))
                    
                    let dataModel = try JSONDecoder.init().decode(MyProfileResponse.self, from: data)
                    self.instance.user = dataModel.myProfile
                    completed(dataModel)
                }catch let err{
                    print(err)
                    completed(nil)
                }
            case .failure(_):
                completed(nil)
            }
        }
    }
    
}
