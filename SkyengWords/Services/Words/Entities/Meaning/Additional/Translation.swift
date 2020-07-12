//
//  Translation.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

/// Describes meaning translation entity
struct Translation: Codable, Equatable {
    /// Translation text
    let text: String?
    /// Translation note
    let note: String?
}
