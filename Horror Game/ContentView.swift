//
//  ContentView.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGame = false
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashView(showSplash: $showSplash)
            } else if showGame {
                GameView(showGame: $showGame)
            } else {
                HomeView(showGame: $showGame)
            }
        }
    }
}
