//
//  TextSoundableView.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

protocol TextSoundableViewAppearance {
    var insets: UIEdgeInsets { get }
    var textFont: UIFont { get }
    var textColor: UIColor { get }
}

final class TextSoundableView: UIView {
    
    // MARK: - Appearance
    
    struct DefaultAppearance: TextSoundableViewAppearance {
        let insets: UIEdgeInsets = .zero
        let textFont: UIFont = UIFont.regular(with: 18.0)
        let textColor: UIColor = UIColor.Common.Text.titleText
    }
    let appearance: TextSoundableViewAppearance
        
    // MARK: - UI properties
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = appearance.textFont
        label.textColor = appearance.textColor
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(appearance: TextSoundableViewAppearance = DefaultAppearance()) {
        self.appearance = appearance
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        self.appearance = DefaultAppearance()
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.appearance = DefaultAppearance()
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(textLabel)
    }
    
    private func makeConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(appearance.insets.top)
            make.leading.equalToSuperview().offset(appearance.insets.left)
            make.trailing.equalToSuperview().inset(appearance.insets.right)
            make.bottom.equalToSuperview().inset(appearance.insets.bottom)
        }
    }
    
    // MARK: - Public methods
    
    func fill(with textSoundable: TextSoundable) {
        textLabel.text = textSoundable.text
        // TODO: play sound button
    }
    
}


