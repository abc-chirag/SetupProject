//
//  Array+Extension.swift
//  VolumeBoosterDevS
//
//  Created by Kartum Infotech on 08/07/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

//removing Duplicates from info
extension Sequence where Iterator.Element: Hashable {
    func removingDuplicates() -> [Iterator.Element] {
        var seen = Set<Iterator.Element>()
        return filter { seen.update(with: $0) == nil }
    }
}
