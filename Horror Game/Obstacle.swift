//
//  Untitled.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI

struct ObstacleView: View {
    var position: CGPoint

    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 50, height: 30)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
            .position(position)
    }
}
