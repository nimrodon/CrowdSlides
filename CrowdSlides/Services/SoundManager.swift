//
//  SoundManager.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 15/12/2024.
//


import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()

    private let defaultVolume: Float = 0.75
    private let defaultFadeDuration: TimeInterval = 1
    private let fadeOutInterval: TimeInterval = 0.05

    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private var fadeOutTimers: [String: Timer] = [:]


    public func playSound(_ sound: Sound, loop: Bool = false) {
        if !sound.filename.isEmpty, let soundFilePath = LocalAssetsHelper.getSoundPath(soundFilename: sound.filename) {
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: soundFilePath)
                audioPlayer.numberOfLoops = loop ? -1 : 0
                audioPlayer.volume = sound.volume ?? defaultVolume
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                audioPlayers[sound.filename] = audioPlayer
            } catch {
                print("Play Sound: Failed to play sound \(sound.filename): \(error.localizedDescription)")
            }
        }
    }

    
    public func stopSound(_ soundName: String, fadeDuration: TimeInterval? = nil) {
        guard let audioPlayer = audioPlayers[soundName] else {
            return
        }

        let fadeOutDuration = fadeDuration ?? defaultFadeDuration
        if fadeOutDuration == 0 {
            audioPlayer.stop()
            self.audioPlayers[soundName] = nil
        }
        else {
            fadeOutTimers[soundName]?.invalidate()
            let volumeStep = Float(audioPlayer.volume) / Float(fadeOutDuration / fadeOutInterval)
            
            fadeOutTimers[soundName] = Timer.scheduledTimer(withTimeInterval: fadeOutInterval, repeats: true) { timer in
                if audioPlayer.volume > 0.0 {
                    audioPlayer.volume -= volumeStep
                }
                else {
                    timer.invalidate()
                    audioPlayer.stop()
                    self.audioPlayers[soundName] = nil
                    self.fadeOutTimers[soundName] = nil
                }
            }
        }
    }

    
    public func stopAllSounds(fadeDuration: TimeInterval? = nil) {
        for (soundName, _) in audioPlayers {
            stopSound(soundName, fadeDuration: fadeDuration)
        }
    }
}
