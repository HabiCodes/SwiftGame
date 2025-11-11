//
//  Obstacles.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI
struct Obstacle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var hasScored: Bool = false
}
