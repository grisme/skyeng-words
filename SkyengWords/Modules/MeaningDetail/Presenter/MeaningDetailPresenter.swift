//
//  MeaningDetailPresenter.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

final class MeaningDetailPresenter {
    
    // MARK: - Properties
    
    weak var view: MeaningDetailViewInput?
    let interactor: MeaningDetailInteractorInput
    
    /// Meaning identifier
    let meaningId: Int
    
    // MARK: - Lifecycle
    
    init(meaningId: Int, interactor: MeaningDetailInteractorInput) {
        self.meaningId = meaningId
        self.interactor = interactor
    }
    
}

// MARK: - MeaningDetailViewOutput inteface implementation

extension MeaningDetailPresenter: MeaningDetailViewOutput {
    func viewDidLoad() {
        
    }
}

// MARK: - MeaningDetailInteractorOutput interface implementation

extension MeaningDetailPresenter: MeaningDetailInteractorOutput {
    func didObtainMeaningDetail(meaning: Meaning) {
        
    }
    
    func didFailToObtainMeaningDetail(error: Error) {
        
    }
    
    
}
