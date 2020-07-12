//
//  ImageCollectionViewCell.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit
import Kingfisher

final class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Appearance
    
    struct Appearance {
        let imageBackgroundColor = UIColor.Common.View.cellBackground
        let imageCornerRadius: CGFloat = 16.0
        let sideMargin: CGFloat = 16.0
        let upsideMargin: CGFloat = 8.0
    }
    let appearance: Appearance = .init()
    
    // MARK: - UI Properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.backgroundColor = appearance.imageBackgroundColor
        imageView.layer.cornerRadius = appearance.imageCornerRadius
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(appearance.upsideMargin)
            make.leading.trailing.equalToSuperview().inset(appearance.sideMargin)
        }
    }
    
    // MARK: - Public methods
    
    func fill(with imageURL: URL?) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageURL)
    }
    
}
