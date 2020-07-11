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

    /// Enumerates service errors
    enum Error: LocalizedError {
        case invalidData
        case requestError(code: Int)
        case unspecifiedError
        
        var errorDescription: String? {
            switch self {
            case .invalidData:
                return "Failed to parse Words entities from obtained data"
            case .requestError(let code):
                return "Request error with code \(code)"
            case .unspecifiedError:
                return "Failed to obtain words"
            }
        }
    }

    /// Enumerates service's endpoints
    private enum Endpoints: String {
        case search = "/words/search"
        case meanings = "/meanings"
    }
    
    // MARK: - Properties
    
    /// Injected networking service
    private let networkService: Networking
    
    /// Data decoder
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    // MARK: - Lifecycle
    
    init(networkService: Networking) {
        self.networkService = networkService
    }
    
    // MARK: - WordsProviding interface implementation
    
    func obtainMeaningDetail(meaningId: Int, completion: @escaping MeaningDetailCompletion) {
        
        struct MeaningParameters: Encodable {
            let ids: String
        }
        
        let parameters = MeaningParameters(ids: "\(meaningId)")
        
        networkService.performRequest(
            endpoint: Endpoints.meanings.rawValue,
            type: .get,
            params: parameters,
            completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let data):
                    do {
                        let meaning = try self.decoder.decode(Meaning.self, from: data)
                        completion(.success(meaning))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                    
                case .failure(let error):
                    switch error {
                    case .requestError(let code):
                        completion(.failure(.requestError(code: code)))
                    default:
                        completion(.failure(.unspecifiedError))
                    }
                    
                }
            }
        )
    }
    
    func obtainWords(with searchQuery: String, page: Int, pageSize: Int, completion: @escaping WordSearchCompletion) {
        
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
        
        // Performing search request
        networkService.performRequest(
            endpoint: Endpoints.search.rawValue,
            type: .get,
            params: parameters,
            completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let data):
                    do {
                        let words = try self.decoder.decode([Word].self, from: data)
                        completion(.success(words))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                    break
                    
                case .failure(let error):
                    switch error {
                    case .requestError(let code):
                        completion(.failure(.requestError(code: code)))
                    default:
                        completion(.failure(.unspecifiedError))
                    }
                    break
                }
            }
        )
        
    }
    
}
