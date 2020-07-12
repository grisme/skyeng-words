//
//  SearchAssembly.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class SearchAssembly {
    
    /// Assembles search word module
    /// - Returns: Search word module view controller
    static func assembleSearch() -> UIViewController {
        
        let networkService = NetworkService()
        let wordsService = WordsService(networkService: networkService)
        
        let router = SearchRouter()
        let interactor = SearchInteractor(wordsService: wordsService)
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let view = SearchViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = view
        router.view = view
        return view
    }
    
}
