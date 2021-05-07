//
//  GameLabel.swift
//  Asteroids
//
//  Created by Tyler Dailey on 5/3/21.
//

import SwiftUI

struct GameLabel: View {
    
    var content: String
    var font: Font?
    
    var body: some View {
        if let f = font {
            Text(content)
                .font(f)
        } else {
            Text(content)
                .font(.joystixBody)
        }
    }
}

struct GameLabel_Previews: PreviewProvider {
    static var previews: some View {
        GameLabel(content: "Test")
    }
}
