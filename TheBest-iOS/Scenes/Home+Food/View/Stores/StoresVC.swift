//
//  StoresVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/24/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class StoresVC: UIViewController {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var upperIcon: UIView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var storeTableView: UITableView!
    @IBOutlet weak var pageIcon: UIImageView!
    @IBOutlet weak var emptyCategoryLabel: UILabel!
    @IBOutlet weak var cartItemsCount: UILabel!
    
    var pageIconReceived: String?
    var idReceived: Int?
    var storesViewPresenter: StoresViewPresenter?
    var filters: SubCategories?
    var places: Places?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CartServices.getCartItems { (items) in
            if let items = items{
                if items.count > 0{
                    self.cartItemsCount.isHidden = false
                    self.cartItemsCount.text = "\(items.count)"
                }else{
                    self.cartItemsCount.isHidden = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storesViewPresenter = StoresViewPresenter(storesViewDelegate: self)
        cartItemsCount.layer.cornerRadius = cartItemsCount.frame.height/2
        upperIcon.layer.cornerRadius = upperIcon.frame.height/2
        pageIcon.sd_setImage(with: URL(string: pageIconReceived!))
        upperView.layer.cornerRadius = upperView.frame.height/2
        
        storesViewPresenter?.getCategoriesBy(id: idReceived!)
        
        backBtn.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        cartBtn.onTap {
            Router.toCart(sender: self)
        }
        
    }
    
    func loadFiltersCollectionView(){
        
        let nib = UINib(nibName: "FiltersCollectionViewCell", bundle: nil)
        self.filtersCollectionView.register(nib, forCellWithReuseIdentifier: "FiltersCell")
        
        self.filtersCollectionView.numberOfItemsInSection(handler: { (_) -> Int in
            return (self.filters?.items.count)!
        }).cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.filtersCollectionView.dequeueReusableCell(withReuseIdentifier: "FiltersCell", for: index) as! FiltersCollectionViewCell
            cell.imageView.sd_setImage(with: URL(string: (self.filters?.items[index.row].image)!)!)
            cell.name.text = self.filters?.items[index.row].name
            cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
            
            if self.filters?.items[index.row].selected ?? false{
                cell.name.textColor = UIColor.black
            }else{
                cell.name.textColor = UIColor(named: "FontGrayColor")
            }
            
            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            return CGSize(width: 180, height: self.filtersCollectionView.frame.height)
        }.minimumLineSpacingForSectionAt { (_) -> CGFloat in
            return 0
        }.minimumInteritemSpacingForSectionAt { (_) -> CGFloat in
            return 0
        }.didSelectItemAt { (index) in
            
            for i in 0...self.filters!.items.count-1{
                self.filters!.items[i].selected = false
            }
            
            self.filters?.items[index.row].selected = true
            self.filtersCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.filtersCollectionView.reloadData()
            
            self.storesViewPresenter?.getPlacesBy(categoryId: (self.filters?.items[index.row].id)!)
            
        }
        
      //  self.filtersCollectionView.reloadData()
        
    }
    
    func loadPlacesTable(){
        
        let nib = UINib(nibName: "PlacesTableViewCell", bundle: nil)
        self.storeTableView.register(nib, forCellReuseIdentifier: "PlaceCell")
        
        self.storeTableView.numberOfRows { (_) -> Int in
            return (self.places?.items.count)!
        }.cellForRow { (index) -> UITableViewCell in
            
            let cell = self.storeTableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: index) as! PlacesTableViewCell
            cell.placeImage.sd_setImage(with: URL(string: (self.places?.items[index.row].image)!))
            cell.deliveryTime.text = "1 Hour"
            cell.placeName.text = self.places?.items[index.row].name
            cell.placeImage.layer.cornerRadius = cell.placeImage.frame.height/2
            cell.container.layer.cornerRadius = 15 
            
            return cell
            
        }.heightForRowAt { (_) -> CGFloat in
            return 80
        }.didSelectRowAt { (index) in
            Router.toVendorProfile(id: (self.places?.items[index.row].id)!, sender: self)
        }
        
        self.storeTableView.reloadData()
        
    }

}
