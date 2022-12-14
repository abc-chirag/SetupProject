//
//  Int+Extension.swift
//  Trichordal
//
//  Created by Kartum Infotech on 18/02/19.
//  Copyright © 2019 Kartum Infotech. All rights reserved.
//

import Foundation

/// Event Mode and Event Status
extension Int {
    public var eventMode: String {
        var temp = ""
        if self == 0 {
            temp = "Public"
        } else if self == 1 {
            temp = "Private"
        }
        return temp
    }

    public var eventStatus: String {
        var temp = ""
        if self == 0 {
            temp = "Inactive"
        } else if self == 1 {
            temp = "Active"
        } else if self == 2 {
            temp = "Rejected"
        }
        return temp
    }
    
    /// EZSE: Converts integer value to String.
    public var toString: String { return String(self) }
}
