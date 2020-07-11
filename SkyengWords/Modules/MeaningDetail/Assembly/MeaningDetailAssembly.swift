//
//  MeaningDetailAssembly.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class MeaningDetailAssembly {
    
    /// Assembles meaning detail module with specified meaning identifier
    /// - Parameter meaningId: Meaning identifier
    /// - Returns: Module view controller
    static func assembleMeaningDetail(meaningId: Int) -> UIViewController {
        
        let networkService = NetworkService()
        let wordsService = WordsService(networkService: networkService)
        
        let interactor = MeaningDetailInteractor(wordsService: wordsService)
        let presenter = MeaningDetailPresenter(meaningId: meaningId, interactor: interactor)
        let view = MeaningDetailViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = view
        return view
    }
    
}
