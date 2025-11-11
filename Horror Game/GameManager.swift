//
//  GameManager.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI
import AVFoundation

class GameManager: ObservableObject {
    var jumpSoundPlayer: AVAudioPlayer?

    @Published var playerY: CGFloat = 300
    @Published var coins: [GameItem] = []
    @Published var isGameOver = false
    @Published var isPaused = false
    @Published var score = 0
    @Published var coinsCollected = 0
    @Published var obstacles: [Obstacle] = [Obstacle(position: CGPoint(x: 300, y: 300))]
    @Published var levelPassed = false
    @Published var showVictory = false
    @Published var Motivate = false
    @Published var hasShield = false
    @Published var shieldActive = false

    @AppStorage("highScore") var highScore: Int = 0
    @AppStorage("totalCoins1") var totalCoins1: Int = 0
    @AppStorage("totalCoins2") var totalCoins2: Int = 0
    @AppStorage("lastLoginDate") var lastLoginDate: String = ""
    @AppStorage("dailyStreak") var dailyStreak: Int = 0
    @AppStorage("unlockedLevel") var unlockedLevel: Int = 1

    @Published var bgmVolume: Float = 1.0
    @Published var sfxVolume: Float = 1.0
    @Published var coinVolume: Float = 1.0

    private var gravity: CGFloat = 1.2
    private var velocity: CGFloat = 0
    private var isJumping = false
    private var timer: Timer?
    private var playerX: CGFloat = 100
    private var isHit = false
    private var startTime: Date?

    func jump() {
        if !isGameOver && playerY > 100 {
            velocity = -15
            //playJumpSound(volume: sfxVolume)
        }
    }

    func gameLoop() {
        guard !isPaused else { return }

        velocity += gravity
        playerY += velocity

        if playerY < 100 {
            playerY = 100
            velocity = max(velocity, 0)
        }

        if playerY > 400 {
            playerY = 400
            velocity = 0
            isJumping = false
        }

        for i in 0..<obstacles.count {
            obstacles[i].position.x -= 4

            if obstacles[i].position.x < playerX && !obstacles[i].hasScored {
                score += 1
                obstacles[i].hasScored = true
            }
            if score > highScore {
                highScore = score
            }
        }

        obstacles.removeAll { $0.position.x < -50 }

        for i in 0..<coins.count {
            coins[i].position.x -= 4
        }

        coins.removeAll { $0.position.x < -50 || $0.isCollected }

        for i in 0..<coins.count {
            let dx = abs(coins[i].position.x - playerX)
            let dy = abs(coins[i].position.y - playerY)

            if dx < 30 && dy < 30 && !coins[i].isCollected {
                coins[i].isCollected = true
                score += 1
                coinsCollected += 1
                totalCoins1 += 1
                playCoinSound(volume: coinVolume)
            }
        }

        for obstacle in obstacles {
            let dx = abs(obstacle.position.x - playerX)
            let dy = abs(obstacle.position.y - playerY)

            if dx < 40 && dy < 40 {
                if !shieldActive {
                    stopGame()
                    break
                } else {
                    continue
                }
            }
        }
    }

    func startGame() {
        playerX = 100
        playerY = 400
        velocity = 0
        isJumping = false
        score = 0
        coinsCollected = 0
        isGameOver = false
        levelPassed = false
        shieldActive = false
        hasShield = UserDefaults.standard.bool(forKey: "hasShield")
        startTime = Date()

        playBackgroundMusic(volume: bgmVolume)

        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            self.gameLoop()
        }

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            let randomY = CGFloat.random(in: 380...400)
            let newObstacle = Obstacle(position: CGPoint(x: 500, y: randomY))
            self.obstacles.append(newObstacle)
        }

        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            let randomY = CGFloat.random(in: 200...380)
            let newCoin = GameItem(position: CGPoint(x: 500, y: randomY), type: "coin")
            self.coins.append(newCoin)
        }
    }

    func stopGame(currentLevel: Int = 1) {
        timer?.invalidate()
        timer = nil
        isGameOver = true
        stopBackgroundMusic()
        completeLevel(currentLevel)
    }

    func restartGame() {
        playerX = 100
        playerY = 400
        velocity = 0
        isJumping = false
        obstacles = []
        isGameOver = false
        levelPassed = false
        startGame()
    }

    func pauseGame() {
        isPaused = true
    }

    func resumeGame() {
        isPaused = false
    }

    func checkDailyLoginReward() -> Int? {
        let today = formattedDate(Date())

        if lastLoginDate != today {
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let yesterdayString = formattedDate(yesterday)

            if lastLoginDate == yesterdayString {
                dailyStreak += 1
            } else {
                dailyStreak = 0
            }

            let reward = min(10 + dailyStreak * 10, 150)
            totalCoins2 += reward
            lastLoginDate = today

            return reward
        }

        return nil
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    func requiredScore(for level: Int) -> Int {
        var total = 50
        if level >= 2 {
            for i in 2...level {
                total += 10 + (i % 2 == 0 ? 10 : 15)
            }
        }
        return total
    }

    func completeLevel(_ level: Int) {
        let timeTaken = Date().timeIntervalSince(startTime ?? Date())
        let required = requiredScore(for: level)

        print("🔍 Score: \(score), Required: \(required), Time: \(Int(timeTaken))s")

        if score >= required && timeTaken <= 90 {
            levelPassed = true
            showVictory = true
            if unlockedLevel <= level {
                unlockedLevel = level + 1
                print("🎉 Unlocked Level \(unlockedLevel)!")
            }
        } else {
            levelPassed = false
            Motivate = true
            print("❌ Level NOT passed. Try again.")
        }
    }

    func activateShield() {
        guard hasShield else { return }
        shieldActive = true
        hasShield = false
        UserDefaults.standard.set(false, forKey: "hasShield")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.shieldActive = false
        }
    }

    func checkCollision(with obstacle: Obstacle) {
        if !shieldActive {
            isGameOver = true
        }
    }

    func purchaseShield() {
        hasShield = true
        UserDefaults.standard.set(true, forKey: "hasShield")
    }
}
