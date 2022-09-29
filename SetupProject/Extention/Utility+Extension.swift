//
//  Utility+Extension.swift
//  OneTouch
//
//  Created by Kartum Infotech on 28/06/19.
//  Copyright © 2019 Kartum Infotech. All rights reserved.
//

import Foundation
import UIKit

extension Utility {
    /*func saveImage(url: URL, toCache: UIImage?) {
        guard let toCache = toCache else { return }
        
        let manager = SDWebImageManager.shared
        if let key = manager.cacheKey(for: url) {
            manager.imageCache.store(toCache, imageData: nil, forKey: key, cacheType: .all, completion: nil)
        }
    }
    
    static func imageFromMemory(for url: String) -> UIImage? {
        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded) {
            let manager = SDWebImageManager.shared
            if let key: String = manager.cacheKey(for: url) {
                if let imageCache = manager.imageCache as? SDImageCache {
                    return imageCache.imageFromDiskCache(forKey: key)
                }
            }
        }
        return nil
    }*/
    
    class func daysBetweenDates(endDate: Date) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: endDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return "Reminder in " + String(components.day ?? 0) + " days"
    }
    
    class func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    class func getFormatedMinSec(seconds : Int) -> String {
        let (_,min,sec) = secondsToHoursMinutesSeconds(seconds: seconds)
        
        return String(format: "%d:%02d", min, sec)
    }
    
    class func askPermissionForMicroPhone() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Need to access microphone service", message: "Turn on microphone services on your device.", preferredStyle: .alert)
            
            let openAction = UIAlertAction(title: "Settings", style: .default) { (action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    self.applicationMain().open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(openAction)
            
            self.rootViewControllerMain()?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func getJSONObject(str: String) -> [String : Any]? {
        
        let data = str.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                return jsonArray
            }
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

// MARK: - All UIApplication extensions
extension UIApplication {
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"), self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}

// MARK: - All NSDecimalNumber extensions
extension NSDecimalNumber {
    func toNegative() -> NSDecimalNumber {
        return self.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true));
    }
}

// MARK: - Structs
struct IOS_VERSION
{
    static var IS_IOS7 = Utility.getMajorSystemVersion() >= 7 && Utility.getMajorSystemVersion() < 8
    static var IS_IOS8 = Utility.getMajorSystemVersion() >= 8 && Utility.getMajorSystemVersion() < 9
    static var IS_IOS9 = Utility.getMajorSystemVersion() >= 9
}

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    //static let IS_TV = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.TV
    
    static let IS_IPHONE_4_OR_LESS =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 1125.0
    static let IS_IPHONE_LESS_THAN_6 =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH < 667.0
    static let IS_IPHONE_LESS_THAN_OR_EQUAL_6 =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH <= 667.0
}
