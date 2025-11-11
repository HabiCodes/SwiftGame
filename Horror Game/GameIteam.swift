//
//  GameIteam.swift
//  Horror Game
//
//  Created by Habishek B on 12/06/25.
//

import SwiftUI

struct GameItem: Identifiable {
    let id = UUID()
    var position: CGPoint
    var type: String
    var isCollected: Bool = false
}

enum GameItemType {
    case coin
    case obstacle
}
struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let icon: String // system image name
}
