//
//  MeaningDetailViewController.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit
import SnapKit

final class MeaningDetailViewController: BaseViewController {
    
    // MARK: - Appearance
    
    struct Appearance {
        let sideMargin: CGFloat = 16.0
        let verticalMargin: CGFloat = 8.0
        
        let backgroundColor = UIColor.Common.View.viewBackground
        
        let imagesHeight: CGFloat = 200.0
        let imageAspectRatio: CGFloat = 200.0 / 150.0
        
        let titleColor = UIColor.Common.Text.titleText
        let titleFont = UIFont.bold(with: 30.0)
        let subtitleFont = UIFont.bold(with: 24.0)
        let subtitleColor = UIColor.Common.Text.subtitleText
        
        let normalFont = UIFont.regular(with: 18.0)
        let normalColor = UIColor.Common.Text.titleText
        
        let captionFont = UIFont.bold(with: 24.0)
        let captionColor = UIColor.Common.Text.titleText
        
        let tagFont = UIFont.bold(with: 18.0)
        let tagColor = UIColor.Common.Text.titleText
    }
    let appearance = Appearance()
    
    // MARK: - Properties
    
    let presenter: MeaningDetailViewOutput
    
    /// Meaning view model
    var meaningViewModel: MeaningDetailViewModel?
    
    // MARK: - UI properties
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(onRefreshControlValueChanged), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.refreshControl = refreshControl
        return scrollView
    }()
    
    private lazy var imagesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(cellClass: ImageCollectionViewCell.self)
        collectionView.backgroundColor = appearance.backgroundColor
        return collectionView
    }()

    private lazy var tagLabel: TagLabel = {
        let label = TagLabel(frame: .zero)
        label.textColor = appearance.tagColor
        label.font = appearance.tagFont
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        buildLabel(with: nil, font: appearance.titleFont, color: appearance.titleColor)
    }()
    
    private lazy var translationLabel: UILabel = {
        buildLabel(with: nil, font: appearance.titleFont, color: appearance.subtitleColor)
    }()
    
    private lazy var examplesCaptionLabel: UILabel = {
        buildLabel(with: "Examples", font: appearance.captionFont, color: appearance.captionColor)
    }()
    
    private lazy var definitionCaptionLabel: UILabel = {
        buildLabel(with: "Definition", font: appearance.captionFont, color: appearance.captionColor)
    }()
    
    private lazy var examplesStackView: UIStackView = {
        let stackview = UIStackView(frame: .zero)
        stackview.axis = .vertical
        stackview.spacing = appearance.verticalMargin
        return stackview
    }()
    
    /// Builds text soundable view
    /// - Parameter textSoundable: TextSoundable structure
    /// - Returns: TextSoundableView instance
    private func buildTextSoundableView(with textSoundable: TextSoundable) -> TextSoundableView {
        let view = TextSoundableView(frame: .zero)
        view.fill(with: textSoundable)
        return view
    }
    
    /// Label builder function
    /// - Parameters:
    ///   - text: Optional text
    ///   - font: Label font
    ///   - color: Label text color
    /// - Returns: UILabel instance
    private func buildLabel(with text: String?, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = font
        label.textColor = color
        label.text = text
        label.numberOfLines = 0
        return label
    }
    
    // MARK: - Lifecycle
    
    init(presenter: MeaningDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Word meaning"
        view.backgroundColor = appearance.backgroundColor
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imagesCollectionView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(translationLabel)
        scrollView.addSubview(examplesStackView)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imagesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(imagesCollectionView.snp.width).dividedBy(appearance.imageAspectRatio)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imagesCollectionView.snp.bottom).offset(appearance.verticalMargin)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(appearance.sideMargin)
        }
        
        translationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(appearance.verticalMargin)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        examplesStackView.snp.makeConstraints { make in
            make.top.equalTo(translationLabel.snp.bottom).offset(appearance.verticalMargin)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imagesCollectionView.collectionViewLayout.invalidateLayout()
    }
        
    // MARK: - Handlers
    
    @objc private func onRefreshControlValueChanged(sender: UIRefreshControl) {
        presenter.shouldRefresh()
    }

}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource implementation

extension MeaningDetailViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meaningViewModel?.imagesCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeue(cellClass: ImageCollectionViewCell.self, forIndexPath: indexPath)
        imageCell.fill(with: meaningViewModel?.imageURL(for: indexPath.row))
        return imageCell
    }
    
}

extension MeaningDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - MeaningDetailViewInput interface implementation

extension MeaningDetailViewController: MeaningDetailViewInput {
    func setLoadingEnabled(enabled: Bool) {
        enabled ? showLoader(with: "Loading...") : hideLoader()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func showMeaning(meaningViewModel: MeaningDetailViewModel) {
        
        // Remove previously added arranged subviews
        self.examplesStackView.arrangedSubviews.forEach {
            self.examplesStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        // Filling UI
        self.meaningViewModel = meaningViewModel
        self.titleLabel.text = meaningViewModel.text
        self.translationLabel.text = meaningViewModel.translationText
        self.imagesCollectionView.reloadData()
        
        // Filling definition
        if !meaningViewModel.definition.text.isEmpty {
            self.examplesStackView.addArrangedSubview(definitionCaptionLabel)
            self.examplesStackView.addArrangedSubview(buildTextSoundableView(with: meaningViewModel.definition))
        }
        
        // Filling examples
        if !meaningViewModel.examples.isEmpty {
            self.examplesStackView.addArrangedSubview(examplesCaptionLabel)
        }
        meaningViewModel.examples.forEach {
            self.examplesStackView.addArrangedSubview(buildTextSoundableView(with: $0))
        }
    }
}
