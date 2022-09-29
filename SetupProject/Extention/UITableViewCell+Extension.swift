//
//  UITableViewCell+Extension.swift
//  Common
//
//  Created by Sunil Zalavadiya on 29/03/19.
//  Copyright © 2019 Sunil Zalavadiya. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    var cellActionButtonLabel: UILabel? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }.first
    }
}


extension UITableView {
    func layoutTableHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        headerView.addConstraints(temporaryWidthConstraints)
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableHeaderView = headerView
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
