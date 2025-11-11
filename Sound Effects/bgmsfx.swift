//
//  bgmsfx.swift
//  Horror Game
//
//  Created by Habishek B on 13/06/25.
//

import AVFoundation
var gameSound: AVAudioPlayer?


func playBackgroundMusic(volume: Float = 1.0) {
    if let url = Bundle.main.url(forResource: "gamebgm", withExtension: "mp3") {
        do {
            gameSound = try AVAudioPlayer(contentsOf: url)
            gameSound?.numberOfLoops = -1
            gameSound?.volume = volume
            gameSound?.play()
        } catch {
            print("❌ Error playing BGM: \(error)")
        }
    }
}

func stopBackgroundMusic() {
    gameSound?.stop()
}
