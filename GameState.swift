//
//  UpdateScore.swift
//  Asteroids
//
//  Created by Tyler Dailey on 4/11/21.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var score = 0
    @Published var gameStarted = false
    @Published var gameOver = false
}

protocol UpdateGameStateDelegate: AnyObject {
    func updateScore(_ delta: Int)
    func toggleGameOver()
}

class StateUpdater: UpdateGameStateDelegate {
    
    @Binding var score: Int
    @Binding var gameOver: Bool
    
    init(gameScore: Binding<Int>, gameOver: Binding<Bool>) {
        _score = gameScore
        _gameOver = gameOver
    }
    
    func updateScore(_ delta: Int) {
        score += delta
    }
    
    func toggleGameOver() {
        gameOver.toggle()
    }
}
