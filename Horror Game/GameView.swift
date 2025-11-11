//
//  GameView.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var manager = GameManager()
    @Binding var showGame: Bool
    @State private var showSettings = false
    @State private var showVictory: Bool = false
    @State private var Motivate: Bool = false
    @AppStorage("shiledCount") var shieldCount: Int = 0
    var body: some View {
        ZStack {
            // 🔵 Background
            ScrollingBackground()


            // 🎮 Game Elements
            Player(position: $manager.playerY)
            ForEach(manager.coins) { coin in
                CoinView(position: coin.position)
            }
            ForEach(manager.obstacles) { obstacle in
                ObstacleView(position: obstacle.position)
            }

            // 🔺 Top HUD
            VStack {
                HStack {
                    hudItem(title: "💠 SCORE", value: "\(manager.score)", color: .green)
                    hudItem(title: "🪙 COINS", value: "\(manager.coinsCollected)", color: .yellow)
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal)

                Spacer()

                // 🕹️ Jump Button
//                Button(action: {
//                    manager.jump()
//                }) {
//                    Text("JUMP")
//                        .font(.title3)
//                        .bold()
//                        .padding()
//                        .frame(width: 120)
//                        .background(Color.white.opacity(0.15))
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                        .shadow(color: .cyan, radius: 10)
//                }
//                .padding(.bottom, 30)
                if manager.hasShield || manager.shieldActive {
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                manager.activateShield()
                            }) {
                                Image(systemName: "shield.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(manager.shieldActive ? Color.green : Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            }
                            .disabled(manager.shieldActive || !manager.hasShield)
                            Text("X\(shieldCount)")
                                .font(.callout)
                                .background(Color.black)
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.bottom, 30)
                    }
                }

            }

            // 🚨 Game Over Panel (only if NOT celebrating)
            if manager.isGameOver && !showVictory {
                if Motivate {
                    Motivation(isVisible: $Motivate) {
                        Motivate = false
                    }
                    .zIndex(999)
                }

                
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .blur(radius: 5)

                VStack(spacing: 20) {
                    Text("🛑 GAME OVER")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .red, radius: 10)

                    Text(manager.levelPassed ? "🎉 LEVEL COMPLETE!" : "❌ LEVEL FAILED")
                        .foregroundColor(manager.levelPassed ? .green : .red)
                        .font(.title2)
                        .bold()

                    VStack(spacing: 6) {
                        Text("Your Score: \(manager.score)").foregroundColor(.white)
                        Text("Coins Collected: \(manager.coinsCollected)").foregroundColor(.yellow)
                        Text("Required Score: \(manager.requiredScore(for: 1))").foregroundColor(.orange)
                    }
                    .font(.callout)
                    .padding(.bottom, 10)

                    // 🎮 Buttons
                    futuristicButton("🔄 RESTART", color: .blue) {
                        manager.restartGame()
                    }

                    futuristicButton("🏠 HOME", color: .purple) {
                        showGame = false
                    }

                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .sheet(isPresented: $showSettings) {
                        SoundSettingsView(manager: manager, showSettings: $showSettings)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(colors: [.black.opacity(0.8), .purple.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                        .shadow(color: .purple.opacity(0.7), radius: 20, x: 0, y: 10)
                )
                .padding(.horizontal, 20)
            }

            // 🎉 VICTORY CELEBRATION — TOP MOST LAYER
            if showVictory {
                VictoryCelebrationView(isVisible: $showVictory)
                    .transition(.opacity)
                    .zIndex(999)
            }
        }
        .onAppear {
            manager.startGame()
            
        }
        .onTapGesture {
            manager.jump()
        }
        .onChange(of: manager.isGameOver) { newValue in
            if newValue && !manager.levelPassed {
                manager.resumeGame()
                Motivate = true
            }
        }

    }

    // MARK: - HUD Panel
    func hudItem(title: String, value: String, color: Color) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(color)
        }
        .padding(10)
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
    }

    // MARK: - Futuristic Buttons
    func futuristicButton(_ text: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .padding()
                .frame(width: 220)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(LinearGradient(colors: [color.opacity(0.9), color.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .foregroundColor(.white)
                .shadow(color: color.opacity(0.6), radius: 10, x: 0, y: 5)
        }
    }
}

#Preview {
    VictoryCelebrationView(isVisible: .constant(true))
}
