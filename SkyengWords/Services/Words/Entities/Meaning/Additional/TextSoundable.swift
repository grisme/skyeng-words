//
//  TextSoundable.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

protocol TextSoundable: Codable {
    var text: String { get }
    var soundUrl: String? { get }
}
