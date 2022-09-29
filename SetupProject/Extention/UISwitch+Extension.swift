//
//  UISwitch+Extension.swift
//  Drivo
//
//  Created by Sunil Zalavadiya on 03/05/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import UIKit

extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
