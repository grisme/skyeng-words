//
//  UITableView+Extension.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

/// - Note: This solution taken from the
/// https://getswifty.dev/extending-uitableview-to-register-and-dequeue-cells-safely/

extension UITableViewCell {
    
    /// Returns unique reuse identifier for cell's class
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}

extension UITableView {
    
    /// Registers cell over cell class
    /// - Parameter cellClass: Class of the cell
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    /// Dequeues cell from UITableView with specified cell class and index path
    /// - Parameters:
    ///   - cellClass: Class of the cell
    ///   - indexPath: Index path
    /// - Returns:
    func dequeue<T: UITableViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}
