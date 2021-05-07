//
//  GameView.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    let scene: GameScene
    @StateObject var settings = GameSettings()
    
    var body: some View {
        if settings.gameStarted && !settings.gameOver {
            VStack {
                GameHeader()
                if let sc = scene {
                    GeometryReader { proxy in
                        GameViewRepresentable(scene: sc, proxy: proxy)
                    }
                }
            }
            .environmentObject(settings)
        } else if settings.gameOver {
            Spacer()
            GameLabel(content: "Game Over", font: .joystixHeader)
            Spacer()
            GameButton(title: "Play Again") {
                print("Play Again")
            }
            Spacer()
        }else {
            LaunchScreen() {
                settings.gameStarted = true
            }
            .environmentObject(settings)
        }
    }
}

struct GameViewRepresentable: NSViewRepresentable {
    let scene: GameScene
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
        weak var scene: GameScene?
        
        func resizeScene(proxy: GeometryProxy) {
            scene?.size = proxy.size
        }
    }
}
