//
//  SearchPresenter.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

final class SearchPresenter {
    
    // MARK: - Properties
    
    weak var view: SearchViewInput?
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    /// Current search results page
    var currentPage: Int = 0
    var currentSearchQuery: String = ""
    /// Is fetching now flag
    var fetchingNow: Bool = false
    var fetchingAvailable: Bool = true
    
    // MARK: - Lifecycle
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SearchViewOutput interface implementation

extension SearchPresenter: SearchViewOutput {
    
    func searchBarShouldChange(text: String) -> Bool {
        // Seach bar text validation
        // To prevent big text pasting
        text.count < 100
    }
    
    func searchBarSearch(text: String) {
        
        // Validating search text
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            view?.completeEditing(clearSearchBar: true)
            return
        }
        
        // Current search parameters
        currentPage = 1
        currentSearchQuery = trimmedText
        
        // UI preparing
        view?.completeEditing(clearSearchBar: false)
        view?.setLoadingEnabled(enabled: true)
        
        // Fetching words
        fetchWords(
            query: currentSearchQuery,
            page: currentPage,
            success: { [weak self] words in
                self?.fetchingAvailable = !words.isEmpty
                self?.view?.setLoadingEnabled(enabled: false)
                self?.view?.reloadResults(models: words)
            },
            failure: { [weak self] error in
                self?.view?.setLoadingEnabled(enabled: false)
                // show error
            }
        )
    }
    
    func searchBarCancel() {
        view?.completeEditing(clearSearchBar: false)
    }

    func viewDidLoad() {
        // prepare view 
    }
    
    func didSelectMeaning(meaningViewModel: MeaningViewModel) {
        let meaningId = meaningViewModel.meaningDescription.id
        self.router.routeToMeaningDetail(meaningId: meaningId)
    }
    
    func shouldFetchMore() {
        guard !fetchingNow, fetchingAvailable else {
            return
        }
        
        // UI preparing
        view?.setFetchingLoader(enabled: true)
        
        // Fetching next page
        fetchWords(
            query: currentSearchQuery,
            page: currentPage + 1,
            success: { [weak self] words in
                self?.fetchingAvailable = !words.isEmpty
                self?.currentPage += 1
                self?.view?.setFetchingLoader(enabled: false)
                self?.view?.insertResults(models: words)
            },
            failure: { [weak self] error in
                self?.view?.setFetchingLoader(enabled: false)
                // show error
            }
        )
    }
    
    /// Fetch words
    /// - Parameters:
    ///   - success: Success closure
    ///   - failure: Failure closure
    ///   - query: Search query
    ///   - page: Page
    private func fetchWords(
        query: String,
        page: Int,
        success: @escaping ([WordViewModel]) -> Void,
        failure: @escaping (Error) -> Void
    ) {

        fetchingNow = true
        interactor.fetchWords(query: currentSearchQuery, page: currentPage, completion: { [weak self] result in
            switch result {
            case .success(let words):
                let models = words.map { WordViewModel(word: $0) }.filter { !$0.meanings.isEmpty }
                DispatchQueue.main.async {
                    success(models)
                    self?.fetchingNow = false
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    failure(error)
                    self?.fetchingNow = false
                }
            }
        })
    }
    
}

// MARK: - SearchInteractorOutput interface implementation

extension SearchPresenter: SearchInteractorOutput {
    
}


