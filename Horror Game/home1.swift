//
//  home1.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI
import AVFoundation

struct SplashView: View {
    @Binding var showSplash: Bool
    @State private var animateGlow = false
    @State private var glowPulse = false
    @State private var futuristicProgress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Deep space gradient
            RadialGradient(gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.6), Color.blue.opacity(0.3)]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            // Galactic Particles
            TimelineView(.animation) { context in
                Canvas { context, size in
                    for _ in 0..<100 {
                        let x = CGFloat.random(in: 0..<size.width)
                        let y = CGFloat.random(in: 0..<size.height)
                        let size = CGFloat.random(in: 0.5...2.5)
                        let color = Color(hue: Double.random(in: 0.5...0.7), saturation: 1, brightness: 1)
                        context.fill(Ellipse().path(in: CGRect(x: x, y: y, width: size, height: size)), with: .color(color))
                    }
                }
            }
            
            VStack(spacing: 50) {
                Spacer()

                // CYBER TITLE
                Text("Welcome")
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundStyle(
                        LinearGradient(colors: [.cyan, .white, .purple], startPoint: .top, endPoint: .bottom)
                    )
                    .glow(color: .cyan, radius: animateGlow ? 40 : 10)
                    .scaleEffect(glowPulse ? 1.04 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: glowPulse)
                    .padding()

                // Futuristic animated orb loading
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5)
                        .foregroundColor(.purple.opacity(0.2))
                        .frame(width: 140, height: 140)
                    
                    Circle()
                        .trim(from: 0, to: futuristicProgress)
                        .stroke(
                            AngularGradient(gradient: Gradient(colors: [.cyan, .blue, .purple, .orange]), center: .center),
                            style: StrokeStyle(lineWidth: 10, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 140, height: 140)
                        .animation(.easeInOut(duration: 2), value: futuristicProgress)

                    // Inner Core
                    Circle()
                        .fill(RadialGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .black]), center: .center, startRadius: 5, endRadius: 60))
                        .frame(width: 60, height: 60)
                }

                // Digital Loading Text
                Text("\"Starting up...")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.cyan)
                    .padding(.bottom, 80)

                Spacer()
            }
        }
        .onAppear {
            animateGlow = true
            glowPulse = true
            futuristicProgress = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                showSplash = false
            }
        }
    }
}

extension View {
    func glow(color: Color = .white, radius: CGFloat = 20) -> some View {
        self.shadow(color: color.opacity(0.6), radius: radius)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(showSplash: .constant(true))
    }
}

