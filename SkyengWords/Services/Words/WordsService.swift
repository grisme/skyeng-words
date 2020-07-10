//
//  WordsService.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Words service implementation
final class WordsService: WordsProviding {
    
    // MARK: - Declarations
    
    /// Enumerates service's endpoints
    private enum Endpoints: String {
        case search = "/words/search"
    }
    
    // MARK: - Properties
    
    /// Injected networking service
    private let networkService: Networking
    
    // MARK: - Lifecycle
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    // MARK: - WordsProviding interface implementation
    
    func obtainWords(with searchQuery: String, page: Int, pageSize: Int) {
        
        struct SearchParameters: Encodable {
            let search: String
            let page: Int
            let pageSize: Int
        }

        let parameters = SearchParameters(
            search: searchQuery,
            page: page,
            pageSize: pageSize
        )
        
        networkService.performRequest(
            endpoint: Endpoints.search.rawValue,
            type: .get,
            params: parameters,
            completion: { result in
                
            }
        )
        
    }
    
}
