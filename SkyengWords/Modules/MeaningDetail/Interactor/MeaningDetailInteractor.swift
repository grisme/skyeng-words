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
    
    func obtainMeaningDetail(meaningId: Int) {
        
        wordsService.obtainMeaningDetail(meaningId: meaningId) { [weak self] result in
            switch result {
            case .success(let meaning):
                self?.output?.didObtainMeaningDetail(meaning: meaning)
            case .failure(let error):
                self?.output?.didFailToObtainMeaningDetail(error: error)
            }
        }
        
    }
}
