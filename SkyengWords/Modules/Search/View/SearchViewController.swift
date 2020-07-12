//
//  SearchViewController.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit
import SnapKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Appearance
    
    struct Appearance {
        let backgroundColor = UIColor.Common.View.viewBackground
        let searchBarHeight: CGFloat = 54.0
        let searchBarDisabledOpacity: CGFloat = 0.75
        let stateLabelBackgroundColor = UIColor.Common.View.viewBackground
        let stateLabelTextColor = UIColor.Common.Text.subtitleText
        let stateLabelFont = UIFont.bold(with: 28.0)
    }
    private let appearance = Appearance()
    
    // MARK: - Properties
    
    let presenter: SearchViewOutput
    
    /// Datasource models
    var models: [WordViewModel] = []
    
    // MARK: - UI properties
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "Type word here..."
        return searchBar
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.alwaysBounceVertical = false
        tableview.keyboardDismissMode = .interactive
        tableview.register(cellClass: MeaningTableViewCell.self)
        return tableview
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = appearance.stateLabelBackgroundColor
        label.textColor = appearance.stateLabelTextColor
        label.font = appearance.stateLabelFont
        return label
    }()
    
    private lazy var fetchingSpinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame = .init(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyaboard()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Search word"
        view.backgroundColor = appearance.backgroundColor
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(resultsTableView)
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(appearance.searchBarHeight)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupKeyaboard() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyaboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Handlers
    
    @objc func keyaboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25) {
            self.resultsTableView.contentInset.bottom = 0.0
        }
    }
    
    @objc func keyboardWillChangeFrame(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        UIView.animate(withDuration: 0.25) {
            self.resultsTableView.contentInset.bottom = frame.cgRectValue.height - self.view.safeAreaInsets.bottom
        }
    }
    
}

// MARK: - SearchViewInput interface implementation

extension SearchViewController: SearchViewInput {
    
    func reloadResults(models: [WordViewModel]) {
        resultsTableView.backgroundView = nil
        self.models = models
        self.resultsTableView.reloadData()
    }
    
    func insertResults(models: [WordViewModel]) {
        
        // Prevent empty results insertion
        guard !models.isEmpty else {
            return
        }
        
        self.models.append(contentsOf: models)
        self.resultsTableView.reloadData()
    }
    
    func setNoResultsState() {
        resultsTableView.backgroundView = stateLabel
        stateLabel.text = "No results found"
    }
    
    func setInitialState() {
        resultsTableView.backgroundView = stateLabel
        stateLabel.text = "Type word in search field and press Search button"
    }
    
    func setErrorState(text: String) {
        resultsTableView.backgroundView = stateLabel
        stateLabel.text = "An error occured while searching: \n\(text).\n\nTry search again"
    }
    
    func setLoadingEnabled(enabled: Bool) {
        enabled ? showLoader(with: "Searching...") : hideLoader()
    }
    
    func setFetchingLoader(enabled: Bool) {
        enabled ? fetchingSpinner.startAnimating() : fetchingSpinner.stopAnimating()
        resultsTableView.tableFooterView = enabled ? fetchingSpinner : nil
        resultsTableView.tableFooterView?.isHidden = !enabled
    }
    
    func setSearchBarEnabled(enabled: Bool) {
        searchBar.isUserInteractionEnabled = enabled
        searchBar.alpha = enabled ? 1.0 : appearance.searchBarDisabledOpacity
    }
    
    func completeEditing(clearSearchBar: Bool) {
        view.endEditing(true)
        guard clearSearchBar else {
            return
        }
        searchBar.text = nil
    }
}

// MARK: - UITableView delegate & datasource

extension SearchViewController: UITableViewDelegate & UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].meaningsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meaningViewModel = models[indexPath.section].meanings[indexPath.row]
        let meaningCell = tableView.dequeue(cellClass: MeaningTableViewCell.self, forIndexPath: indexPath)
        meaningCell.fill(with: meaningViewModel)
        return meaningCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        models[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meaningViewModel = models[indexPath.section].meanings[indexPath.row]
        presenter.didSelectMeaning(meaningViewModel: meaningViewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        // Checking that table view at the bottom
        guard
            section == models.count - 1,
            row == models[section].meaningsCount - 1
        else {
            return
        }
        
        // Should fetch more
        presenter.shouldFetchMore()
    }
}

// MARK: - UISearchBarDelegate implementation

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        presenter.searchBarShouldChange(text: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarSearch(text: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancel()
    }
    
}
