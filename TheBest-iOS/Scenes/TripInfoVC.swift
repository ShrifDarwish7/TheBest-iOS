//
//  TripInfoVC.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 24/12/2020.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class TripInfoVC: UIViewController {

    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var total: UILabel!
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        from.text = trip?.addressFrom
        to.text = trip?.addressTo
        username.text = AuthServices.instance.user.name
        phone.text = AuthServices.instance.user.phone
        start.text = trip?.createdAt
        end.text = trip?.updatedAt
        type.text = SharedData.getRideType((trip?.rideType)!).name
        total.text = "\(trip?.total ?? 0)" + " " + "KWD"
        
        let alert = UIAlertController(title: "Share", message: "Do you to share this application with your friends to gain points", preferredStyle: .alert)
        let shareAction = UIAlertAction(title: "Share", style: .default) { (_) in
            let shareText = [ "Download Our App from : http://onelink.to/" ]
            let activityViewController = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        let laterAction = UIAlertAction(title: "Later", style: .cancel, handler: nil)
        alert.addAction(shareAction)
        alert.addAction(laterAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        
        for vc in self.navigationController!.viewControllers{
            if vc.isKind(of: HomeVC.self){
                self.navigationController?.popToViewController(vc, animated: true)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func share(_ sender: Any) {
        let shareText = [ "Download Our App from : http://onelink.to/" ]
        let activityViewController = UIActivityViewController(activityItems: shareText, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
