//
//  UIPageViewController + Swipe.swift
//  VolumeBoosterDevS
//
//  Created by Kartum Infotech on 23/06/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {

    func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}
