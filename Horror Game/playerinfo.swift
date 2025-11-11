//
//  LevelSelectionView.swift
//  Shadow Runner
//
//  Created by Habishek B on 18/06/25.
//

import SwiftUI

struct LevelSelectionView: View {
    @AppStorage("totalCoins1") var totalCoins: Int = 0
    @AppStorage("unlockedLevel") var unlockedLevel: Int = 1 // Default: Only Level 1 unlocked
    @State private var animateGlow = false

    let levels = Array(1...10)

    var body: some View {
        ZStack {
            // Animated background
            LinearGradient(colors: [.purple, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Game title
                Text("🚀 RUN MADNESS 🚀")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                    .shadow(color: .yellow, radius: 10)

                // Coin display
                HStack {
                    Spacer()
                    Label("\(totalCoins)", systemImage: "bitcoinsign.circle.fill")
                        .foregroundColor(.yellow)
                        .font(.title2)
                        .padding(8)
                        .background(Color.black.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.trailing)
                }

                // Level grid
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                    ForEach(levels, id: \.self) { level in
                        Button(action: {
                            if level <= unlockedLevel {
                                startLevel(level)
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(level <= unlockedLevel ? Color.blue : Color.gray)
                                    .frame(width: 140, height: 80)
                                    .shadow(color: .white.opacity(0.5), radius: animateGlow ? 20 : 5)
                                    .scaleEffect(animateGlow && level <= unlockedLevel ? 1.05 : 1.0)
                                    .animation(.easeInOut(duration: 1).repeatForever(), value: animateGlow)

                                VStack {
                                    Text("Level \(level)")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.white)

                                    if level > unlockedLevel {
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .disabled(level > unlockedLevel)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            animateGlow = true
        }
    }

    func startLevel(_ level: Int) {
        print("Start Level \(level)")
        // Call your GameManager logic or pass level to the gameplay view
    }
}

