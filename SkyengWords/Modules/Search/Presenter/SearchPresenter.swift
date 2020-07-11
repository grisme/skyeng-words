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
        text.count < 100
    }
    
    func searchBarSearch(text: String) {
        
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else {
            view?.completeEditing(clearSearchBar: true)
            return
        }
        
        currentPage = 0
        view?.completeEditing(clearSearchBar: false)
        view?.setSearchBarEnabled(enabled: false)
        view?.setLoadingEnabled(enabled: true)
        interactor.fetchWords(query: trimmedText, page: 1)
    }
    
    func searchBarCancel() {
        view?.completeEditing(clearSearchBar: false)
    }

    func viewDidLoad() {
        // prepare view 
    }
    
}

// MARK: - SearchInteractorOutput interface implementation

extension SearchPresenter: SearchInteractorOutput {
    
    func wordsFetchingComplete(words: [Word]) {
        
        // Map results and show in view
        let models = words.map { WordViewModel(word: $0) }
        
        // Updating UI
        DispatchQueue.main.async {
            self.view?.setSearchBarEnabled(enabled: true)
            self.view?.setLoadingEnabled(enabled: false)
            self.view?.reloadResults(models: models)
        }
    }
    
    func wordsFetchingFailed(with error: Error) {
        // Updating UI
        DispatchQueue.main.async {
            self.view?.setSearchBarEnabled(enabled: true)
            self.view?.setLoadingEnabled(enabled: false)
        }
    }

}


