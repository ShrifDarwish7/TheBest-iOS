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

let HEADERS = ["Accept": "application/json"]
