//
//  VendorProfilePresenter.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

protocol VendorViewDelegate {
    
    func showSVProgress()
    func dismissSVProgress()
    func didSuccessfullyFetchingMenuCategories(_ result: MenuCategories)
    func didFailFetchingMenuCategories()
    
    func didSuccessfullyFetchMenuItems(_ result: MenuIems)
    func didFailFetchMenuItems()
    
}

class VendorProfilePresenter{
    
    private var vendorViewDelegte: VendorViewDelegate?
    
    init(vendorViewDelegte: VendorViewDelegate) {
        self.vendorViewDelegte = vendorViewDelegte
    }
    
    func fetchMenuCategories(id: Int){
        
        self.vendorViewDelegte?.showSVProgress()
        
        VendorServices.getPlaceMenuCategoriesBy(id: id) { (menuCategories) in
            
            if let menuCategories = menuCategories{
                self.vendorViewDelegte?.didSuccessfullyFetchingMenuCategories(menuCategories)
            }else{
                self.vendorViewDelegte?.didFailFetchingMenuCategories()
            }
            
            self.vendorViewDelegte?.dismissSVProgress()
            
        }
        
    }
    
    func fetchMenuItems(id: Int){
        self.vendorViewDelegte?.showSVProgress()
        VendorServices.getMenuItems(id: id, completed: { (menuItems) in
            var items = menuItems.restaurantMenu
            for i in 0...items.count-1{
                var variations = [Variation]()
                if  let _ = items[i].attributeTitle ,
                    let _ = items[i].attributeTitleEn ,
                    let _ = items[i].attributeBody{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBody?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: items[i].attributeTitle!, titleEn: items[i].attributeTitleEn!, body: bodyDecoded))
                    }
                }
                if  let _ = items[i].attributeTitleTwo ,
                    let _ = items[i].attributeTitleEnTwo ,
                    let _ = items[i].attributeBodyTwo{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBodyTwo?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: items[i].attributeTitleTwo!, titleEn: items[i].attributeTitleEnTwo!, body: bodyDecoded))
                    }
                }
                if  let _ = items[i].attributeTitleThree ,
                    let _ = items[i].attributeTitleEnThree ,
                    let _ = items[i].attributeBodyThree{
                    
                    if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBodyThree?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
                        variations.append(Variation(titleAr: items[i].attributeTitleThree!, titleEn: items[i].attributeTitleEnThree!, body: bodyDecoded))
                    }
                }
                items[i].variations = variations
                print("body\(i)",items[i].variations)
            }
            menuItems.restaurantMenu = items
            self.vendorViewDelegte?.didSuccessfullyFetchMenuItems(menuItems)
            self.vendorViewDelegte?.dismissSVProgress()
        }) { (faild) in
            self.vendorViewDelegte?.dismissSVProgress()
            self.vendorViewDelegte?.didFailFetchMenuItems()
        }
        //        VendorServices.getMenuItems(id: id) { (menuItems) in
        //            if let menuItems = menuItems{
        //                let items = menuItems.restaurantMenu
        //                for i in 0...menuItems.restaurantMenu.count-1{
        //                    var variations = [Variation]()
        //                    if  let _ = items[i].attributeTitle ,
        //                        let _ = items[i].attributeTitleEn ,
        //                        let _ = items[i].attributeBody{
        //
        //                        if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBody?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
        //                            variations.append(Variation(titleAr: items[i].attributeTitle!, titleEn: items[i].attributeTitleEn!, body: bodyDecoded))
        //                        }
        //                    }
        //                    if  let _ = items[i].attributeTitleTwo ,
        //                        let _ = items[i].attributeTitleEnTwo ,
        //                        let _ = items[i].attributeBodyTwo{
        //
        //                        if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBodyTwo?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
        //                            variations.append(Variation(titleAr: items[i].attributeTitleTwo!, titleEn: items[i].attributeTitleEnTwo!, body: bodyDecoded))
        //                        }
        //                    }
        //                    if  let _ = items[i].attributeTitleThree ,
        //                        let _ = items[i].attributeTitleEnThree ,
        //                        let _ = items[i].attributeBodyThree{
        //
        //                        if let bodyDecoded = try? JSONDecoder.init().decode([BodyItem].self, from: items[i].attributeBodyThree?.replacingOccurrences(of: "\\", with: "").data(using: .utf8) ?? Data()){
        //                            variations.append(Variation(titleAr: items[i].attributeTitleThree!, titleEn: items[i].attributeTitleEnThree!, body: bodyDecoded))
        //                        }
        //                    }
        //                    items[i].variations = variations
        //                    //print("body\(i)",response[i].variations)
        //                }
        //                self.vendorViewDelegte?.didSuccessfullyFetchMenuItems(menuItems)
        //            }else{
        //                self.vendorViewDelegte?.didFailFetchMenuItems()
        //            }
        //            self.vendorViewDelegte?.dismissSVProgress()
        //        }
        
    }
    
}
