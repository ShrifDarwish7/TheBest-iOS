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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

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
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let navController = self.window?.rootViewController as! UINavigationController
//        if !(navController.visibleViewController?.isKind(of: TaxiOrderVC.self))!{
//            completionHandler([.alert, .sound, .badge])
//            print("aaaaaaaaa")
//        }else{
//
//            completionHandler(UNNotificationPresentationOptions(rawValue: 0))
//
//        }
        completionHandler([.alert, .sound, .badge])
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
        if let _ = userInfo["driver_id"] {
            let navController = self.window?.rootViewController as! UINavigationController
            if !(navController.visibleViewController?.isKind(of: TaxiOrderVC.self))!{
                let storyboard = UIStoryboard(name: "Taxi", bundle: nil)
                let taxiVC = storyboard.instantiateViewController(withIdentifier: "TaxiOrderVC") as! TaxiOrderVC
                taxiVC.receivedDriverId = (userInfo["driver_id"] as! String)
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
