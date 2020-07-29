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
    
    static func addToCart(vendorId: Int, arg: CartItemModel, completed: @escaping (Bool)->Void){
    
        self.getCartItems { (items) in
            if let items = items{
                
                if items.filter({ return $0.id == arg.id }).isEmpty{
                    
                    let entity = NSEntityDescription.entity(forEntityName: "CartItem", in: SharedData.context)!
                    let newItem = NSManagedObject(entity: entity, insertInto: SharedData.context)
                    newItem.setValue(Int16(arg.id!), forKey: "id")
                    newItem.setValue(arg.image, forKey: "image")
                    newItem.setValue(arg.name, forKey: "name")
                    newItem.setValue(arg.price ?? 0, forKey: "price")
                    newItem.setValue(Int16(arg.quantity!), forKeyPath: "quantity")
                  //  newItem.setValue(arg.vendorId, forKey: "vendorId")
                    
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
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
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
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
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
