//
//  MeaningTableViewCell.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class MeaningTableViewCell: UITableViewCell {
    
    // MARK: - Appearance
    struct Appearance {
        let upsideMargin: CGFloat = 10.0
        let sideMargin: CGFloat = 16.0
        let verticalMargin: CGFloat = 8.0
        let titleColor = UIColor.Common.Text.titleText
        let titleFont = UIFont.bold(with: 18.0)
        let transcriptionColor = UIColor.Common.Text.subtitleText
        let transcriptionFont = UIFont.regular(with: 16.0)
    }
    let appearance = Appearance()
    
    // MARK: - UI properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = appearance.titleFont
        label.textColor = appearance.titleColor
        return label
    }()
    
    private lazy var transcriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = appearance.transcriptionFont
        label.textColor = appearance.transcriptionColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(transcriptionLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(appearance.upsideMargin)
            make.leading.trailing.equalToSuperview().inset(appearance.sideMargin)
        }
        
        transcriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(appearance.sideMargin)
            make.bottom.equalToSuperview().inset(appearance.upsideMargin)
        }
    }
    
    // MARK: - Public methods
    
    func fill(with meaningViewModel: MeaningViewModel) {
        let translation = meaningViewModel.translation
        let transcription = meaningViewModel.transcription.isEmpty ? "Transcription unavailable" : meaningViewModel.transcription
        titleLabel.text = translation
        transcriptionLabel.text = transcription
    }

}
