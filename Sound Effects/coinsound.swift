//
//  coinsound.swift
//  Horror Game
//
//  Created by Habishek B on 14/06/25.
//

import AVFoundation
func playCoinSound(volume: Float) {
    if let url = Bundle.main.url(forResource: "coin", withExtension: "mp3") {
        do {
            jumpSoundPlayer = try AVAudioPlayer(contentsOf: url)
            jumpSoundPlayer?.volume = volume
            jumpSoundPlayer?.play()

        } catch {
            print("❌ Error playing BGM: \(error)")
        }
    }
}
