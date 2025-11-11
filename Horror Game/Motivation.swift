//
//  Motivation.swift
//  Horror Game
//
//  Created by Habishek B on 19/06/25.
//

let motivationalQuotes = [
    "Failure is not defeat — it's data.",
    "Legends are built from retries.",
    "Each fall sharpens your rise.",
    "You're closer than you think.",
    "The brave fail better.",
    "Pain is real. So is progress.",
    "Press restart. Become stronger.",
    "Even shadows prove light exists."
]

import SwiftUI

struct Motivation: View {
    @Binding var isVisible: Bool
    let onHome: () -> Void

    @State private var animate = false
    let quote = motivationalQuotes.randomElement()!

    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .blur(radius: 10)

            VStack(spacing: 25) {
                Text("❌ YOU FELL...")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(color: .red, radius: 10)

                Text("“\(quote)”")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.yellow)
                    .padding(.horizontal)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1.1 : 0.8)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: animate)

                Button {
                    isVisible = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        onHome() // 👈 go to home after a short delay
                    }
                } label: {
                    Text("🔄 Never Give Up")
                        .font(.title3)
                        .bold()
                        .padding()
                        .frame(width: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom))
                        )
                        .foregroundColor(.white)
                        .shadow(color: .cyan, radius: 15)
                }
                .scaleEffect(animate ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 1).repeatForever(), value: animate)
            }
            .padding()
        }
        .onAppear {
            animate = true
        }
    }
}
