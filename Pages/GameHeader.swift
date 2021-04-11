//
//  GameHeader.swift
//  Asteroids
//
//  Created by Tyler Dailey on 4/10/21.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var score = 1
    @Published var gameStarted = false
    
}

struct GameHeader: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Text("Score: \(settings.score)")
    }
}
