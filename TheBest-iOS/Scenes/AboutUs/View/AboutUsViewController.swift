//
//  AboutUsViewController.swift
//  New-Super-Bekala-iOS
//
//  Created by Super Bekala on 7/11/20.
//  Copyright © 2020 Super Bekala. All rights reserved.
//

import UIKit
import Closures
import CoreLocation

class AboutUsViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var subHeader: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    
    @IBOutlet var covers: [UIImageView]!
    @IBOutlet var downCovers: [UIImageView]!
    let locationManager = CLLocationManager()
    
    var guideContent = [Guide]()
    var currentIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipBtn.layer.cornerRadius = 10
        guideContent.append(Guide(image: UIImage(named: "food")!, header: "Retaurants & Cafe", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc"))
        guideContent.append(Guide(image: UIImage(named: "taxi_icon")!, header: "Taxi services", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptat"))
        guideContent.append(Guide(image: UIImage(named: "car_icon")!, header: "Car rent", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc"))
        guideContent.append(Guide(image: UIImage(named: "special_need_icon")!, header: "Special need car", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "))
        guideContent.append(Guide(image: UIImage(named: "super_market")!, header: "Markets & Associations", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc"))
        guideContent.append(Guide(image: UIImage(named: "monthly_account_icon")!, header: "Monthly Account", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptat"))
        guideContent.append(Guide(image: UIImage(named: "winch_icon")!, header: "Road rescue services", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exerc"))
        guideContent.append(Guide(image: UIImage(named: "truck_icon")!, header: "Furniture transporting", subHeader: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "))
        loadCollection()
        
        nextBtn.onTap {
            
            if self.currentIndex < 7{
                
                self.currentIndex += 1
                self.imagesCollection.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
                self.showCover(index: self.currentIndex)
                
            }else{
                self.goNext()
            }
            
        }
        
        previousBtn.onTap {
            
            if self.currentIndex < 8{
                
                self.currentIndex -= 1
                self.imagesCollection.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
                self.showCover(index: self.currentIndex)
                
            }else{
                self.goNext()
            }
            
        }
        
        skipBtn.onTap {
            Router.toLogin(sender: self)
        }
        requestLocationPermission()
    }
    
    func requestLocationPermission(){
        
        locationManager.requestAlwaysAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations", locValue.latitude + locValue.longitude)
        SharedData.userLat = locValue.latitude
        SharedData.userLng = locValue.longitude
    }
    
    func loadCollection(){
         
        imagesCollection.numberOfItemsInSection { _ in 
            return self.guideContent.count
        }.cellForItemAt { (index) -> UICollectionViewCell in
            
            let cell = self.imagesCollection.dequeueReusableCell(withReuseIdentifier: "AboutUsCell", for: index) as! AboutUsCollectionViewCell
            cell.image.image = self.guideContent[index.row].image
            
            return cell
            
        }.sizeForItemAt { (_) -> CGSize in
            return CGSize(width: self.imagesCollection.frame.width, height: self.imagesCollection.frame.height)
        }.willDisplay { (_, index) in
            
            self.currentIndex = index.row
            if index.row > 0{
                self.previousBtn.isHidden = false
            }else{
                self.previousBtn.isHidden = true
            }
            
            self.header.text = self.guideContent[index.row].header
            self.subHeader.text = self.guideContent[index.row].subHeader
            self.view.backgroundColor = UIColor(named: "\(index.row+1)")
            
        }
        self.imagesCollection.reloadData()
    }
    
    func showCover(index: Int){
        
        for cover in self.covers{
            
            UIView.animate(withDuration: 0.5) {
                cover.alpha = 0
            }
            
        }
        
        for down in self.downCovers{

            UIView.animate(withDuration: 0.5) {
                down.alpha = 0
            }

        }
        
        UIView.animate(withDuration: 0.5) {
            self.covers[index].alpha = 1
            self.downCovers[index].alpha = 1
        }
        
    }
    
    func goNext(){
        
    }
    
}
