import SwiftUI

struct HomeView: View {
    @Binding var showGame: Bool
    @State private var showSettings = false
    @State private var showLevels = false
    @State private var showitems = false
    @StateObject var manager = GameManager()
    @AppStorage("totalCoins1") var totalCoins: Int = 0
    @State private var rewardToday: Int? = nil
    @State private var showRewardView = false
    @State private var showprogrescard: Bool = true

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple, Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("SHADOW RUNNER")
                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.cyan, .white], startPoint: .top, endPoint: .bottom)
                    )
                    .shadow(color: .cyan.opacity(0.8), radius: 15, x: 0, y: 0)
                    .padding(.top, 60)

                // 🪙 Total coins
                HStack(spacing: 8) {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.yellow)

                    Text("Total Coins: \(totalCoins)")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow.opacity(0.7), lineWidth: 1.5)
                )
                .shadow(color: .yellow.opacity(0.4), radius: 10)

                // 🎁 Reward banner
                if showRewardView, let reward = rewardToday {
                    VStack(spacing: 10) {
                        Text("🎁 DAILY REWARD")
                            .font(.title3.bold())
                            .foregroundColor(.white)

                        Text("You received \(reward) coins!")
                            .font(.headline)
                            .foregroundColor(.green)
                            .transition(.scale)
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.green.opacity(0.6), lineWidth: 2)
                    )
                    .shadow(color: .green.opacity(0.5), radius: 10)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showRewardView = false
                            }
                        }
                    }
                }

                // 🚀 Neon Start Button
                Button(action: {
                    OrientationManager.forceLandscape()
                    showGame = true
                }) {
                    Text("START GAME")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.purple.opacity(0.3))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cyan, lineWidth: 2)
                                )
                        )
                        .shadow(color: .cyan.opacity(0.6), radius: 10)
                }

                Spacer()
            }

            // ⚙️ Bottom Bar
            VStack {
                Spacer()

                HStack(spacing: 50) {
                    // 🧩 Levels Button
                    Button(action: {
                        showLevels = true
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: "list.number")
                                .font(.system(size: 20))
                            Text("Levels")
                                .font(.footnote)
                        }
                        .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showLevels) {
                        LevelSelectionView()
                    }

                    // ⚙️ Settings Button
                    Button(action: {
                        showSettings = true
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 20))
                            Text("Settings")
                                .font(.footnote)
                        }
                        .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showSettings) {
                        SoundSettingsView(manager: manager, showSettings: $showSettings)
                    }
                    Button(action: {
                        showitems=true
                    }){
                        VStack(spacing: 4){
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 20))
                            Text("Items")
                                .font(.footnote)
                        }.foregroundColor(.white)
                    }.sheet(isPresented: $showitems){
                        GameStoreView()
                    }
                    Button(action: {
                        showprogrescard=true
                    }){
                        VStack(spacing: 4){
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 20))
                            Text("Progres")
                                .font(.footnote)
                        }.foregroundColor(.white)
                    }.sheet(isPresented: $showprogrescard){
                        SmartProfileCard(name: "Habishek", expertat: "aggressive player 🔥")
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.black.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.1))
                        )
                        .shadow(color: .cyan.opacity(0.4), radius: 10)
                )
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            if let reward = manager.checkDailyLoginReward() {
                rewardToday = reward
                withAnimation {
                    showRewardView = true
                }
            }
        }
    }
}

#Preview {
    HomeView(showGame: .constant(true))
}

extension Int: Identifiable {
    public var id: Int { self }
}
