//
//  WordsProviding.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Search completion closure alias
typealias WordSearchCompletion = (Result<[Word], WordsService.Error>) -> Void
/// Meaning fetch completion closure alias
typealias MeaningDetailCompletion = (Result<Meaning, WordsService.Error>) -> Void

protocol WordsProviding: class {
    
    /// Obtains words with search query
    /// - Parameters:
    ///   - searchQuery: Words search query
    ///   - page: Search results page number
    ///   - pageSize: Page items count
    ///   - completion: Completion closure
    func obtainWords(with searchQuery: String, page: Int, pageSize: Int, completion: @escaping WordSearchCompletion)
    
    /// Obtains meaning detail
    /// - Parameters:
    ///   - meaningId: Meaning identifier to obtain
    ///   - completion: Completion closure
    func obtainMeaningDetail(meaningId: Int, completion: @escaping MeaningDetailCompletion)
    
}
