//
//  MultipartParameterRequest.swift
//  Drivo
//
//  Created by Sunil Zalavadiya on 07/05/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation
import Alamofire

class MultipartParameterRequest {
    // MARK: - Properties
    var multipartFormData = MultipartFormData()
    var tempParamsRequest = ParameterRequest()
    
    // MARK: - Init
    init() {
        if AppPrefsManager.shared.isUserLogin() {
            //addParameter(paramName: .user_id, value: AppPrefsManager.shared.getLoggedInUserInfo().user_id)
        }
    }
    
    // MARK: - Functions
    func addParameter(paramName: ApiParamName, value: Any?) {
        if let value = value as? String {
            if let data = value.data(using: .utf8) {
                 tempParamsRequest.addParameter(paramName: paramName, value: value)
                multipartFormData.append(data, withName: paramName.rawValue)
            }
        } else if let value = value as? Data {
            tempParamsRequest.addParameter(paramName: paramName, value: value)
            multipartFormData.append(value, withName: paramName.rawValue)
        } else if let value = value, let data = dataFromJsonObject(jsonObject: value) {
            tempParamsRequest.addParameter(paramName: paramName, value: value)
            multipartFormData.append(data, withName: paramName.rawValue)
        }
    }
    
    func addParameter(paramName: String, value: Any?) {
        if let value = value as? String {
            if let data = value.data(using: .utf8) {
                 tempParamsRequest.addParameter(paramName: paramName, value: value)
                multipartFormData.append(data, withName: paramName)
            }
        } else if let value = value as? Data {
            tempParamsRequest.addParameter(paramName: paramName, value: value)
            multipartFormData.append(value, withName: paramName)
        } else if let value = value, let data = dataFromJsonObject(jsonObject: value) {
            tempParamsRequest.addParameter(paramName: paramName, value: value)
            multipartFormData.append(data, withName: paramName)
        }
    }
    
    func addFile(paramName: ApiParamName, fileData: Data, fileName: String, mimeType: String) {
        multipartFormData.append(fileData, withName: paramName.rawValue, fileName: fileName, mimeType: mimeType)
    }
    
    private func dataFromJsonObject(jsonObject: Any) -> Data? {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            return jsonData
        } catch let error as NSError {
            print("Json to Data Error - \(error.description)")
        }
        return nil
    }
    
}
