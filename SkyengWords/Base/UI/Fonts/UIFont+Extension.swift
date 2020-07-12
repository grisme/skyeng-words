//
//  UIFont+Extension.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

/// Incapsulates application's font styles
/// I.e. in future, just replace each font style with custom font and all fonts in application will change
extension UIFont {
    
    /// Returns common application regular font with specified size
    /// - Parameter size: Size
    /// - Returns: Font
    static func regular(with size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    /// Returns common application bold font with specified size
    /// - Parameter size: Size
    /// - Returns: Font
    static func bold(with size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    
    
}
