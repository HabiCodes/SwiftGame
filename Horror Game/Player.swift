//
//  Player.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//


import SwiftUI
struct Player: View {
    @Binding var position: CGFloat

    var body: some View {
        Image("shyam")
            .resizable()
            .frame(width: 60, height: 60)
            .position(x: 100, y: position)
    }
}
