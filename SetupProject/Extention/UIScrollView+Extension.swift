//
//  UIScrollView+Extension.swift
//  Trichordal
//
//  Created by Sunil Zalavadiya on 13/02/19.
//  Copyright © 2019 Sunil Zalavadiya. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    public func isNearBottomEdge(edgeOffset: CGFloat = 20) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
