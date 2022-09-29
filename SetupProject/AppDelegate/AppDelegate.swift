//
//  AppDelegate.swift
//  SetupProject
//
//  Created by Kartum Infotech on 23/08/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkStatus.shared.startNetworkReachabilityObserver()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        return true
    }
    
    
    
}

