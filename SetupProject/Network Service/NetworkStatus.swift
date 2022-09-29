//
//  NetworkStatus.swift
//  Courtpals
//
//  Created by Sunil Zalavadiya on 07/07/20.
//  Copyright © 2020 Neuron Mac. All rights reserved.
//

import Foundation
import Alamofire

class NetworkStatus {
    static let shared = NetworkStatus()
    
    var isConnected: Bool = false
    
    private init() {
        //startNetworkReachabilityObserver()
    }
    
    let reachabilityManager = NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening { status in
            DLog("Network Status Changed: \(status)")
            switch status {
            case .notReachable:
                DLog("The network is not reachable")
                self.isConnected = false
            case .unknown :
                DLog("It is unknown whether the network is reachable")
                self.isConnected = true
            case .reachable(.ethernetOrWiFi):
                DLog("The network is reachable over the WiFi connection")
                self.isConnected = true
            case .reachable(.cellular):
                DLog("The network is reachable over the cellular connection")
                self.isConnected = true
            }
        }
    }
}
