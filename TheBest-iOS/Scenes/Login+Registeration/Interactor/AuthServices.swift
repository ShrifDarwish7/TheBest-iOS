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
    var user: User{
        get{
            return try! JSONDecoder().decode(User.self, from: defaults.object(forKey: "user") as? Data ?? Data())
        }
        set{
            let userEncoded = try! JSONEncoder().encode(newValue)
            self.defaults.set(userEncoded, forKey: "user")
        }
    }
    
    func loginWith(phone: String, password: String, completed: @escaping (Bool)->Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(phone.data(using: String.Encoding.utf8)!, withName: "phone")
            multipartFormData.append(password.data(using: String.Encoding.utf8)!, withName: "password")
            
        }, to: URL(string: LOGIN_END_POINT)!, method: .post, headers: HEADERS) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let uploadRequest,_,_):
                
                uploadRequest.responseData { (response) in
                    
                    switch response.result{
                        
                    case .success(let data):
                        
                        do{
                            
                            let dataModel = try JSONDecoder().decode(User.self, from: data)
                            self.user = dataModel
                            self.isLogged = true
                            completed(true)
                            
                        }catch{
                            self.isLogged = false
                            completed(false)
                        }
                        
                    case .failure(let error):
                        
                        print("userParseError",error)
                        completed(false)
                        
                    }
                    
                }
                
            case .failure(let error):
                
                print("error",error)
                self.isLogged = false
                completed(false)
                
            }
            
        }
        
    }
    
    func registerWith(parameters: [String: String], completed: @escaping (Bool)->Void){
        
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
                                                        
                            do{
                                
                                let dataModel = try JSONDecoder().decode(User.self, from: data)
                                print("registerDatamodel",dataModel)
                                self.isLogged = true
                                completed(true)
                                
                            }catch let error{
                                print("userParseError",error)
                                self.isLogged = false
                                completed(false)
                            }
                            
                        case .failure(_):
                            
                            self.isLogged = false
                            completed(false)
                            
                        }
                        
                    }
                    
                case .failure(let error):
                    
                    print("error",error)
                    completed(false)
                    
                }
                
            }
        
    }
    
}
