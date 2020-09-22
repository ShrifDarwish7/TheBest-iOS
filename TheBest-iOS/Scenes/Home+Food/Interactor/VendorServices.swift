//
//  VendorServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VendorServices{
    
    static func getPlaceMenuCategoriesBy(id: Int, completed: @escaping (MenuCategories?)->Void){
              
        Alamofire.request(URL(string: PLACE_BY_ID_END_POINT + "\(id)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("herePlaces",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(MenuCategories.self, from: data)
                    print("MenuCategories",dataModel)
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
    
    static func getMenuItems(id: Int, completed: @escaping (MenuIems?)->Void){

        Alamofire.request(URL(string: MENU_ITEMS_END_POINT + "\(id)")!, method: .get, parameters: nil, headers: SharedData.headers).responseData { (response) in

            switch response.result{

            case .success(let data):

                print("MenuIems",try! JSON(data: data))

                do {
                    let dataModel = try JSONDecoder().decode(MenuIems.self, from: data)
                    print("MenuIems",dataModel)
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
