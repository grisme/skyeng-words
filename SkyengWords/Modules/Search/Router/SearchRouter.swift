//
//  SearchRouter.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class SearchRouter: SearchRouterInput {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
    // MARK: - SearchRouterInput interface implementation
    
    func routeToMeaningDetail(meaningId: Int) {
        let meaningDetail = MeaningDetailAssembly.assembleMeaningDetail(meaningId: meaningId)
        view?.navigationController?.pushViewController(meaningDetail, animated: true)
    }
    
}
