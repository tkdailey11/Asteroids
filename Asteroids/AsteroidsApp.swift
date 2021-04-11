//
//  AsteroidsApp.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SwiftUI

@main
struct AsteroidsApp: App {
    @State private var gameSettings = GameSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView(gs: self.gameSettings)
                .frame(width: 1400, height: 900, alignment: .center)
        }
    }
}
