//
//  PartOfSpeech.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Enumerates avaiable parts of speech
enum PartOfSpeech: String, Codable, Equatable {
    case noun = "n"
    case verb = "v"
    case adjective = "j"
    case adverb = "r"
    case preposition = "prp"
    case pronoun = "prn"
    case cardinalNumber = "crd"
    case conjunction = "cjc"
    case interjection = "exc"
    case article = "det"
    case abbreviation = "abb"
    case particle = "x"
    case ordinalNumber = "ord"
    case modalVerb = "md"
    case phrase = "ph"
    case idiom = "phi"
    
    /// Returns part of speech display name
    var displayName: String {
        switch self {
        case .noun:
            return "noun"
        case .verb:
            return "verb"
        case .adjective:
            return "adjective"
        case .adverb:
            return "adverb"
        case .preposition:
            return "preposition"
        case .pronoun:
            return "pronoun"
        case .cardinalNumber:
            return "cardinal number"
        case .conjunction:
            return "conjunction"
        case .interjection:
            return "interjection"
        case .article:
            return "article"
        case .abbreviation:
            return "abbreviation"
        case .particle:
            return "particle"
        case .ordinalNumber:
            return "ordinal number"
        case .modalVerb:
            return "modal verb"
        case .phrase:
            return "phrase"
        case .idiom:
            return "idiom"
        }
    }
}
