//
//  FoodOrdersHistory.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 9/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - NewOrdersResponse
struct FoodOrdersHistory: Codable {
    let data: [Order]
}

// MARK: - Datum
struct Order: Codable {
    let id: Int
    let username: String
    let userID: Int
    let lat, lng: Double
    let comment: String?
    let address, phone, total: String?
    let trip: Trip
    let orderItems: [OrderItem]
    let status, orderDate: String
    var expanded: Bool?

    enum CodingKeys: String, CodingKey {
        case id, username
        case userID = "user_id"
        case lat, lng, comment, address, phone, total, trip
        case orderItems = "order_items"
        case status
        case orderDate = "order date"
    }
    
}

// MARK: - OrderItem
struct OrderItem: Codable {
    let id, itemID, placeID, orderID: Int
    let count: Int
    let attributeBody, attributeBodyTwo, attributeBodyThree: String
    let additional: String?
    let itemName, restaurantName, restaurantAddress, restaurantImage: String
    let firstAttrItemsNameAr, firstAttrItemsNameEn: String?
    let firstAttrItemsBody: AttrItemsBody?
    let secondAttrItemsNameAr, secondAttrItemsNameEn: String?
    let secondAttrItemsBody: AttrItemsBody?
    let thirdAttrItemsNameAr, thirdAttrItemsNameEn: String?
    let thirdAttrItemsBody: AttrItemsBody?

    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case placeID = "place_id"
        case orderID = "order_id"
        case count
        case attributeBody = "attribute_body"
        case attributeBodyTwo = "attribute_body_two"
        case attributeBodyThree = "attribute_body_three"
        case additional
        case itemName = "Item Name"
        case restaurantName = "Restaurant Name"
        case restaurantAddress = "Restaurant address"
        case restaurantImage = "Restaurant image"
        case firstAttrItemsNameAr = "FirstAttrItemsNameAr"
        case firstAttrItemsNameEn = "FirstAttrItemsNameEn"
        case firstAttrItemsBody = "FirstAttrItemsBody"
        case secondAttrItemsNameAr = "SecondAttrItemsNameAr"
        case secondAttrItemsNameEn = "SecondAttrItemsNameEn"
        case secondAttrItemsBody = "SecondAttrItemsBody"
        case thirdAttrItemsNameAr = "ThirdAttrItemsNameAr"
        case thirdAttrItemsNameEn = "ThirdAttrItemsNameEn"
        case thirdAttrItemsBody = "ThirdAttrItemsBody"
    }
}

// MARK: - AttrItemsBody
struct AttrItemsBody: Codable {
    let nameAr, nameEn, price: String

    enum CodingKeys: String, CodingKey {
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case price
    }
}

struct TripByIDResponse: Codable {
    let status: Int
    let trip: Trip

    enum CodingKeys: String, CodingKey {
        case status
        case trip = "Trip"
    }
}

//// MARK: - Trip
//struct Trip: Codable {
//    let id, clientID: Int
//    let driverID: String?
//    let fromLat, fromLng, toLat, toLng: Double
//    let paymentMethod, total: String?
//    let status: String
//    let addressFrom, addressTo, driverComment, rideType: String?
//    let orderID: Int
//    let createdAt, updatedAt: String
//    let scheduleAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case clientID = "client_id"
//        case driverID = "driver_id"
//        case fromLat = "from_lat"
//        case fromLng = "from_lng"
//        case toLat = "to_lat"
//        case toLng = "to_lng"
//        case paymentMethod = "payment_method"
//        case total, status
//        case addressFrom = "address_from"
//        case addressTo = "address_to"
//        case driverComment = "driver_comment"
//        case rideType = "ride_type"
//        case orderID = "order_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case scheduleAt = "schedule_at"
//    }
//}

// MARK: - MyTrip
struct Trip: Codable {
    let id, clientID, driverID: Int?
    let fromLat, fromLng, toLat, toLng: Double?
    let paymentMethod: String?
    let total: Int?
    let status, addressFrom, addressTo: String?
    let driverComment: String?
    let rideType: Int?
    let createdAt, updatedAt: String?
    //let order: Order?
    let tripFurniture: [Furniture]?
    let tripPrivateCars: [PrivateCars]?
    let tripMonthly: [Monthly]?
    let tripRoadServices: [TripRoadServices]?

    enum CodingKeys: String, CodingKey {
        case id
        case clientID = "client_id"
        case driverID = "driver_id"
        case fromLat = "from_lat"
        case fromLng = "from_lng"
        case toLat = "to_lat"
        case toLng = "to_lng"
        case paymentMethod = "payment_method"
        case total, status
        case addressFrom = "address_from"
        case addressTo = "address_to"
        case driverComment = "driver_comment"
        case rideType = "ride_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
       // case order
        case tripFurniture = "trip__furniture"
        case tripPrivateCars = "trip__privte_cars"
        case tripMonthly = "trip__monthly"
        case tripRoadServices = "trip__road_service"
    }
}


struct TripRoadServices: Codable{
    let tripId: Int?
    let serviceName: String?
    let serviceImage: String?
    let serviceCount: String?
    let note: String?
    let serviceDesc: String?
    let servicePrice: String?
    
    enum CodingKeys: String, CodingKey {
        case tripId = "trip_id"
        case serviceName = "service_name"
        case serviceImage = "service_image"
        case serviceCount = "service_count"
        case note
        case serviceDesc = "service_desc"
        case servicePrice = "service_price"
    }
}

struct Monthly: Codable {
    let tripId: Int?
    let fromDate: String?
    let toDate: String?
    let fromTime: String?
    let toTime: String?
    let workingDays: [String]?
    let goingComing: Int?
    let needs: String?
    
    enum CodingKeys: String, CodingKey{
        case tripId = "trip_id"
        case fromDate = "from_date"
        case toDate = "to_date"
        case fromTime = "from_time"
        case toTime = "to_time"
        case workingDays = "working_days"
        case goingComing = "going_coming"
        case needs = "required_equipment"
    }
}

struct PrivateCars: Codable {
    let tripId: Int?
    let equipments: String?
    let priceMethod: String?
    let carType: String?
    let priceMethodFrom: String?
    let priceMethodTo: String?
    
    enum CodingKeys: String, CodingKey{
        case tripId = "trip_id"
        case equipments = "required_equipment"
        case priceMethod = "price_method"
        case carType = "car_type"
        case priceMethodFrom = "price_method_from"
        case priceMethodTo = "price_method_to"
    }
    
}

struct Furniture: Codable{
    let tripId: Int?
    let serviceName: String?
    let serviceImage: String?
    let serviceCount: String?
    let note: String?
    let techsCount: String?
    let workersCount: String?
    let date: String?
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case tripId = "trip_id"
        case serviceName = "service_name"
        case serviceImage = "service_image"
        case serviceCount = "service_count"
        case note, date, time
        case techsCount = "number_technicians"
        case workersCount = "number_workers"
    }
}
