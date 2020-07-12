//
//  MeaningDetailRouter.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

final class MeaningDetailRouter: MeaningDetailRouterInput {
    
    // MARK: - Properties
    
    weak var view: UIViewController?
    
    // MARK: - MeaningDetailRouterInput implementation
    
    func routeBack() {
        view?.navigationController?.popViewController(animated: true)
    }
}
