//
//  ParameterRequest.swift
//  Drivo
//
//  Created by Sunil Zalavadiya on 07/05/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation
import Alamofire

class ParameterRequest {
    // MARK: - Properties
    var params = Parameters()
    
    // MARK: - Init
    init() {
        if AppPrefsManager.shared.isUserLogin() {
//            addParameter(paramName: .user_id, value: AppPrefsManager.shared.getLoggedInUserInfo().id)
        }
    }
    
    // MARK: - Functions
    func addParameter(paramName: ApiParamName, value: Any?) {
        params[paramName.rawValue] = value
    }
    
    func addParameter(paramName: String, value: Any?) {
        params[paramName] = value
    }
}
