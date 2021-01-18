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
    
    static func getMarketTypes(completed: @escaping (MarketTypes?)->Void){
     
        Alamofire.request(URL(string: MARKET_TYPES_END_POINT)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("types",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(MarketTypes.self, from: data)
                    print("markettypesModel",dataModel)
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
    
    static func getSheraTypes(completed: @escaping ([MainCategory]?)->Void){
     
        Alamofire.request(URL(string: SHERA_TYPES)!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("types",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode([MainCategory].self, from: JSON(data: data)["Shabratypes"].rawData())
                    print("markettypesModel",dataModel)
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
    
    static func getRoadServicesCategories(completed: @escaping (RoadServicesCategoriesResponse?)->Void){
            
        Alamofire.request(URL(string: ROAD_SERVICES_CATEGORIES_END_POINT)!, method: .get, parameters: nil, headers: SharedData
            .headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                do {
                    let dataModel = try JSONDecoder().decode(RoadServicesCategoriesResponse.self, from: data)
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
    
    static func getCities(completed: @escaping ([District]?)->Void){
        Alamofire.request(CITIES_API, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                do{
                    let dataModel = try JSONDecoder.init().decode([District].self, from: JSON(data)["Cities"].rawData())
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
    
    static func getDistricts(id: Int, completed: @escaping ([District]?)->Void){
        Alamofire.request(DISTRICTS_API + "\(id)", method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in
            switch response.result{
            case .success(let data):
                print("her dists",JSON(data))
                do{
                    let dataModel = try JSONDecoder.init().decode([District].self, from: JSON(data)["Districts"].rawData())
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
    
}

struct District: Codable {
    let id: Int
    let name: String
}
