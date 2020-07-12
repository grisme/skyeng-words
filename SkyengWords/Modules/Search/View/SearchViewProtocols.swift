//
//  SearchViewProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol SearchViewInput: class {
    func setSearchBarEnabled(enabled: Bool)
    func completeEditing(clearSearchBar: Bool)
    func setLoadingEnabled(enabled: Bool)
    func setFetchingLoader(enabled: Bool)
    func setNoResultsState()
    func setInitialState()
    func setErrorState(text: String)
    
    func reloadResults(models: [WordViewModel])
    func insertResults(models: [WordViewModel])
}

protocol SearchViewOutput: class {
    func viewDidLoad()
    func searchBarShouldChange(text: String) -> Bool
    func searchBarSearch(text: String)
    func searchBarCancel()
    func shouldFetchMore()
    func didSelectMeaning(meaningViewModel: MeaningViewModel)
}
