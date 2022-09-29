//
//  Utility.swift
//  TwoDoors
//
//  Created by Hoai on 01/05/18.
//  Copyright © 2018 Hoai. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import LocalAuthentication

class Utility {
    
    // MARK: - Variables
    static let shared = Utility()
    
    var enableLog = true
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var timeStampInterval: TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    var timeStampString: String {
        return "\(Date().timeIntervalSince1970)"
    }
    
    // MARK: - Functions
    class func isLogEnable() -> Bool {
        return self.shared.enableLog
    }
    
    class func enableLog() {
        self.shared.enableLog = true
    }
    
    class func disableLog() {
        self.shared.enableLog = false
    }
    
    class func appDelegate() -> AppDelegate {
        return self.shared.appDelegate
    }
    
    class func windowMain() -> UIWindow? {
        return self.appDelegate().window
    }
    
    class func rootViewControllerMain() -> UIViewController? {
        return self.windowMain()?.rootViewController
    }
    
    class func applicationMain() -> UIApplication {
        return UIApplication.shared
    }
    
    class func getMajorSystemVersion() -> Int {
        let systemVersionStr = UIDevice.current.systemVersion   //Returns 7.1.1
        let mainSystemVersion = Int((systemVersionStr.split(separator: "."))[0])
        
        return mainSystemVersion!
    }
    
    class func getAppUniqueId() -> String {
        let uniqueId: UUID = UIDevice.current.identifierForVendor! as UUID
        
        return uniqueId.uuidString
    }
    
    class func nonNilString(string: String?) -> String {
        guard let string = string else {
            return ""
        }
        if string.isKind(of: NSNull.self) || string == "null" || string == "<null>" || string == "(null)" {
            return ""
        }
        return string
    }
    
    class func isEmptyString(string: String?) -> Bool {
        return self.nonNilString(string: string).trimmed().isEmpty
    }
    
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
    
    class func showMessageAlert(title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String) {
        let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) -> Void in
            
            alertWindow.isHidden = true
            
        }))
        
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func showMessageAlert(inVc: UIViewController, title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) -> Void in
            
        }))
        
        inVc.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertForAppSettings(title: String, message: String, allowCancel: Bool = true, completion: @escaping (Bool) -> ()) {
        let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        
        let alertController: UIAlertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default, handler: { (action) -> Void in
            
            alertWindow.isHidden = true
            
            let settingURL = URL(string: UIApplication.openSettingsURLString)!
if(UIApplication.shared.canOpenURL(settingURL)) {
                UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
            }
            
            completion(false)
            
        }))
        
        if allowCancel {
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { (action) -> Void in
                
                alertWindow.isHidden = true
                completion(false)
                
            }))
        }
        
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    class func jsonStringFromDict(_ dict: [String: Any]) -> String? {
        var jsonString: String?
        
        // try to create JSON string
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print("Could not create JSON from dict.")
        }
        return jsonString
    }
    
    class func jsonStringFromObject(_ obj: Any) -> String? {
        var jsonString: String?
        
        // try to create JSON string
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: obj, options: [])
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print("Could not create JSON from dict.")
        }
        return jsonString
    }
    
    class func isPushNotificationEnabled(completion: @escaping ((Bool) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                completion(false)
            case .authorized, .provisional:
                completion(true)
            case .denied:
                completion(false)
            @unknown default:
                completion(true)
            }
        }
    }
    
    class func requestPushLocalNotificationAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if granted {
                        completionHandler(true)
                    } else {
                        DispatchQueue.main.async {
                            completionHandler(false)
                            self.showAlertForAppSettings(title: "Enable Notifications?", message: "To enable Notifications, you need to allow notifications for this application from settings.", completion: completionHandler)
                        }
                    }
                }
            case .authorized, .provisional:
                completionHandler(true)
            case .denied:
                DispatchQueue.main.async {
                    completionHandler(false)
                    self.showAlertForAppSettings(title: "Enable Notifications?", message: "To enable Notifications, you need to allow notifications for this application from settings.", completion: completionHandler)
                }
            default:
                break // Do nothing
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}


// MARK: - QueueType
public enum QueueType {
    case Main
    case Background
    case LowPriority
    case HighPriority
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return DispatchQueue.main
        case .Background:
            return DispatchQueue(label: "com.app.queue",
                                 qos: .background,
                                 target: nil)
        case .LowPriority:
            return DispatchQueue.global(qos: .userInitiated)
        case .HighPriority:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
}

func performOn(_ queueType: QueueType, closure: @escaping () -> Void) {
    queueType.queue.async(execute: closure)
}
