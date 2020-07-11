//
//  MeaningViewModel.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

struct MeaningViewModel {
    
    /// Source meaning entity
    let meaningDescription: MeaningDescription

    var translation: String {
        meaningDescription.translation.text ?? ""
    }
    
    var transcription: String {
        meaningDescription.transcription
    }
    
}
