//
//  SearchInteractorProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol SearchInteractorInput: class {
    func fetchWords(query: String, page: Int, completion: @escaping (Result<[Word], Error>) -> Void)
}

protocol SearchInteractorOutput: class {
}
