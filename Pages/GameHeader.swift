//
//  GameHeader.swift
//  Asteroids
//
//  Created by Tyler Dailey on 4/10/21.
//

import SwiftUI

struct GameHeader: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Text("Score: \(settings.score)")
            .font(.joystixBody)
    }
}
