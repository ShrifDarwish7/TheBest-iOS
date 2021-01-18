//
//  SharedData.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/23/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class SharedData{
    
    static var phone: String?
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let goolgeApiKey = "AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE"
    static var userLat: CLLocationDegrees?
    static var userLng: CLLocationDegrees?
    static var userDestinationLat: CLLocationDegrees?
    static var userDestinationLng: CLLocationDegrees?
    static var userFromAddress: String?
    static var userToAddress: String?
    static var receivedDriverId: String?
    static var total: Double?
    static var receivedTripID: Int?
    static var currentTrip: Trip?
    static var inProgressStatus = "in progress"
    static var orderOnDeliveryStatus = "on delivery"
    static var arrivedStatus = "arrived"
    static var completedStatus = "completed"
    static let headers = [
        "Authorization": "Bearer " + (UserDefaults.init().string(forKey: "accessToken") ?? ""),
        "Accept": "application/json"
    ]
    
    static func forwardToWhatsapp(_ phone: String) {
        let phoneWithDial = phone.starts(with: "01") == true ? "+2" + phone : phone
        let urlWhats = "whatsapp://send?phone=" + phoneWithDial
        
        let characterSet = CharacterSet.urlQueryAllowed
       // characterSet.insert(charactersIn: "?&")
        
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: characterSet){
            
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL){
                    UIApplication.shared.open(whatsappURL as URL, completionHandler: nil)
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    static var days: [Day] = [
        Day(id: 0, day: "Saturday", selected: false),
        Day(id: 1, day: "Sunday", selected: false),
        Day(id: 2, day: "Monday", selected: false),
        Day(id: 3, day: "Tuesday", selected: false),
        Day(id: 4, day: "Wednesday", selected: false),
        Day(id: 5, day: "Thursday", selected: false),
        Day(id: 6, day: "Friday", selected: false),
    ]
    static var food_markets_flag: Int?
    
    static var appCategories: [AppCategory]{
        var appCategories = [AppCategory]()
        appCategories.append(AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe"))
        appCategories.append(AppCategory(icon: UIImage(named: "taxi_icon562"), name: "Taxi services"))
        appCategories.append(AppCategory(icon: UIImage(named: "car_icon161"), name: "Car rent"))
        appCategories.append(AppCategory(icon: UIImage(named: "special_need_icon451"), name: "Special need car"))
        appCategories.append(AppCategory(icon: UIImage(named: "market_icon46"), name: "Markets & Associations"))
        //appCategories.append(AppCategory(icon: UIImage(named: "azzount_icon"), name: "Monthly  Account"))
        appCategories.append(AppCategory(icon: UIImage(named: "road_icon6463"), name: "Road rescue services"))
        appCategories.append(AppCategory(icon: UIImage(named: "furniture_icon159"), name: "Furniture transporting"))
        return appCategories
    }
    
    static func getColor(_ index: Int)->UIColor{
        switch index{
        case 1,2:
            return UIColor(named: "TaxiGoldColor")!
//        case 2:
//            return UIColor(named: "CarRentColor")!
        case 4:
            return UIColor(named: "SpecialNeedCarColor")!
      /*  case 4:
            return UIColor(named: "MarketsColor")!*/
        case 15:
            return UIColor(named: "RoadServicesColor")!
        case 16:
            return UIColor(named: "FurnitureColor")!
        case 17:
            return UIColor(named: "MonthlyColor")!
        case 40:
            return UIColor(named: "RestaurantsColor")!
        case 21:
            return UIColor(named: "CarRentColor")!
        case 43:
            return UIColor(named: "MarketsColor")!
        case 41:
            return UIColor(named: "vegColor")!
        default:
            return UIColor(named: "RestaurantsColor")!
        }
    }
    
    static func getRideType(_ index: Int)->AppCategory{
        switch index{
        case 1,2:
            return AppCategory(icon: UIImage(named: "taxi_icon562"), name: "Taxi services")
//        case 2:
//            return AppCategory(icon: UIImage(named: "car_icon161"), name: "Car rent")
        case 4:
            return AppCategory(icon: UIImage(named: "special_need_icon451"), name: "Special need car")
      /*  case 4:
            return UIColor(named: "MarketsColor")!*/
        case 15:
            return AppCategory(icon: UIImage(named: "road_icon6463"), name: "Road services")
        case 16:
            return AppCategory(icon: UIImage(named: "furniture_icon159"), name: "Furniture transporting")
        case 17:
            return AppCategory(icon: UIImage(named: "azzount_icon"), name: "Monthly subscript")
        case 40:
            return AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe")
        case 21:
            return AppCategory(icon: UIImage(named: "car_icon161"), name: "Car")
        case 43:
            return AppCategory(icon: UIImage(named: "market_icon46"), name: "Markets")
        case 41:
            return AppCategory(icon: UIImage(named: "market_icon46"), name: "")
        default:
            return AppCategory(icon: UIImage(named: "food_icon6262"), name: "Restaurants & Cafe")
        }
    }
}

struct Day {
    var id: Int
    var day: String
    var selected: Bool
}
