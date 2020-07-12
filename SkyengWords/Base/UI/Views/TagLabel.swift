//
//  TagLabel.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class TagLabel: UILabel {
    
    // MARK: - Properties
    
    var paddings: UIEdgeInsets = .zero
    
    var cornerRadius: CGFloat = 16.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: paddings))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += paddings.left + paddings.right
        size.height += paddings.top + paddings.bottom
        return size
    }
    
    private func setupUI() {
        backgroundColor = .white
        textColor = .black
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
}
