//
//  WordViewModel.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 11.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import Foundation

struct WordViewModel {
    
    // MARK: - Properties
    
    /// Source word entity
    let word: Word
    /// Word's meanings
    let meanings: [MeaningViewModel]
    
    /// Word title
    var title: String {
        word.text
    }
    
    /// Meanings count
    var meaningsCount: Int {
        meanings.count
    }
    
    // MARK: - Initializers
    
    init(word: Word) {
        self.word = word
        // Mapping word's meanings and filtering words with empty translation
        self.meanings = self.word.meanings
                .filter { !($0.translation.text ?? "").isEmpty }
                .map { MeaningViewModel(meaningDescription: $0) }
    }
    
}
