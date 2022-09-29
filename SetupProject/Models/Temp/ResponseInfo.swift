//
//  ResponseInfo.swift
//  Sunil Zalavadiya
//
//  Created by Sunil Zalavadiya on 23/07/20.
//  Copyright © 2020 Sunil Zalavadiya. All rights reserved.
//

import Foundation

enum ResponseStatus: String {
    case success    =   "200"
    case invalidLogin   =   "310"
    case emailalreadyregister   = "401"
    case tokenExpired   = "510"
}

class ResponseInfo {
    var status: String = ""
    var result: Any?
    var message: String = ""
    var tbUserProfile: Any?
    var allocatedUserRoles: Any?
    
    init(json: [String: Any]) {
        status = valuForString(json["status"]) ?? "0"//json["status"] as? String ?? "0"
        result = json["result"]
        message = json["message"] as? String ?? ""
        tbUserProfile = json["tbUserProfile"]
        allocatedUserRoles = json["allocatedUserRoles"]
        
    }
    
    func valuForString(_ value: Any?) -> String?{
        if let value = value {
            let anyValue = "\(value)"
            return anyValue
        }
        return nil
    }
}
