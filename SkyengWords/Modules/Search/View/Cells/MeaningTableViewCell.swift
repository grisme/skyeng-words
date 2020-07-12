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
        
        let tagColor = UIColor.Common.Text.titleText
        let tagFont = UIFont.bold(with: 12.0)
        let tagPaddings: UIEdgeInsets = .init(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)
    }
    let appearance = Appearance()
    
    // MARK: - UI properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = appearance.titleFont
        label.textColor = appearance.titleColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var transcriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = appearance.transcriptionFont
        label.textColor = appearance.transcriptionColor
        return label
    }()
    
    private lazy var tagLabel: TagLabel = {
        let label = TagLabel(frame: .zero)
        label.paddings = appearance.tagPaddings
        label.font = appearance.tagFont
        label.textColor = appearance.tagColor
        label.cornerRadius = 4.0
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
        contentView.addSubview(tagLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(appearance.upsideMargin)
            make.leading.equalToSuperview().inset(appearance.sideMargin)
            make.trailing.equalTo(tagLabel.snp.leading)
        }
        
        transcriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(appearance.sideMargin)
            make.bottom.equalToSuperview().inset(appearance.upsideMargin)
        }
        
        tagLabel.snp.contentHuggingHorizontalPriority = 1000.0
        tagLabel.snp.contentCompressionResistanceHorizontalPriority = 1000.0
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(appearance.sideMargin)
        }
    }
    
    // MARK: - Public methods
    
    func fill(with meaningViewModel: MeaningViewModel) {
        let translation = meaningViewModel.translation
        let transcription = meaningViewModel.transcription
        titleLabel.text = translation
        transcriptionLabel.text = transcription
        tagLabel.backgroundColor = meaningViewModel.partOfSpeechColor
        tagLabel.text = meaningViewModel.partOfSpeechText
    }

}
