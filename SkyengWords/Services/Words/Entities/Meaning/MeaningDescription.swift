//
//  MeaningDescription.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Describes simple word's meaning description
struct MeaningDescription: Codable, Equatable {
    /// Unique identifier
    let id: Int
    /// Part of speech
    let partOfSpeechCode: PartOfSpeech
    /// Meaning's translation
    let translation: Translation
    /// Image preview URL
    let previewUrl: String
    // Image URL
    let imageUrl: String
    /// Meaning transcription
    let transcription: String
    /// Meaning playable sound URL
    let soundUrl: String
}
