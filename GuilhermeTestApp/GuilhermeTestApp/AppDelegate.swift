//
//  AppDelegate.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 13/12/21.
//

import UIKit

import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
                if accessToken != nil
                {
                    // Take user to a home page
                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homePage = mainStoryboard.instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
                    self.window?.rootViewController = homePage
                }
                
                return true
    }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

