//
//  settings.swift
//  Horror Game
//
//  Created by Habishek B on 13/06/25.
//

import SwiftUI

struct SoundSettingsView: View {
    @ObservedObject var manager: GameManager
    @Binding var showSettings: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.9).ignoresSafeArea()

            VStack(spacing: 30) {
                Text("🎵 Sound Settings")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                VStack(alignment: .leading) {
                    Text("BGM Volume")
                        .foregroundColor(.white)
                    Slider(value: Binding(
                        get: { Double(manager.bgmVolume) },
                        set: { newValue in
                            manager.bgmVolume = Float(newValue)
                            gameSound?.volume = Float(newValue)
                            print(newValue)
                        }
                    ), in: 0...1)
                }

                VStack(alignment: .leading) {
                    Text("Jump SFX Volume")
                        .foregroundColor(.white)
                    Slider(value: Binding(
                        get: { Double(manager.sfxVolume) },
                        set: { newValue in
                            manager.sfxVolume = Float(newValue)
                        }
                    ), in: 0...1)
                }
                VStack(alignment: .leading) {
                    Text("coin SFX Volume")
                        .foregroundColor(.white)
                    Slider(value: Binding(
                        get: { Double(manager.coinVolume) },
                        set: { newValue in
                            manager.coinVolume = Float(newValue)
                        }
                    ), in: 0...1)
                }


                Button(action: {
                    showSettings = false
                }) {
                    Text("Back")
                        .frame(width: 200)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                
            }
            .padding()
        }
    }
}
