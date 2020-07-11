//
//  MeaningDetailInteractorProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol MeaningDetailInteractorInput: class {
    func obtainMeaningDetail(meaningId: Int)
}

protocol MeaningDetailInteractorOutput: class {
    func didObtainMeaningDetail(meaning: Meaning)
    func didFailToObtainMeaningDetail(error: Error)
}
