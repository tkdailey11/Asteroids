//
//  GameButton.swift
//  Asteroids
//
//  Created by Tyler Dailey on 5/3/21.
//

import SwiftUI

struct GameButton: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(title) {
            action()
        }
        .font(.joystixBody)
        .padding()
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(title: "test", action: { print("test") })
    }
}
