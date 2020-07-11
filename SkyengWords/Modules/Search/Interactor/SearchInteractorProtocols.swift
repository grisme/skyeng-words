//
//  SearchInteractorProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol SearchInteractorInput: class {
    func fetchWords(query: String, page: Int)
}

protocol SearchInteractorOutput: class {
    func wordsFetchingComplete(words: [Word])
    func wordsFetchingFailed(with error: Error)
}
