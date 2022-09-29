//
//  AppPrefsManager.swift
//  TwoDoors
//
//  Created by Hoai on 02/05/18.
//  Copyright © 2018 Hoai. All rights reserved.
//

import UIKit
import CoreLocation


class AppPrefsManager: NSObject {
    
    static let shared = AppPrefsManager()
    
    private let LANGUAGE_CODE           = "LANGUAGE_CODE"
    private let SEARCH_CONTACT          = "SEARCH_CONTACT"
    private let IS_FIRST_TIME_APP_RUN   = "IS_FIRST_TIME_APP_RUN"
    private let DEVICE_ID               = "DEVICE_ID"
    private let DEVICE_AUTH             = "DEVICE_AUTH"
    private let DEVICE_TOKEN            = "DEVICE_TOKEN"
    private let USER_ID                 = "USER_ID"
    private let USER_DATA               = "USER_DATA"
    private let USER_LOGIN              = "USER_LOGIN"
    private let USER_TOKEN              = "USER_TOKEN"
    private let LOGGED_IN_USER          = "LOGGED_IN_USER"
    private let FCM_TOKEN               = "FCM_TOKEN"
    private let MAX_SPEAKING_TIME       = "MAX_SPEAKING_TIME"
    private let IS_SILENT_ENABLE        = "IS_SILENT_ENABLE"
    private let LETLONG                 = "LETLONG"
    
    
    //    func setDataToPreference(data: Any, forKey key: String) {
    //        let archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
    //        UserDefaults.standard.set(archivedData, forKey: key)
    //        UserDefaults.standard.synchronize()
    //    }
    //
    //    func getDataFromPreference(key: String) -> Any? {
    //        let archivedData = UserDefaults.standard.object(forKey: key)
    //
    //        if(archivedData != nil) {
    //            return NSKeyedUnarchiver.unarchiveObject(with: archivedData! as! Data) as AnyObject?
    //        }
    //        return nil
    //    }
    
    func setDataToPreference(data: Any, forKey key: String) {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            UserDefaults.standard.set(archivedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            DLog("setDataToPreference error = \(error)")
        }
    }
    func getDataFromPreference(key: String) -> Any? {
        let archivedData = UserDefaults.standard.object(forKey: key)
        if(archivedData != nil) {
            do {
                let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData! as! Data)
                return value
            } catch {
                DLog("getDataFromPreference error = \(error)")
            }
        }
        return nil
    }
    
    func setSelectedContact(data: Any, forKey key: String) {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(archivedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getSelectedContact(key: String) -> Any?  {
        let archivedData = UserDefaults.standard.object(forKey: key)
        
        if(archivedData != nil) {
            return NSKeyedUnarchiver.unarchiveObject(with: archivedData! as! Data) as AnyObject?
        }
        return nil
    }
    
    func removeDataFromPreference(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func isKeyExistInPreference(key: String) -> Bool {
        if(UserDefaults.standard.object(forKey: key) == nil) {
            return false
        }
        return true
    }
    
    private func setData<T: Codable>(data: T, forKey key: String) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            UserDefaults.standard.set(jsonData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch let error {
            print(error)
        }
    }
    
    private func getData<T: Codable>(objectType: T.Type, forKey key: String) -> T? {
        guard let result = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(objectType, from: result)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    // MARK: - Language Name
    //    func saveLanguageCode(languageCode: String) {
    //        setDataToPreference(data: languageCode as AnyObject, forKey: LANGUAGE_CODE)
    //    }
    //    func getLanguageCode() -> String {
    //        return getDataFromPreference(key: LANGUAGE_CODE) as? String ?? LanguageCode.german.rawValue//Locale.current.languageCode!
    //    }
    
    // MARK: - Is Login
    func setIsUserLogin(isUserLogin: Bool) {
        setDataToPreference(data: isUserLogin, forKey: USER_LOGIN)
    }
    
    func isUserLogin() -> Bool {
        let isUserLogin = getDataFromPreference(key: USER_LOGIN)
        return isUserLogin == nil ? false: (isUserLogin as! Bool)
    }
    
    func removeUserLogin() {
        removeDataFromPreference(key: USER_LOGIN)
    }
    
    //MARK: - Logged in user info
    func saveLoggedInUserInfo(userInfo: [String: Any]) {
        setDataToPreference(data: userInfo, forKey: LOGGED_IN_USER)
    }
    
    func getLoggedInUserInfo() -> UserInfo {
        let userDict = getDataFromPreference(key: LOGGED_IN_USER) as? [String: Any] ?? [:]
        return UserInfo(json: userDict)
    }
    
    func removeLoggedInUserInfo() {
        removeDataFromPreference(key: LOGGED_IN_USER)
        removeDataFromPreference(key: LETLONG)
    }
    
    func setUserLetLong(latlong: String) {
        setDataToPreference(data: latlong, forKey: LETLONG)
    }
    
    func getUserLetLong() -> String {
        return getDataFromPreference(key: LETLONG) as? String ?? ""
    }
    
}
