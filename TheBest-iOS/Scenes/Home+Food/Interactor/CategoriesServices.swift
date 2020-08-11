//
//  CategoriesServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoriesServices{
    
    static func getMainCategories(completed: @escaping (Categories?)->Void){
            
        Alamofire.request(URL(string: MAIN_CATEGORIES_END_POINT)!, method: .get, parameters: nil, headers: SharedData
            .headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                do {
                    let dataModel = try JSONDecoder().decode(Categories.self, from: data)
                    print("mainCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getCategoriesBy(id: Int, completed: @escaping (SubCategories?)->Void){
              
        Alamofire.request(URL(string: CATEGORIES_BY_ID_END_POINT + "\(id)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("here",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(SubCategories.self, from: data)
                    print("SubCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    static func getPlacesBy(categoryId: Int, completed: @escaping (Places?)->Void){
     
        Alamofire.request(URL(string: PLACES_BY_CATEGORY_END_POINT + "\(categoryId)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("herePlaces",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(Places.self, from: data)
                    print("SubCATs",dataModel)
                    completed(dataModel)
                } catch let error {
                    print("parseErr",error)
                    completed(nil)
                }

            case .failure(_):

                completed(nil)

            }

        }
        
    }
    
    
}
