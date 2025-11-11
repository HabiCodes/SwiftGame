//
//  gameitems.swift
//  Horror Game
//
//  Created by Habishek B on 18/06/25.
//


let sampleItems = [
    ShopItem(name: "Health Potion", price: 50, icon: "capsule.fill"),
    ShopItem(name: "Fire Sword", price: 120, icon: "flame.fill"),
    ShopItem(name: "Shield", price: 20, icon: "shield.fill"),
    ShopItem(name: "Magic Wand", price: 150, icon: "wand.and.stars")
]



import SwiftUI

struct GameStoreView: View {
    @AppStorage("totalCoins1") var totalCoins: Int = 0
    @State private var items = sampleItems
    @AppStorage("shiledCount") var shieldCount: Int = 0
    var body: some View {
        VStack(spacing: 20) {
            // Player Coins
            HStack {
                Image(systemName: "bitcoinsign.circle.fill")
                    .foregroundColor(.yellow)
                Text("Coins: \(totalCoins)")
                    .font(.headline)
                    .bold()
            }

            // Item List
            List {
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.icon)
                            .foregroundColor(.blue)
                            .frame(width: 30)

                        Text(item.name)
                            .font(.headline)

                        Spacer()

                        Text("\(item.price) 💰")
                            .foregroundColor(.orange)

                        Button("Buy") {
                            buy(item: item)
                        }
                        .padding(.horizontal)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(totalCoins < item.price)
                    }
                }
            }
        }
        .padding()
    }

    func buy(item: ShopItem) {
        if totalCoins >= item.price {
            totalCoins -= item.price
            if item.name == "Shield" {
                shieldCount += 1
                UserDefaults.standard.set(true, forKey: "hasShield")
            }
        }
    }

}
