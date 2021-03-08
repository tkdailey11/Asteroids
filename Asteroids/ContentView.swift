//
//  ContentView.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(scene: GameScene())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
