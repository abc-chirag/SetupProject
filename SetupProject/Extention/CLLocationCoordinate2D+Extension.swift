//
//  CLLocationCoordinate2D+Extension.swift
//  Qataronline
//
//  Created by Sunil Zalavadiya on 17/12/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    var latitudeString: String {
        get {
            return "\(self.latitude)"
        }
    }
    var longitudeString: String {
        get {
            return "\(self.longitude)"
        }
    }
}
