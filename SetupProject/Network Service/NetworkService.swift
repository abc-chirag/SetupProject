//
//  NetworkService.swift
//  Courtpals
//
//  Created by Sunil Zalavadiya on 24/06/20.
//  Copyright © 2020 Neuron Mac. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    var noInternetAlertController: UIAlertController?
    var requestTimedOutAlertController: UIAlertController?
    
    public enum ResponseType {
        case data
        case string
        case json
    }
    
    public static let networkSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        return Session(configuration: configuration)
    }()
    
    func callApi(url: String,
                 method: Alamofire.HTTPMethod,
                 parameters: [String: Any]? = nil,
                 headers: HTTPHeaders? = nil,
                 parameterEncoding: ParameterEncoding = URLEncoding.default,
                 responseType: ResponseType = .json,
                 success successBlock: @escaping ((Any?, Int?) -> Void),
                 failure failureBlock: ((Error, Int?) -> Bool)?) -> DataRequest {
        DLog("apiURL = \(url)")
        DLog("parameters = \(parameters ?? [:])")
        DLog("headers = \(headers ?? [:])")
        
        let request =  NetworkService.networkSession.request(url, method: method, parameters: parameters, encoding: parameterEncoding, headers: headers, interceptor: nil, requestModifier: nil)
        if responseType == .data {
            request.responseData { (response) in
                self.handleDataResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .string {
            request.responseString { (response) in
                self.handleStringResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .json {
            request.responseString { (response) in
                switch response.result {
                case let .success(responseString):
                    DLog("json string = \(responseString)")
                case let .failure(error):
                    // Handle the error, a 404 for example.
                    DLog("json String Error: \(error)")
                }
            }
            request.responseJSON { (response) in
                self.handleJsonResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        }
        
        return request
    }
    
    func callApi(url: String,
                 method: Alamofire.HTTPMethod,
                 parameters: [String: Any]? = nil,
                 headers: HTTPHeaders? = nil,
                 parameterEncoding: ParameterEncoding = URLEncoding.default,
                 responseType: ResponseType = .json,
                 success successBlock: @escaping ((Any?, Any?, Int?) -> Void),
                 failure failureBlock: ((Error, Int?) -> Bool)?) -> DataRequest {
        DLog("apiURL = \(url)")
        DLog("parameters = \(parameters ?? [:])")
        DLog("headers = \(headers ?? [:])")
        
        let request =  NetworkService.networkSession.request(url, method: method, parameters: parameters, encoding: parameterEncoding, headers: headers, interceptor: nil, requestModifier: nil)
        if responseType == .data {
            request.responseData { (response) in
                self.handleDataResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .string {
            request.responseString { (response) in
                self.handleStringResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .json {
            request.responseJSON { (response) in
                self.handleJsonResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        }
        
        return request
    }
    
    func callApiWithUpload(url: String,
                           method: HTTPMethod,
                           headers: HTTPHeaders? = nil,
                           multipartFormData: MultipartFormData,
                           responseType: ResponseType = .json,
                           success successBlock: @escaping ((Any?, Int?) -> Void),
                           failure failureBlock: ((Error, Int?) -> Bool)?) -> UploadRequest {
        
        DLog("apiURL = \(url)")
        DLog("headers = \(headers ?? [:])")
        
        let uploadRequest = NetworkService.networkSession.upload(multipartFormData: multipartFormData, to: url, headers: headers, interceptor: nil, requestModifier: nil)
        
        if responseType == .data {
            uploadRequest.responseData { (response) in
                self.handleDataResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .string {
            uploadRequest.responseString { (response) in
                self.handleStringResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        } else if responseType == .json {
//            uploadRequest.responseString { (response) in
//                DLog("responseString = \(response)")
//            }
            uploadRequest.responseJSON { (response) in
                self.handleJsonResponse(response: response, successHandler: successBlock, failureHandler: failureBlock)
            }
        }
        
        return uploadRequest
    }
    
    class func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager(host: "www.apple.com")?.isReachable ?? false
    }
}

// MARK: - Response handling
extension NetworkService {
    private func handleDataResponse(response: AFDataResponse<Data>, successHandler: @escaping ((Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        handleDataResponse(response: response, successHandler: { (responseJson, responseHeader, httpStatusCode) in
            DispatchQueue.main.async {
                successHandler(responseJson, httpStatusCode)
            }
        }, failureHandler: failureHandler)
    }
    
    private func handleDataResponse(response: AFDataResponse<Data>, successHandler: @escaping ((Any?, Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        switch response.result {
        case let .success(responseData):
            DLog("Response Data: \(responseData)")
            DispatchQueue.main.async {
                successHandler(responseData, response.response?.allHeaderFields, response.response?.statusCode)
            }
        case let .failure(error):
            // Handle the error, a 404 for example.
            DLog("Response Data Error: \(error)")
            handleError(error: error, responseStatusCode: response.response?.statusCode, failureHandler: failureHandler)
        }
    }
    
    private func handleStringResponse(response: AFDataResponse<String>, successHandler: @escaping ((Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        handleStringResponse(response: response, successHandler: { (responseJson, responseHeader, httpStatusCode) in
            DispatchQueue.main.async {
                successHandler(responseJson, httpStatusCode)
            }
        }, failureHandler: failureHandler)
        
    }
    
    private func handleStringResponse(response: AFDataResponse<String>, successHandler: @escaping ((Any?, Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        switch response.result {
        case let .success(responseString):
            DLog("Response String: \(responseString)")
            DispatchQueue.main.async {
                successHandler(responseString, response.response?.allHeaderFields, response.response?.statusCode)
            }
        case let .failure(error):
            // Handle the error, a 404 for example.
            DLog("Response String Error: \(error)")
            handleError(error: error, responseStatusCode: response.response?.statusCode, failureHandler: failureHandler)
        }
    }
    
    private func handleJsonResponse(response: AFDataResponse<Any>, successHandler: @escaping ((Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        handleJsonResponse(response: response, successHandler: { (responseJson, responseHeader, httpStatusCode) in
            DispatchQueue.main.async {
                successHandler(responseJson, httpStatusCode)
            }
        }, failureHandler: failureHandler)
    }
    
    private func handleJsonResponse(response: AFDataResponse<Any>, successHandler: @escaping ((Any?, Any?, Int?) -> Void), failureHandler: ((Error, Int?) -> Bool)?) {
        DLog("Response API: \(String(describing: response.request?.url))")
        DLog("response.request: \(response.request?.allHTTPHeaderFields ?? [:])")
        DLog("Response Status Code: \(response.response?.statusCode ?? 0)")
        DLog("Response allHeaderFields: \(response.response?.allHeaderFields ?? [:])")
        
        // Handle response from server.
        switch response.result {
        case let .success(responseJson):
            DLog("Response Json: \(responseJson)")
            DispatchQueue.main.async {
                successHandler(responseJson, response.response?.allHeaderFields, response.response?.statusCode)
            }
        case let .failure(error):
            // Handle the error, a 404 for example.
            DLog("Response Json Error: \(error)")
            handleError(error: error, responseStatusCode: response.response?.statusCode, failureHandler: failureHandler)
        }
    }
}

// MARK: - Network/Response error handling
extension NetworkService {
    private func handleError(error: AFError, responseStatusCode: Int?, failureHandler: ((Error, Int?) -> Bool)?) {
        DispatchQueue.main.async {
            if let failureBlock = failureHandler, failureBlock(error as NSError, error.responseCode) {
                if let statusCode = responseStatusCode {
                    self.handleAlamofireHttpFailureError(statusCode: statusCode)
                } else if let statusCode = error.responseCode {
                    self.handleAlamofireHttpFailureError(statusCode: statusCode)
                }
            }
        }
    }
    
    func handleAlamofireHttpFailureError(statusCode: Int) {
        switch statusCode {
        case NSURLErrorNotConnectedToInternet, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            showNoInternetAlert()
        case NSURLErrorCannotParseResponse:
            showAlert(title: "Error", message: "An unexpected error occurred")
        case NSURLErrorUnknown:
            showAlert(title: "Error", message: "Ooops!! Something went wrong, please try after some time!")
        case NSURLErrorCancelled:
            break
        case NSURLErrorTimedOut:
            showRequestTimedOutAlert()
        case NSURLErrorNetworkConnectionLost:
            showAlert(title: "Error", message: "Network connection lost.")
        //showNoInternetAlert()
        case NSURLErrorSecureConnectionFailed,
             NSURLErrorServerCertificateUntrusted,
             NSURLErrorServerCertificateHasBadDate,
             NSURLErrorServerCertificateNotYetValid,
             NSURLErrorServerCertificateHasUnknownRoot,
             NSURLErrorClientCertificateRejected,
             NSURLErrorClientCertificateRequired:
            showAlert(title: "SSL Server Error", message: "The secure connection failed for an unknown reason.")
        default:
            break
            //showAlert(title: "Error", message: "An unexpected error occurred", okButtonTitle: "OK")
        }
    }
}

// MARK: - Alerts
extension NetworkService {
    func showNoInternetAlert() {
        guard noInternetAlertController == nil, let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        noInternetAlertController = UIAlertController(title: "Error", message: "Please check your connection and try again.", preferredStyle: .alert)
        noInternetAlertController?.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.noInternetAlertController = nil
        }))
        window.rootViewController?.present(noInternetAlertController!, animated: true, completion: nil)
    }
    
    func showRequestTimedOutAlert() {
        guard requestTimedOutAlertController == nil, let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        requestTimedOutAlertController = UIAlertController(title: "Error", message: "Request timed out.", preferredStyle: .alert)
        requestTimedOutAlertController?.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.requestTimedOutAlertController = nil
        }))
        window.rootViewController?.present(requestTimedOutAlertController!, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        window.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension Error {
    var messageForNetworking: String {
        if let urlError = self.asAFError?.underlyingError as? URLError {
            return urlError.localizedDescription
        } else {
            return self.localizedDescription
        }
    }
}
