//
//  API-Endpoints.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

let BASE_URL = "https://phplaravel-445196-1394546.cloudwaysapps.com/api/"
let LOGIN_END_POINT = BASE_URL + "Auth/login"
let REGISTER_END_POINT = BASE_URL + "Auth/register"
let MAIN_CATEGORIES_END_POINT = BASE_URL + "Main/AllCategories"
let CATEGORIES_BY_ID_END_POINT = BASE_URL + "Main/CategoryById/"
let PLACES_BY_CATEGORY_END_POINT = BASE_URL + "Main/RlaceByCategory/"
let PLACE_BY_ID_END_POINT = BASE_URL + "Main/RlaceById/"
let MENU_ITEMS_END_POINT = BASE_URL + "Main/MenuItems/"
let PLACE_ORDER_END_POINT = BASE_URL + "Order/store"
let GET_TAXIES_END_POINT = BASE_URL + "Trip/GetTaxi"
let CONFIRM_TRIP_END_POINT = BASE_URL + "Trip/ConfirmRide"
let GET_DISTANCE_END_POINT = BASE_URL + "Trip/GetDistance"
let CANCEL_RIDE_END_POINT = BASE_URL + "Trip/CancelRide"
let NEARBY_MARKETS_END_POINT = BASE_URL + "Main/nearByMarkets"
let MARKETS_FILTER_END_POINT = BASE_URL + "Main/MarketsFilter"
let MARKET_TYPES_END_POINT = BASE_URL + "Main/markettypes"
let SPECIAL_CARS_TYPES_END_POINT = BASE_URL + "SpecialCars/SpecialCarTypes"
let GET_SPECIAL_CAR_END_POINT = BASE_URL + "SpecialCars/GetSpecialCar"
let EQUIPMENTS_END_POINT = BASE_URL + "SpecialCars/RequerdEquipment"
let GET_DISTANCE_SP_CAR_END_POINT = BASE_URL + "SpecialCars/GetDistanceSpCar"
let CONFIRM_SP_RIDE_CAR = BASE_URL + "SpecialCars/ConfirmRideSpCar"
let TRUCK_TYPES_END_POINT = BASE_URL + "Truck/TruckCarTypes"
let GET_TRUCK_END_POINT = BASE_URL + "Truck/GetTruck"
let GET_TRUCK_DISTANCE_END_POINT = BASE_URL + "Truck/GetDistanceTruck"
let TRUCK_CONFIRM_RIDE_END_POINT = BASE_URL + "Truck/ConfirmRideTruck"
let GET_CARS_END_POINT = BASE_URL + "Car/GetCars"
let NEAREST_CARS_END_POINT = BASE_URL + "Car/NearestCars"
let CARS_DISTNCE_END_POINT = BASE_URL + "Car/GetDistanceCar"
let CARS_CONFIRM_RIDE_END_POINT = BASE_URL + "Car/ConfirmRideCar"
let FOOD_ORDERS_HISTORY_END_POINT = BASE_URL + "Order/MyOrders/"

let HEADERS = ["Accept": "application/json"]
