//
//  TimeInterval+Extension.swift
//  PushToTalk
//
//  Created by Sunil Zalavadiya on 08/07/20.
//  Copyright © 2020 Sunil Zalavadiya. All rights reserved.
//

import Foundation

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
        var miliseconds = self.rounded(toPlaces: 1) * 10
        miliseconds = miliseconds.truncatingRemainder(dividingBy: 10)
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%.f", minutes, seconds, miliseconds)
    }
}
