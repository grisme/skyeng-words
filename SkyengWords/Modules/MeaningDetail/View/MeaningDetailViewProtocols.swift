//
//  MeaningDetailViewProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol MeaningDetailViewInput: class {
    func setLoadingEnabled(enabled: Bool)
}

protocol MeaningDetailViewOutput: class {
    func viewDidLoad()
}

