//
//  levelpasscelabration.swift
//  Horror Game
//
//  Created by Habishek B on 19/06/25.
//

import SwiftUI

struct VictoryCelebrationView: View {
    @Binding var isVisible: Bool
    @State private var animate = false
    @State private var showStars = false
    
    var body: some View {
        ZStack {
            if isVisible {
                // Glowing background
                LinearGradient(colors: [.black, .purple, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .blur(radius: animate ? 60 : 0)
                    .opacity(animate ? 0.8 : 0)
                    .animation(.easeInOut(duration: 1.5), value: animate)

                // Main text animation
                Text("LEVEL UP!")
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .yellow, radius: 25)
                    .scaleEffect(animate ? 1.25 : 0.6)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 100)
                    .animation(.interpolatingSpring(stiffness: 65, damping: 8).delay(0.2), value: animate)
                    .zIndex(2)


                // Stars flying
                if showStars {
                    ForEach(0..<30, id: \.self) { index in
                        StarParticle()
                    }
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
                .blur(radius: 10)
        )
        .onAppear {
            
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showStars = true
            }

            // Hide after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                isVisible = false
            }

        }
    }
}

struct StarParticle: View {
    @State private var x: CGFloat = .random(in: -200...200)
    @State private var y: CGFloat = .random(in: -200...200)
    @State private var scale: CGFloat = .random(in: 0.3...0.9)
    @State private var rotation: Angle = .degrees(.random(in: 0...360))

    var body: some View {
        Image(systemName: "sparkle")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .position(x: 200 + x, y: 400 + y)
            .scaleEffect(scale)
            .rotationEffect(rotation)
            .opacity(0.8)
            .transition(.scale)
            .animation(
                Animation.easeOut(duration: 2)
                    .repeatCount(1, autoreverses: false)
                    .delay(Double.random(in: 0...1.5)),
                value: x
            )
    }
}
#Preview {
    VictoryCelebrationView(isVisible: .constant(true))
}
