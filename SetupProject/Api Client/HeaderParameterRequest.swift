//
//  HeaderParameterRequest.swift
//  Drivo
//
//  Created by Sunil Zalavadiya on 07/05/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation
import Alamofire

class HeaderParameterRequest {
    // MARK: - Properties
    var params = HTTPHeaders()
    
    // MARK: - Init
    init() {
        if AppPrefsManager.shared.isUserLogin() {
//            addParameter(paramName: .Authorization, value: "Bearer \(AppPrefsManager.shared.getToken())")
        }
//        addParameter(paramName: .AcceptLanguage, value: AppPrefsManager.shared.getLanguageCode())
    }
    
    // MARK: - Functions
    func addParameter(paramName: ApiParamNameHeader, value: Any?) {
        if let value = value as? String {
            params[paramName.rawValue] = value
        }
    }
}

