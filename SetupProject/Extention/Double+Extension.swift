//
//  Double+Extension.swift
//  PushToTalk
//
//  Created by Sunil Zalavadiya on 08/07/20.
//  Copyright © 2020 Sunil Zalavadiya. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toHoursMinsSeconds() -> (hour: Int, mins: Int, seconds: Int) {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return (hours, minutes, seconds)
    }
}
