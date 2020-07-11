//
//  Meaning.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation


/// Describes detailed word's meaning entity
struct Meaning: Codable {
    
    /// Describes meaning image structure
    struct Image: Codable {
        let url: String
    }
        
    /// Unique identifier
    let id: Int
    /// Part of speech
    let partOfSpeechCode: PartOfSpeech
    /// Meaning's translation
    let translation: Translation
    /// Meaning transcription
    let transcription: String
    /// Meaning playable sound URL
    let soundUrl: String
    /// Images collection
    let images: [Image]
    /// Meaning definition
    let definition: Definition
    /// Examples
    let examples: [Example]
}
