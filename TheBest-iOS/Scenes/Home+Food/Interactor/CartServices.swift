//
//  CartServices.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/29/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation
import CoreData

class CartServices{
    
    static func addToCart(vendorId: Int, vendorName: String, vendorImage: String, deliveryFees: String, arg: CartItemModel, completed: @escaping (Bool)->Void){
    
        self.getCartItems { (items) in
            if let items = items{
                
                if items.filter({ return $0.cartItemId == arg.cartItemId }).isEmpty{
                    
                    let entity = NSEntityDescription.entity(forEntityName: "CartItem", in: SharedData.context)!
                    let newItem = NSManagedObject(entity: entity, insertInto: SharedData.context)
                    newItem.setValue(arg.cartItemId, forKey: "cartItemId")
                    newItem.setValue(Int16(arg.id!), forKey: "id")
                    newItem.setValue(arg.image, forKey: "image")
                    newItem.setValue(arg.name, forKey: "name")
                    newItem.setValue(arg.price ?? 0, forKey: "price")
                    newItem.setValue(Int16(arg.quantity!), forKeyPath: "quantity")
                    //newItem.setValue(Int16(arg.variation!), forKeyPath: "variation")
                    newItem.setValue(arg.notes, forKey: "notes")
                    newItem.setValue(arg.attributeOne, forKey: "attributeOne")
                    newItem.setValue(arg.attributeTwo, forKey: "attributeTwo")
                    newItem.setValue(arg.attributeThree, forKey: "attributeThree")
                    newItem.setValue(arg.attributeOnePrice, forKey: "attributeOnePrice")
                    newItem.setValue(arg.attributeTwoPrice, forKey: "attributeTwoPrice")
                    newItem.setValue(arg.attributeThreePrice, forKey: "attributeThreePrice")
                    newItem.setValue(arg.attributeOneName, forKey: "attributeOneName")
                    newItem.setValue(arg.attributeTwoName, forKey: "attributeTwoName")
                    newItem.setValue(arg.attributeThreeName, forKey: "attributeThreeName")
                    
                    UserDefaults.init().set(vendorName, forKey: "cart_associated_vendor_name")
                    UserDefaults.init().set(vendorImage, forKey: "cart_associated_vendor_image")
                    UserDefaults.init().set(deliveryFees, forKey: "cart_associated_vendor_delivery_fees")
                    UserDefaults.init().set("\(SharedData.food_markets_flag!)", forKey: "food_markets_flag")
                    
                    do{
                        try SharedData.context.save()
                        UserDefaults.init().setValue(vendorId, forKey: "cart_associated_vendorId")
                        completed(true)
                    }catch let error{
                        completed(false)
                        print("contextSave",error)
                    }
                    
                }
                
            }
        }
        
    }
    
    static func getCartItems(completedWith items: @escaping ([CartItemModel]?)->Void){
              
        var temp = [CartItemModel]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartItem")
        
        do {
            let cartItems = try SharedData.context.fetch(fetchRequest)
            for item in cartItems{
                temp.append(CartItemModel(data: item))
            }
            items(temp)
        } catch let error as NSError {
            items(nil)
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    static func updateQuantity(newValue: Int, id: Int, completed: @escaping (Bool)->Void){
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartItem")
        fetchRequest.predicate = NSPredicate(format: "cartItemId == %i", id)
        
        do{
            
            let fetchResult = try SharedData.context.fetch(fetchRequest)
            fetchResult.first!.setValue(newValue, forKey: "quantity")
            try SharedData.context.save()
            completed(true)
            
        }catch let error{
            print("errorQ",error)
            completed(false)
        }
        
    }
    
    static func removeAt(id: Int, removed: @escaping (Bool)->Void){
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CartItem")
        fetchRequest.predicate = NSPredicate(format: "cartItemId == %i", id)
        
        do{
            
            let fetchResult = try SharedData.context.fetch(fetchRequest)
            SharedData.context.delete(fetchResult.first!)
           try  SharedData.context.save()
            removed(true)
            
        }catch{
            removed(false)
        }
        
    }
    
    static func clearCart(){
        
        UserDefaults.init().set("", forKey: "cart_associated_vendor_name")
        UserDefaults.init().set("", forKey: "cart_associated_vendor_image")
        UserDefaults.init().set("", forKey: "cart_associated_vendor_delivery_fees")
        UserDefaults.init().setValue(0, forKey: "cart_associated_vendorId")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "CartItem")
        
        do{
            
            let fetchResult = try SharedData.context.fetch(fetchRequest)
            for item in fetchResult{
                SharedData.context.delete(item)
            }
            
        }catch{
            
        }
        
        
        
    }
    
}
