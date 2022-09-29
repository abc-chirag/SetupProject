//
//  API.swift
//  PwrPup
//
//  Created by Kartum Infotech on 14/09/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation

struct API {
    static var BASE_URL                   = "https://beta2.moontechnolabs.com"
    static var BASE_API_URL               =  BASE_URL + "/app_practical_api/public/api"
    
    
    static let getUser = BASE_API_URL + "/user"
    
//    static var LOGIN                      =  BASE_API_URL + "login"
//    static var SIGNUP                     =  BASE_API_URL + "register_user"
//    static var FORGOT_PASS                =  BASE_API_URL + "forgot_password"
//    static var FORGOT_USERNAME            =  BASE_API_URL + "forgot_username"
}
