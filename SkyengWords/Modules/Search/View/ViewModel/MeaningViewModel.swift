//
//  MeaningViewModel.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

struct MeaningViewModel {
    
    /// Source meaning entity
    let meaningDescription: MeaningDescription

    var translation: String {
        meaningDescription.translation.text ?? ""
    }
    
    var transcription: String {
        if meaningDescription.transcription.isEmpty {
            return "Transcription unavailable"
        }
        return meaningDescription.transcription
    }
    
    var partOfSpeechText: String {
        self.meaningDescription.partOfSpeechCode.displayName
    }
    
    var partOfSpeechColor: UIColor {
        return UIColor.Common.View.cellBackground
        // TODO: May be different colors for each part of speech
        // switch partOfSpeech { case .noun: ... }
    }
    
}
