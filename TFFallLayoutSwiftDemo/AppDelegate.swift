//
//  AppDelegate.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        initRootViewController()
        return true
        
    }
    
    func initRootViewController() {
        let vc = ViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
    }
    
}

