//
//  AppDelegate.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splash = SplashViewController(window: window)
        window?.rootViewController = splash
        window?.makeKeyAndVisible()

        return true
    }
}
