//
//  Int64+Extension.swift
//  VolumeBoosterV2Internal
//
//  Created by Sunil Zalavadiya on 16/04/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

extension Int64 {
    var kilobytesFromBytes: Double {
        return Double(self) / 1_000
    }
    
    public var megabytesFromBytes: Double {
        return self.kilobytesFromBytes / 1_000
    }
    
    public var gigabytesFromBytes: Double {
        return self.megabytesFromBytes / 1_000
    }
}
