//
//  Word.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Describes searched word entity
struct Word: Codable, Equatable {
    /// Word's identifier
    let id: Int
    /// Word's printable text value
    let text: String
    /// Word meaning descriptions
    let meanings: [MeaningDescription]
}
