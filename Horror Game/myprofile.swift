//
//  myprofile.swift
//  Horror Game
//
//  Created by Habishek B on 22/06/25.
//

import SwiftUI

struct SmartProfileCard: View {
    @State var name: String
    @AppStorage("unlockedLevel") var unlockedLevel: Int = 1
    @AppStorage("totalCoins1") var totalCoins: Int = 0
    @AppStorage("highScore") var highScore: Int = 0
    @State var expertat: String
    @State private var isGlowing: Bool = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.pink, .purple, .blue, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // Profile image
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.bottom, 4)

                // Name and title
                Text(name)
                    .font(.title2.bold())
                    .foregroundColor(.white)

                Text(expertat)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))

                Divider().background(Color.white.opacity(0.5))

                // Stats
                HStack(spacing: 12) {
                    StatView(title: "Level", value: "\(unlockedLevel)")
                    StatView(title: "Highscore", value: "\(highScore)")
                    StatView(title: "Coins", value: "\(totalCoins)")
                }

                Spacer()
            }
            .padding()
            .frame(width: 260, height: 320)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(isGlowing ? Color.yellow : Color.white.opacity(0.2), lineWidth: 2)
                    .shadow(color: isGlowing ? Color.yellow.opacity(0.7) : .clear, radius: 12, x: 0, y: 0)
            )
            .animation(.easeInOut(duration: 0.4), value: isGlowing)
            .onTapGesture {
                isGlowing.toggle()
            }
        }
    }
}

// Reusable stat component
struct StatView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}


