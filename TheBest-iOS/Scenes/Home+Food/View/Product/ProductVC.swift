//
//  ProductVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/27/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ProductVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var productImageVIew: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet var roundView: [UIView]!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var quantityNumer: UILabel!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var customerNote: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var variationTableHeight: NSLayoutConstraint!
    @IBOutlet weak var variationTableView: UITableView!
    @IBOutlet weak var productPrice: UILabel!
    
    var itemReceived: RestaurantMenuItem?
    var productPresenter: ProductPresenter?
    var vendorName: String?
    var vendorImage: String?
  //  var selectedVariationIndex: Int?
    //var selectedVariationPrice: Int?
    var selectedAttributeOneIndex: Int?
    var selectedAttributeTwoIndex: Int?
    var selectedAttributeThreeIndex: Int?
    var selectedAttributeOneIndexPrice: Double?
    var selectedAttributeTwoIndexPrice: Double?
    var selectedAttributeThreeIndexPrice: Double?
    var selectedAttributeOneIndexName: String?
    var selectedAttributeTwoIndexName: String?
    var selectedAttributeThreeIndexName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        productPresenter = ProductPresenter(productViewDelegate: self)
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        for view in roundView{
            view.layer.cornerRadius = 15
        }
        
        addToCartView.layer.cornerRadius = 15
        
        productImageVIew.sd_setImage(with: URL(string: itemReceived?.hasImage ?? ""))
        productName.text = itemReceived?.name
        productDesc.text = itemReceived?.descriptionEn
        productPrice.text = (itemReceived?.price ?? "") + " " + "KWD"
        
        plus.onTap {
            let count = Int(self.quantityNumer.text!)!
            self.quantityNumer.text = String(count + 1)
        }
        minus.onTap {
            let count = Int(self.quantityNumer.text!)!
            if count > 1 {
                self.quantityNumer.text = String(count - 1)
            }
        }
        
        self.loadVariationTableFromNIB()
        
        addToCartView.addTapGesture { (_) in
            
//            if !(self.itemReceived?.variations!.isEmpty)!{
//
//                if self.itemReceived?.variations!.count == 1{
//                    guard let _ = self.selectedAttributeOneIndex else {
//                        self.showAlert(title: "", message: "You must selected one of each product attributes")
//                        return
//                    }
//                }
//                if self.itemReceived?.variations!.count == 2{
//                    guard let _ = self.selectedAttributeOneIndex , let _ = self.selectedAttributeTwoIndex else {
//                        self.showAlert(title: "", message: "You must selected one of each product attributes")
//                        return
//                    }
//                }
//                if self.itemReceived?.variations!.count == 3{
//                    guard let _ = self.selectedAttributeOneIndex , let _ = self.selectedAttributeTwoIndex, let _ = self.selectedAttributeThreeIndex else {
//                        self.showAlert(title: "", message: "You must selected one of each product attributes")
//                        return
//                    }
//                }
//
//            }
            
//            if !(self.itemReceived?.variations!.isEmpty)! && self.selectedAttributeOneIndex == nil && self.selectedAttributeTwoIndex == nil && self.selectedAttributeThreeIndex == nil{
//                self.showAlert(title: "", message: "You must selected at least one of product attributes")
//                return
//            }
            
            var estimatedItemID = ""
            
            if let _ = self.selectedAttributeOneIndex{
                estimatedItemID += "1\(self.selectedAttributeOneIndex ?? 0)"
            }
            if let _ = self.selectedAttributeTwoIndex{
                estimatedItemID += "2\(self.selectedAttributeTwoIndex ?? 0)"
            }
            if let _ = self.selectedAttributeThreeIndex{
                estimatedItemID += "3\(self.selectedAttributeThreeIndex ?? 0)"
            }
            
            self.productPresenter?.addToCart(vendorId: self.itemReceived!.restaurantID!,
                                             vendorName: self.vendorName!,
                                             vendorImage: self.vendorImage!,
                                             deliveryFees: "0",
                                             arg: CartItemModel(
                                                cartItemId: "\(self.itemReceived?.id ?? 0)" + estimatedItemID,
                                                id: self.itemReceived!.id!,
                                                name: self.itemReceived!.name!,
                                                image: self.itemReceived!.hasImage ,
                                                price: Double(self.itemReceived!.price!) ?? 0.0,
                                                quantity: Int(self.quantityNumer.text!)!,
                                                notes: self.customerNote.text,
                                                attributeOne: self.selectedAttributeOneIndex,
                                                attributeTwo: self.selectedAttributeTwoIndex,
                                                attributeThree: self.selectedAttributeThreeIndex,
                                                attributeOnePrice: self.selectedAttributeOneIndexPrice,
                                                attributeTwoPrice: self.selectedAttributeTwoIndexPrice,
                                                attributeThreePrice: self.selectedAttributeThreeIndexPrice,
                                                attributeOneName: self.selectedAttributeOneIndexName,
                                                attributeTwoName: self.selectedAttributeTwoIndexName,
                                                attributeThreeName: self.selectedAttributeThreeIndexName
            ))
            
        }
        
//        self.variationTitle.text = self.itemReceived?.attributeTitle
//        loadVariationTableView()
//        self.variationViewHeight.constant = CGFloat(((self.itemReceived?.itemattributes.count)! * 30) + 65)
//        self.variationTableHeight.constant = CGFloat((self.itemReceived?.itemattributes.count)! * 30)
//
//        if (self.itemReceived?.itemattributes.count)! == 0{
//            variationView.isHidden = true
//        }

    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.variationTableHeight?.constant = self.variationTableView.contentSize.height + 10
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.updateViewConstraints()
        self.variationTableHeight?.constant = self.variationTableView.contentSize.height + 10
        self.view.layoutIfNeeded()
    }

//    func loadVariationTableView(){
//
//        let nib = UINib(nibName: "VariationTableViewCell", bundle: nil)
//        variationTableView.register(nib, forCellReuseIdentifier: "VariationCell")
//
//        variationTableView.numberOfRows { (_) -> Int in
//            return (self.itemReceived?.itemattributes.count)!
//        }.cellForRow { (index) -> UITableViewCell in
//
//            let cell = self.variationTableView.dequeueReusableCell(withIdentifier: "VariationCell", for: index) as! VariationTableViewCell
//            cell.variationName.text = self.itemReceived?.itemattributes[index.row].name
//            cell.variationName.text = self.itemReceived?.itemattributes[index.row].name
//            cell.price.text = "\(self.itemReceived?.itemattributes[index.row].price ?? 0)" + " KWD "
//            if self.itemReceived?.itemattributes[index.row].selected ?? false {
//                cell.check.setImage(UIImage(named: "select"), for: .normal)
//            }else{
//                cell.check.setImage(UIImage(named: "unselect"), for: .normal)
//            }
//
//            return cell
//
//        }.didSelectRowAt { (index) in
//            for i in 0...(self.itemReceived!.itemattributes.count-1){
//                self.itemReceived!.itemattributes[i].selected = false
//            }
//            self.itemReceived!.itemattributes[index.row].selected = true
//            self.selectedVariationIndex = self.itemReceived!.itemattributes[index.row].id
//            self.selectedVariationPrice = self.itemReceived!.itemattributes[index.row].price
//            self.variationTableView.reloadData()
//        }.heightForRowAt { (_) -> CGFloat in
//            return 30
//        }
//
//    }

}
