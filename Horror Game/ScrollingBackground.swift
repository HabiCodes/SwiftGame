//
//  ScrollingBackground.swift
//  Horror Game
//
//  Created by Habishek B on 22/06/25.
//

import SwiftUI

struct ScrollingBackground: View {
    @State private var offset: CGFloat = 0
    let speed: CGFloat = 20  // lower = slower scroll

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Image("dark_forest_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .clipped()
                
                Image("dark_forest_bg") // second image to loop
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .clipped()
            }
            .offset(x: offset)
            .onAppear {
                let totalWidth = geometry.size.width
                let duration = totalWidth / speed

                withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                    offset = -totalWidth
                }
            }
        }
        .ignoresSafeArea()
    }
}
