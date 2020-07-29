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
    var price: Int?
    var quantity: Int?
   // var vendorId: Int?
    
    init(id: Int, name: String, image: String, price: Int, quantity: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.quantity = quantity
       // self.vendorId = vendorId
    }
    
    init(data : NSManagedObject) {
        name = (data.value(forKey: "name") as! String)
        id = (data.value(forKey: "id") as! Int)
        price = (data.value(forKey: "price") as! Int)
        quantity = (data.value(forKey: "quantity") as! Int)
        image = data.value(forKey: "image") as? String
       // vendorId = data.value(forKey: "vendorId") as? Int
    }
    
}
