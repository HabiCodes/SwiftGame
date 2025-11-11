//
//  SFX.swift
//  Horror Game
//
//  Created by Habishek B on 13/06/25.
//

import AVFoundation
var jumpSoundPlayer: AVAudioPlayer?

func playJumpSound(volume: Float = 1.0) {
    if let url = Bundle.main.url(forResource: "jump", withExtension: "mp3") {
        do {
            jumpSoundPlayer = try AVAudioPlayer(contentsOf: url)
            jumpSoundPlayer?.volume = volume
            jumpSoundPlayer?.play()
        } catch {
            print("❌ Error playing jump sound: \(error)")
        }
    }
}
