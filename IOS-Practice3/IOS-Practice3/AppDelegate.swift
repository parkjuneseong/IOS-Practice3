//
//  AppDelegate.swift
//  IOS-Practice3
//
//  Created by June on 2022/11/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
