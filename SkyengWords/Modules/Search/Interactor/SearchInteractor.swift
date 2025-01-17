//
//  SearchInteractor.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

final class SearchInteractor: SearchInteractorInput {
    
    // MARK: - Declaration
    static let wordsPageSize = 10
    
    // MARK: - Properties

    /// Interactor's output instance
    weak var output: SearchInteractorOutput?
    /// Words provider
    let wordsService: WordsProviding
    
    // MARK: - Lifecycle
    
    init(wordsService: WordsProviding) {
        self.wordsService = wordsService
    }
    
    // MARK: - SearchInteractorInput implementation
    
    func fetchWords(query: String, page: Int, completion: @escaping (Result<[Word], Error>) -> Void) {
        wordsService.obtainWords(with: query, page: page, pageSize: SearchInteractor.wordsPageSize) { [weak self] result in
            switch result {
            case .success(let words):
                completion(.success(words))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
