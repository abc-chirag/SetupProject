//
//  APIClient.swift
//  PwrPup
//
//  Created by Kartum Infotech on 14/09/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    private var networkService = NetworkService()
    
    //This should call if you need response, error
    private func callAPI(url: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, parameterEncoding: ParameterEncoding = JSONEncoding.default, showHttpErrorAutomatic: Bool = false, checkForAuthorization: Bool = true, completion completionBlock: @escaping (Any?, Error?) -> Void) -> DataRequest {
        
        return networkService.callApi(url: url, method: method, parameters: parameters, headers: headers, parameterEncoding: parameterEncoding,
                                      success: { response, _ in
                                        DispatchQueue.main.async {
                                            if checkForAuthorization {
                                                self.checkForAuthorization(response: response)
                                            }
                                            completionBlock(response, nil)
                                        }
        },
                                      failure: { (error, status) -> Bool in
                                        DispatchQueue.main.async {
                                            completionBlock(nil, error)
                                        }
                                        return showHttpErrorAutomatic
        })
    }
    
    //This should call if you need response, error, status code
    private func callAPI(url: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, parameterEncoding: ParameterEncoding = JSONEncoding.default, showHttpErrorAutomatic: Bool = false, checkForAuthorization: Bool = true, completion completionBlock: @escaping (Any?, Error?, Int?) -> Void) -> DataRequest {
        
        return networkService.callApi(url: url, method: method, parameters: parameters, headers: headers, parameterEncoding: parameterEncoding,
                                      success: { response, statucCode in
                                        DispatchQueue.main.async {
                                            if checkForAuthorization {
                                                self.checkForAuthorization(response: response)
                                            }
                                            completionBlock(response, nil, statucCode)
                                        }
        },
                                      failure: { (error, statucCode) -> Bool in
                                        DispatchQueue.main.async {
                                            completionBlock(nil, error, statucCode)
                                        }
                                        return showHttpErrorAutomatic
        })
    }
    
    //This should call if you need response, header, error, status code
    private func callAPI(url: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, parameterEncoding: ParameterEncoding = JSONEncoding.default, showHttpErrorAutomatic: Bool = false, checkForAuthorization: Bool = true, completion completionBlock: @escaping (Any?, Any?, Error?, Int?) -> Void) -> DataRequest {
        
        return networkService.callApi(url: url, method: method, parameters: parameters, headers: headers, parameterEncoding: parameterEncoding,
                                      success: { response, responseHeader, statucCode in
                                        DispatchQueue.main.async {
                                            if checkForAuthorization {
                                                self.checkForAuthorization(response: response)
                                            }
                                            completionBlock(response, responseHeader, nil, statucCode)
                                        }
        },
                                      failure: { (error, statucCode) -> Bool in
                                        DispatchQueue.main.async {
                                            completionBlock(nil, nil, error, statucCode)
                                        }
                                        return showHttpErrorAutomatic
        })
    }
    
    //This should call for upload if you need response, error
    private func callUploadAPI(url: String, parameters: MultipartFormData, headers: HTTPHeaders? = nil, parameterEncoding: ParameterEncoding = JSONEncoding.default, showHttpErrorAutomatic: Bool = false, checkForAuthorization: Bool = false, completion completionBlock: @escaping (Any?, Error?) -> Void) -> UploadRequest {
        
        return networkService.callApiWithUpload(url: url, method: .post, headers: headers, multipartFormData: parameters, success: { response, _ in
            DispatchQueue.main.async {
                if checkForAuthorization {
                    self.checkForAuthorization(response: response)
                }
                completionBlock(response, nil)
            }
        }) { (error, status) -> Bool in
            DispatchQueue.main.async {
                completionBlock(nil, error)
            }
            return showHttpErrorAutomatic
        }
    }
    
    private func checkForAuthorization(response: Any?) {
        guard let responseObj = response as? [String: Any] else {
            return
        }
        let responseData = ResponseInfo(json: responseObj)
        if responseData.status == ResponseStatus.tokenExpired.rawValue {
//            Utility.appDelegate().logoutFromApplication()
        }
        
    }
    

    //    func updateDeviceToken(params: ParameterRequest, completion: @escaping (Any?, Error?, Int?) -> Void) -> DataRequest {
    //        let headers = HeaderParameterRequest()
    //        return callAPI(url: API.UPDATE_FCM_TOKEN, method: .post, parameters: params.params, headers: headers.params, completion: completion)
    //    }
    
    
    //MARK:- APIS
    func get_Users(params: ParameterRequest, completion: @escaping (Any?, Error?) -> Void) -> DataRequest {
        let headers = HeaderParameterRequest()
        return callAPI(url: API.getUser, method: .get, parameters: nil, headers: headers.params, checkForAuthorization: false, completion: completion)
    }
    
//    
//    func get_UserBy_MobileNumber(phoneNumber: String, completion: @escaping (Any?, Error?) -> Void) -> DataRequest {
//        let url = API.GetUserByMobileNumber + "/" + phoneNumber
//        let headers = HeaderParameterRequest()
//        return callAPI(url: url, method: .get, parameters: nil, headers: headers.params, checkForAuthorization: true, completion: completion)
//    }
//    
//    func chack_isKec_user(base64String: String, completion: @escaping (Any?, Error?) -> Void) -> DataRequest {
//        let url = API.CheckKecUser + "/" + base64String
//        let headers = HeaderParameterRequest()
//        return callAPI(url: url, method: .get, parameters: nil, headers: headers.params, checkForAuthorization: true, completion: completion)
//    }
//    
//    func getKecUser_Detail(params: ParameterRequest, completion: @escaping (Any?, Error?) -> Void) -> DataRequest {
//        let headers = HeaderParameterRequest()
//        return callAPI(url: API.GetKecUserDetail, method: .post, parameters: params.params, headers: headers.params, checkForAuthorization: false, completion: completion)
//    }
    
}
