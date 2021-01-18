//
//  AppDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift
import SVProgressHUD
import GoogleMaps
import GooglePlaces
import FirebaseMessaging
import MOLH
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    static var player: AVAudioPlayer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        Auth.auth().canHandle(URL(string: "com.googleusercontent.apps.88616747039-42d5n786a8p2mijp1necs5v0u5fo0ag7")!)
        GMSServices.provideAPIKey("AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE")
        GMSPlacesClient.provideAPIKey("AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE")
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
       // SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setCornerRadius(10)
        SVProgressHUD.setMinimumSize(CGSize(width: 75, height: 75))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75))
        
        MOLH.shared.activate(true)
        
        if #available(iOS 13.0, *){
            
        }else{
            if AuthServices.instance.isLogged {

                let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                if AuthServices.instance.isLogged{
                    let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
//                    let nav = mainStoryboard.instantiateViewController(withIdentifier: "RootNav") as! UINavigationController
//                    rootViewController.rootViewController = nav
                    
                    let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                    //nav.pushViewController(homeVC, animated: true)
                    rootViewController.rootViewController = homeVC
                    window!.makeKeyAndVisible()
                }

            }
        }
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
                
        return true
    }
    
    static func playSound() {
        guard let url = Bundle.main.url(forResource: "loud_alert", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player!.numberOfLoops =  -1
            player!.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TheBest_iOS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
////        let navController = self.window?.rootViewController as! UINavigationController
////        if !(navController.visibleViewController?.isKind(of: TaxiOrderVC.self))!{
////            completionHandler([.alert, .sound, .badge])
////            print("aaaaaaaaa")
////        }else{
////
////            completionHandler(UNNotificationPresentationOptions(rawValue: 0))
////
////        }
//        completionHandler([.alert, .sound, .badge])
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIdentifier = response.actionIdentifier
        
        switch actionIdentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
            // Do something
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // App was opened from notification
            // Do something
            
            let userInfo = response.notification.request.content.userInfo
            let navController = self.window?.rootViewController as! UINavigationController
            
            print("userInfo",userInfo)
            
            if let _ = userInfo["driver_id"] {
                
                if let tripID = userInfo["trip_id"]{
                    SharedData.receivedTripID = Int(tripID as! String)
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    ref.child("Orders").child(tripID as! String).observe(.value) { (snapshot) in
                      //  NotificationCenter.default.post(name: NSNotification.Name("ReceivedTripId"), object: nil, userInfo: ["ReceivedTripId": tripID])
                        if let dic = snapshot.value as? [String : AnyObject]{
                            if dic["is_user"]?.boolValue == false{
                                AppDelegate.playSound()
                                let alert = UIAlertController(title: "Trip has been canceled", message: "Your driver has canceled your trip, due to " + ((dic["reason"]!) as! String), preferredStyle: .alert)
                                let action = UIAlertAction(title: "Done", style: .cancel) { (_) in
                                    AppDelegate.player?.stop()
                                }
                                alert.addAction(action)
                                navController.visibleViewController?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                }
                
                switch UserDefaults.init().integer(forKey: "ride_type") {
                case 1:
                    
                    if !(navController.visibleViewController?.isKind(of: TaxiOrderVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let taxiVC = storyboard.instantiateViewController(withIdentifier: "TaxiOrderVC") as! TaxiOrderVC
                        navController.pushViewController(taxiVC, animated: true)
                    }
                    
                case 4:
                    
                    if !(navController.visibleViewController?.isKind(of: SpecialNeedCarVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "SpecialNeedCarVC") as! SpecialNeedCarVC
                        navController.pushViewController(vc, animated: true)
                    }
                    
                case 16:
                    
                    if !(navController.visibleViewController?.isKind(of: FurnitureVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "FurnitureVC") as! FurnitureVC
                        navController.pushViewController(vc, animated: true)
                    }
                    
                case 21:
                    
                    if !(navController.visibleViewController?.isKind(of: CarRentVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "CarRentVC") as! CarRentVC
                        navController.pushViewController(vc, animated: true)
                    }
                    
                case 15:
                    
                    if !(navController.visibleViewController?.isKind(of: RoadServicesVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "RoadServicesVC") as! RoadServicesVC
                        navController.pushViewController(vc, animated: true)
                    }
                    
                case 17:
                    
                    if !(navController.visibleViewController?.isKind(of: SubscriptVC.self))!{
                        let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "SubscriptVC") as! SubscriptVC
                        navController.pushViewController(vc, animated: true)
                    }
                    
                default:
                    break
                }
                
                SVProgressHUD.show()
                TripsServices.getDriverBy(id: Int(userInfo["driver_id"] as! String)!) { (response) in
                    SVProgressHUD.dismiss()
                    if let _ = response?.driver{
                        NotificationCenter.default.post(name: NSNotification.Name("ReceivedConfirmationFromDriver"), object: nil, userInfo: ["driver": response!.driver as Driver])
                    }
                }
                

            }
            
            if response.notification.request.content.body == "Your Trip is over!",
               let tripId = userInfo["trip_id"] as? String
               {
                SVProgressHUD.show()
                TripsServices.getTripBy(tripId) { (response) in
                    SVProgressHUD.dismiss()
                    if let _ = response{
                        Router.toTripInfo(navController.topViewController!, trip: response!.trip)
                    }
                }
            }
            
            completionHandler()
        default:
            completionHandler()
        }
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let _ = userInfo["driver_id"] {
            SharedData.receivedDriverId = (userInfo["driver_id"] as! String)
            let navController = self.window?.rootViewController as! UINavigationController
            if !(navController.visibleViewController?.isKind(of: TaxiOrderVC.self))!{
                let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                let taxiVC = storyboard.instantiateViewController(withIdentifier: "TaxiOrderVC") as! TaxiOrderVC
                navController.pushViewController(taxiVC, animated: true)
            }
            NotificationCenter.default.post(name: NSNotification.Name("ReceivedConfirmationFromDriver"), object: nil, userInfo: userInfo)
        }
        
    }
}

extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcmTokenHere",fcmToken)
        UserDefaults.init().set(fcmToken, forKey: "FCM_Token")
    }
}

extension String{
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}

extension AppDelegate:  MOLHResetable {
    @available(iOS 13.0, *)
    func swichRoot(){
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            if AuthServices.instance.isLogged{
                let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                sd.window!.rootViewController = protectedPage
                self.window!.makeKeyAndVisible()
            }
        }
    }
    func reset() {
        if #available(iOS 13.0, *) {
            self.swichRoot()
        }else{
            let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            if AuthServices.instance.isLogged{
                let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                rootViewController.rootViewController = protectedPage
                self.window!.makeKeyAndVisible()
            }
        }
    }
    static func changeLangTo(_ lang: String){
        
        MOLHLanguage.setDefaultLanguage("en")
        MOLH.setLanguageTo(lang)
        
        if #available(iOS 13.0, *) {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate!.swichRoot()
        } else {
            MOLH.reset()
        }
    }
}
