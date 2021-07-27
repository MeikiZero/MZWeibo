//
//  AppDelegate.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        return true
    }


}

