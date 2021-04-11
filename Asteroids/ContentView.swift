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
    @State private var updater: ScoreUpdater?
    
    init(gs: GameSettings) {
        self.settings = gs
    }
    
    var body: some View {
        GameView(scene: scene, settings: settings)
            .onAppear() {
                updater = ScoreUpdater(gameScore: $settings.score)
                scene.scoreDelegate = updater
                print("appear")
            }
    }
}

class ScoreUpdater: UpdateScoreDelegate {
    
    @Binding var score: Int
    
    init(gameScore: Binding<Int>) {
        _score = gameScore
    }
    
    func increaseScore() {
        score += 1
    }
}
