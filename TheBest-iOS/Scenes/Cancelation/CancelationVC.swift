//
//  CancelationVC.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 08/01/2021.
//  Copyright © 2021 Sherif Darwish. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseDatabase

class CancelationVC: UIViewController {

    
    @IBOutlet weak var reaonsTableView: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var reasons = [CancelReason]()
    var selectedReason: String?
    var tripID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(receivedTripId(sender:)), name: NSNotification.Name("ReceivedTripId"), object: nil)
        
        reasons.append(CancelReason(reason: "Wrong destination", selected: false))
        reasons.append(CancelReason(reason: "A test journey", selected: false))
        reasons.append(CancelReason(reason: "The driver is so far", selected: false))
        reasons.append(CancelReason(reason: "The driver is not suitable ", selected: false))
        reasons.append(CancelReason(reason: "The driver was late so much", selected: false))
        reasons.append(CancelReason(reason: "Other reason", selected: false))
        
        loadTableView()
        
    }
    
    @IBAction func dismissAction(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(sender: UIButton){
        switch UserDefaults.init().integer(forKey: "ride_type") {
        case 1:
            SVProgressHUD.show()
            TripsServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("taxi cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
        case 4:
            SVProgressHUD.show()
            SpecialCarsServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("sp need cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
        case 16:
            SVProgressHUD.show()
            FurnitureServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("Furniture cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
            
        case 21:
            SVProgressHUD.show()
            CarRentServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("Car rent cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
        case 15:
            SVProgressHUD.show()
            RoadServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("RS cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
        case 17:
            SVProgressHUD.show()
            SubscriptionServices.cancelRide { (done) in
                SVProgressHUD.dismiss()
                if done{
                    print("Subscript cancel")
                    self.showAlert(title: "", message: "Ride Had Been Cancel")
                }
            }
        default:
            break
        }
        
        if let _ = SharedData.receivedTripID{
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let dicValue = [
                "is_user": true,
                "reason": self.selectedReason ?? ""
            ] as [String : Any]
            ref.child("Orders").child("\(SharedData.receivedTripID!)").setValue(dicValue)
        }
    }

//
//    @objc func receivedTripId(sender: NSNotification){
//
//
//
//        if let id = sender.userInfo!["ReceivedTripId"]{
//            showAlert(title: "", message: "Ride cancel from firebase \(id)")
//
//
//        }
//    }
    
}

struct CancelReason {
    var reason: String
    var selected: Bool
}

extension CancelationVC: UITableViewDelegate, UITableViewDataSource{
    func loadTableView(){
        let nib = UINib(nibName: "RaasonTableViewCell", bundle: nil)
        self.reaonsTableView.register(nib, forCellReuseIdentifier: "RaasonTableViewCell")
        self.reaonsTableView.delegate = self
        self.reaonsTableView.dataSource = self
        self.reaonsTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaasonTableViewCell") as! RaasonTableViewCell
        cell.reason.text = reasons[indexPath.row].reason
        if reasons[indexPath.row].selected{
            cell.selectIcon.image = UIImage(named: "reason_select")
        }else{
            cell.selectIcon.image = UIImage(named: "reason_unselect")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...reasons.count-1{
            reasons[i].selected = false
        }
        reasons[indexPath.row].selected = true
        self.selectedReason = reasons[indexPath.row].reason
        self.reaonsTableView.reloadData()
        UIView.animate(withDuration: 0.2) {
            self.cancelBtn.isHidden = false
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
