//
//  Application.swift
//  TaskUp
//
//  Created by Kartum on 27/07/19.
//  Copyright © 2019 Kartum Infotech. All rights reserved.
//

import Foundation
import UIKit

/// Application
struct Application {
    
    /// Debug Log enable or not
    static let isDevelopmentMode = false
    static let isLiveMode = true
    static let debug: Bool = false
    
    /// App Color
    struct Color {
        
        static let txt_border_color = UIColor(named: "txt_border_color")!
    }
    
    /// App Fonts
    struct Font {
        static let POPPINS_SEMIBOLD = "Poppins-SemiBold"
        static let POPPINS_REGULAR = "Poppins-Regular"
        
    }
    struct Device {
        static let version = UIDevice.current.systemVersion
    }
    
}
extension Notification.Name {
    
}
