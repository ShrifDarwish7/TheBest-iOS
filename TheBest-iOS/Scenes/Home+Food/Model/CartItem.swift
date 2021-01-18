//
//  CartItem.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreData

class CartItemModel{
    
    var cartItemId: String?
    var id: Int?
    var name: String?
    var image: String?
    var price: Double?
    var quantity: Int?
   // var variation: Int?
    var notes: String?
    var attributeOne: Int?
    var attributeTwo: Int?
    var attributeThree: Int?
    var attributeOnePrice: Double?
    var attributeTwoPrice: Double?
    var attributeThreePrice: Double?
    var attributeOneName: String?
    var attributeTwoName: String?
    var attributeThreeName: String?
    
    init(cartItemId: String, id: Int, name: String, image: String, price: Double, quantity: Int, notes: String, attributeOne: Int?, attributeTwo: Int?, attributeThree: Int?, attributeOnePrice: Double?, attributeTwoPrice: Double?, attributeThreePrice: Double?, attributeOneName: String?, attributeTwoName: String?, attributeThreeName: String?) {
        self.cartItemId = cartItemId
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.quantity = quantity
       // self.variation = variation
        self.notes = notes
        self.attributeOne = attributeOne
        self.attributeTwo = attributeTwo
        self.attributeThree = attributeThree
        self.attributeOnePrice = attributeOnePrice
        self.attributeTwoPrice = attributeTwoPrice
        self.attributeThreePrice = attributeThreePrice
        self.attributeOneName = attributeOneName
        self.attributeTwoName = attributeTwoName
        self.attributeThreeName = attributeThreeName
    }
    
    init(data : NSManagedObject) {
        cartItemId = data.value(forKey: "cartItemId") as? String
        name = (data.value(forKey: "name") as! String)
        id = (data.value(forKey: "id") as! Int)
        price = (data.value(forKey: "price") as! Double)
        quantity = (data.value(forKey: "quantity") as! Int)
        image = data.value(forKey: "image") as? String
        //variation = data.value(forKey: "variation") as? Int
        notes = data.value(forKey: "notes") as? String
        attributeOne = data.value(forKey: "attributeOne") as? Int
        attributeTwo = data.value(forKey: "attributeTwo") as? Int
        attributeThree = data.value(forKey: "attributeThree") as? Int
        attributeOnePrice = data.value(forKey: "attributeOnePrice") as? Double
        attributeTwoPrice = data.value(forKey: "attributeTwoPrice") as? Double
        attributeThreePrice = data.value(forKey: "attributeThreePrice") as? Double
        attributeOneName = data.value(forKey: "attributeOneName") as? String
        attributeTwoName = data.value(forKey: "attributeTwoName") as? String
        attributeThreeName = data.value(forKey: "attributeThreeName") as? String
    }
    
}
