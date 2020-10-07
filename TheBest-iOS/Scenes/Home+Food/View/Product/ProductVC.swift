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
    @IBOutlet weak var variationTitle: UILabel!
    @IBOutlet weak var variationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var variationTableHeight: NSLayoutConstraint!
    @IBOutlet weak var variationTableView: UITableView!
    @IBOutlet weak var variationView: UIView!
    
    var itemReceived: RestaurantMenuItem?
    var productPresenter: ProductPresenter?
    var vendorName: String?
    var vendorImage: String?
    var selectedVariationIndex: Int?
    var selectedVariationPrice: Int?
    
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
        productDesc.text = itemReceived?.restaurantMenuDescription
        
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
        
        addToCartView.addTapGesture { (_) in
           
            if (self.itemReceived?.itemattributes.count)! > 0 && self.selectedVariationIndex == nil{
                
                self.showAlert(title: "", message: "Choose \(self.itemReceived?.attributeTitle ?? "") first")
                
            }else{
                
                var priceToAdd = 0.0
                
                if let _ = self.selectedVariationPrice{
                    priceToAdd = Double(self.selectedVariationPrice!)
                }else{
                    priceToAdd = Double(self.itemReceived!.price.replacingOccurrences(of: ",", with: ".")) ?? 0.0
                }
                
                self.productPresenter?.addToCart(vendorId: self.itemReceived!.restaurantID,
                vendorName: self.vendorName!,
                vendorImage: self.vendorImage!,
                deliveryFees: "0",
                arg: CartItemModel(id: self.itemReceived!.id,
                                   name: self.itemReceived!.name,
                                   image: self.itemReceived!.hasImage ?? "",
                                   price: priceToAdd,
                                   quantity: Int(self.quantityNumer.text!)!,
                                   variation: self.selectedVariationIndex ?? 0,
                                   notes: self.customerNote.text
                                   ))
                
            }
            
        }
        
        self.variationTitle.text = self.itemReceived?.attributeTitle
        loadVariationTableView()
        self.variationViewHeight.constant = CGFloat(((self.itemReceived?.itemattributes.count)! * 30) + 65)
        self.variationTableHeight.constant = CGFloat((self.itemReceived?.itemattributes.count)! * 30)
        
        if (self.itemReceived?.itemattributes.count)! == 0{
            variationView.isHidden = true
        }
        
    }

    func loadVariationTableView(){
        
        let nib = UINib(nibName: "VariationTableViewCell", bundle: nil)
        variationTableView.register(nib, forCellReuseIdentifier: "VariationCell")
        
        variationTableView.numberOfRows { (_) -> Int in
            return (self.itemReceived?.itemattributes.count)!
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = self.variationTableView.dequeueReusableCell(withIdentifier: "VariationCell", for: index) as! VariationTableViewCell
            cell.variationName.text = self.itemReceived?.itemattributes[index.row].name
            cell.variationName.text = self.itemReceived?.itemattributes[index.row].name
            cell.price.text = "\(self.itemReceived?.itemattributes[index.row].price ?? 0)" + " KWD "
            if self.itemReceived?.itemattributes[index.row].selected ?? false {
                cell.check.setImage(UIImage(named: "select"), for: .normal)
            }else{
                cell.check.setImage(UIImage(named: "unselect"), for: .normal)
            }
            
            return cell
            
        }.didSelectRowAt { (index) in
            for i in 0...(self.itemReceived!.itemattributes.count-1){
                self.itemReceived!.itemattributes[i].selected = false
            }
            self.itemReceived!.itemattributes[index.row].selected = true
            self.selectedVariationIndex = self.itemReceived!.itemattributes[index.row].id
            self.selectedVariationPrice = self.itemReceived!.itemattributes[index.row].price
            self.variationTableView.reloadData()
        }.heightForRowAt { (_) -> CGFloat in
            return 30
        }
        
    }

}
