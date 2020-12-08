//
//  SceneDelegate.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 7/21/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
        AppDelegate.standard.window = window
        
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
        //        let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
        //        let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        //        window!.rootViewController = protectedPage
        //        window!.makeKeyAndVisible()
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
       
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}
