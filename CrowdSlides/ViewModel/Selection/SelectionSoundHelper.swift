//
//  SelectionSoundhelper.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 10/01/2025.
//

import Foundation

class SelectionSoundHelper {
    
    private var settings: SlideshowSelectionSettings

    
    init(settings: SlideshowSelectionSettings) {
        self.settings = settings
    }
    
    
    public func handleSound(currentPhase: SelectionPhase) {
        switch currentPhase {
            case .presentation:
                if let sound = settings.presentationSound {
                    SoundManager.shared.stopAllSounds()
                    SoundManager.shared.playSound(sound)
                }
            case .voting:
                if let sound = settings.votingSound {
                    SoundManager.shared.stopAllSounds()
                    SoundManager.shared.playSound(sound)
                }
            case .showResults:
                if let sound = settings.resultsSound {
                    SoundManager.shared.stopAllSounds(fadeDuration: 0)
                    SoundManager.shared.playSound(sound)
                }
        }
    }

}
