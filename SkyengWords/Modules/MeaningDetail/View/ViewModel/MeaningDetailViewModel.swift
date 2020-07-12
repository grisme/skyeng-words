//
//  MeaningDetailViewModel.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 12.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

struct MeaningDetailViewModel {
    
    // MARK: - Properties
    
    let meaning: Meaning
    
    var imagesCount: Int {
        meaning.images.count
    }
    
    var text: String {
        meaning.text.uppercased()
    }
    
    var translationText: String {
        meaning.translation.text ?? "No translation available"
    }
    
    var definition: TextSoundable {
        meaning.definition
    }
    
    var examples: [TextSoundable] {
        meaning.examples
    }
    
    var partOfSpeechText: String {
        self.meaning.partOfSpeechCode.displayName
    }
    
    var partOfSpeechColor: UIColor {
        return UIColor.Common.View.cellBackground
        // TODO: May be different colors for each part of speech
        // switch partOfSpeech { case .noun: ... }
    }

    func imageURL(for image: Int) -> URL? {
        guard image >= 0 && image < imagesCount else {
            return nil
        }
        return URL(string: "https:" + meaning.images[image].url)
    }

    // MARK: - Initializers
    init(meaning: Meaning) {
        self.meaning = meaning
    }
}
