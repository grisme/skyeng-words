//
//  MeaningDetailInteractorProtocols.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol MeaningDetailInteractorInput: class {
    func obtainMeaningDetail(meaningId: Int, completion: @escaping (Result<Meaning, Error>) -> Void)
}

protocol MeaningDetailInteractorOutput: class {
}
