//
//  UITableViewCell+Ext.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import UIKit

///
/// Protocol to provide identifier for view that can be reused such as
/// in `UITableView` and `UICollectionView`.
///
public protocol ReuseIdentifiable {
    /// Returns identifier for identifying view for reuse.
    /// For `UITableViewCell`, there is already a property,
    /// `reuseIdentifier`, so naming as such to address that to
    /// avoid shadowing existing property.
    static var reusingIdentifier: String { get }
}

extension ReuseIdentifiable {
    public static var reusingIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifiable {
}
