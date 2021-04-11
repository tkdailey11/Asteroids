//
//  LaunchScreen.swift
//  Asteroids
//
//  Created by Tyler Dailey on 4/10/21.
//

import SwiftUI

struct LaunchScreen: View {
    let startGame: () -> Void
    var body: some View {
        Button("Start") {
            startGame()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen() {
            print("Preview StartGame")
        }
    }
}
