//
//  WordsProviding.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol WordsProviding: class {
    
    /// Obtains words with search query
    /// - Parameters:
    ///   - searchQuery: Words search query
    ///   - page: Search results page number
    ///   - pageSize: Page items count
    func obtainWords(with searchQuery: String, page: Int, pageSize: Int)
    
}
