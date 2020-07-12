//
//  UICollectionView+Extension.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    /// Returns unique reuse identifier for cell's class
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}

extension UICollectionView {
    
    /// Registers cell over cell class
    /// - Parameter cellClass: Class of the cell
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    /// Dequeues cell from UITableView with specified cell class and index path
    /// - Parameters:
    ///   - cellClass: Class of the cell
    ///   - indexPath: Index path
    /// - Returns:
    func dequeue<T: UICollectionViewCell>(cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}
