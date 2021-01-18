//
//  MarketsVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/13/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation

class MarketsVC: UIViewController , UIGestureRecognizerDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageTitle: UIView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var cartItemsCount: UILabel!
    @IBOutlet weak var marketsTableView: UITableView!
    @IBOutlet weak var filterBtn: UIView!
    
    let locationManager = CLLocationManager()
    var marketsVCPresenter: MarketsVCPresenter?
    //var nearbyMarkets: NearByMarkets?
    var tableDataSource: [Item]?
    var catReceivedId: Int?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedFilteringResult(sender:)), name: NSNotification.Name(rawValue: "filter_result"), object: nil)

        marketsVCPresenter = MarketsVCPresenter(marketsViewDelegate: self)

        cartItemsCount.layer.cornerRadius = cartItemsCount.frame.height/2
        upperView.layer.cornerRadius = upperView.frame.height/2
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        backBtn.onTap {
            self.navigationController?.popViewController(animated: true)
        }
        
        cartBtn.onTap {
            Router.toCart(sender: self)
        }
        
        filterBtn.addTapGesture { (_) in
            switch self.type {
            case "markets":
                Router.toFilterMarkets(sender: self, type: "markets", cat: self.catReceivedId!)
            default:
                Router.toFilterMarkets(sender: self, type: "shera", cat: self.catReceivedId!)
            }
            
        }
        
        pageTitle.layer.cornerRadius = pageTitle.frame.height/2
        pageTitle.setupShadow()
        
        filterBtn.layer.cornerRadius = 15
        
        if type == "vegetable"{
            pageTitle.backgroundColor = UIColor(named: "vegColor")
            
        }else{
            pageTitle.backgroundColor = UIColor(named: "MarketsColor")
        }
        
    }
    
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
    
    @objc func receivedFilteringResult(sender: NSNotification){
        
        if let result = sender.userInfo!["markets"]{
            self.tableDataSource = (result as! [Item])
            self.marketsTableView.isHidden = false
            self.loadTable()
        }
        
    }

}

