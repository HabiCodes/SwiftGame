//
//  Coins.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI
struct CoinView: View {
    let position: CGPoint

    var body: some View {
        Image("coins")
            .resizable()
            .frame(width: 30, height: 30)
            .position(position)
    }
}
