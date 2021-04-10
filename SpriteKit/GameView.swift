//
//  GameView.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    let scene: SKScene
    @State var score = 0

    var body: some View {
        HStack {
            Spacer()
            Text("Score: \(score)")
                .font(.largeTitle)
            Spacer()
        }
            
        GeometryReader { proxy in
            GameViewRepresentable(scene: scene, proxy: proxy)
        }
    }
}

struct GameViewRepresentable: NSViewRepresentable {
    let scene: SKScene
    let proxy: GeometryProxy

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> SKView {
        scene.size = proxy.size
        context.coordinator.scene = scene

        let view = SKView()
        view.showsFPS = true
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true
        
        view.presentScene(scene)
        return view
    }

    func updateNSView(_ nsView: SKView, context: Context) {
        context.coordinator.resizeScene(proxy: proxy)
    }

    class Coordinator: NSObject {
        weak var scene: SKScene?

        func resizeScene(proxy: GeometryProxy) {
            scene?.size = proxy.size
        }
    }
}
