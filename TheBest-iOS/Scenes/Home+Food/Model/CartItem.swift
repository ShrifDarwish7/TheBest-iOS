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
    
    var id: Int?
    var name: String?
    var image: String?
    var price: Double?
    var quantity: Int?
    var variation: Int?
    var notes: String?
    
    init(id: Int, name: String, image: String, price: Double, quantity: Int, variation: Int, notes: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.quantity = quantity
        self.variation = variation
        self.notes = notes
    }
    
    init(data : NSManagedObject) {
        name = (data.value(forKey: "name") as! String)
        id = (data.value(forKey: "id") as! Int)
        price = (data.value(forKey: "price") as! Double)
        quantity = (data.value(forKey: "quantity") as! Int)
        image = data.value(forKey: "image") as? String
        variation = data.value(forKey: "variation") as? Int
        notes = data.value(forKey: "notes") as? String
    }
    
}
