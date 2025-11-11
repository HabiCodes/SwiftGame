//
//  viewer.swift
//  Horror Game
//
//  Created by Habishek B on 19/06/25.
//

import SwiftUI

struct GameManagerPreviewView: View {
    @StateObject var gameManager = GameManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("Score: \(gameManager.score)")
            Text("Level Passed: \(gameManager.levelPassed ? "✅" : "❌")")

            Button("Simulate Score +10") {
                gameManager.score += 10
            }

            Button("End Level") {
                gameManager.completeLevel(1) // Test Level 1
            }
        }
        .padding()
    }
}

