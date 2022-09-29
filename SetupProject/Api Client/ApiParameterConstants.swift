//
//  ApiParameterConstants.swift
//  Courtpals
//
//  Created by Sunil Zalavadiya on 24/06/20.
//  Copyright © 2020 Neuron Mac. All rights reserved.
//

import Foundation

///
enum ApiParamName: String {
    case device_type        =  "device_type"
    case device_token       = "device_token"
    case device_id          =   "device_id"
    case certification_type =   "certification_type"
    case device             = "device"
    
    case firebase_token =   "firebase_token"
    
    //MARK:- COMMON
    case userMobileNo
    case userEmail
    case userPassword
    case userName
    case password
    case errorMessage
    
    case trackingID
    case userId
    case trackingOn
    case geolocation
    case geoFenceId
    case isUserInGeoFence
}

//Header parameters
enum ApiParamNameHeader: String {
    case device         =   "device"
    case apiToken       =   "apiToken"
    case Authorization  =  "Authorization"
    case AcceptLanguage = "Accept-Language"
}
