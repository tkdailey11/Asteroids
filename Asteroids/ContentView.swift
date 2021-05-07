//
//  ContentView.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var settings: GameSettings
    let scene: GameScene = GameScene()
    @State private var updater: StateUpdater?
    
    init(gs: GameSettings) {
        self.settings = gs
    }
    
    var body: some View {
        GameView(scene: scene, settings: settings)
            .onAppear() {
                updater = StateUpdater(gameScore: $settings.score, gameOver: $settings.gameOver)
                scene.gameStateDelegate = updater
            }
    }
}
