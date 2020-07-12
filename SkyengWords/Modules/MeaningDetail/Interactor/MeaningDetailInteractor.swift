//
//  MeaningDetailInteractor.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

final class MeaningDetailInteractor: MeaningDetailInteractorInput {
    
    // MARK: - Properties
    
    weak var output: MeaningDetailInteractorOutput?
    let wordsService: WordsProviding
    
    // MARK: - Lifecycle
    
    init(wordsService: WordsProviding) {
        self.wordsService = wordsService
    }
    
    // MARK: - MeaningDetailInteractorInput interface implementation
    
    func obtainMeaningDetail(meaningId: Int, completion: @escaping (Result<Meaning, Error>) -> Void) {
        
        wordsService.obtainMeaningDetail(meaningId: meaningId) { result in
            switch result {
            case .success(let meaning):
                completion(.success(meaning))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
