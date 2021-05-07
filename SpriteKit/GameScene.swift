//
//  GameScene.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SpriteKit
import VectorMath
import SwiftUI

class GameScene: SKScene {
    
    let player = Player.instance
    var participants: [Participant] = []
    var asteroidCount: Int = 0
    var bulletCount: Int = 0
    var previousFrameTime: CFTimeInterval?
    var keyDownFlag = false
    var arrowKeys = ArrowKeys.None
    
    weak var gameStateDelegate: UpdateGameStateDelegate?
    
    
    override func update(_ currentTime: CFTimeInterval) {
        let timeDelta = Scalar(currentTime - (previousFrameTime ?? currentTime))
        
        player.update(keys: arrowKeys, timeDelta: timeDelta, frame: self.frame)
        
        for participant in participants {
            participant.updatePosition(timeDelta: timeDelta, frame: self.frame)
            if participant.type == ParticipantType.Bullet && participant.shouldBeRemoved {
                bulletCount -= 1
            }
            if participant.type == ParticipantType.Asteroid && participant.shouldBeRemoved {
                asteroidCount -= 1
                
                //add smaller asteroids
                if participant.xScale >= 2.0 {
                    var pos = participant.position
                    pos.x -= 50
                    let a1 = Asteroid(Int.random(in: 1 ... 4), scale: 1.0, position: pos)

                    pos.x += 100
                    let a2 = Asteroid(Int.random(in: 1 ... 4), scale: 1.0, position: pos)

                    addChild(a1)
                    addChild(a2)

                    participants.append(a1)
                    participants.append(a2)
                    asteroidCount += 2
                }
            }
        }
        participants = participants.filter { !$0.shouldBeRemoved }
        
        previousFrameTime = currentTime
        
        if asteroidCount <= 0 {
            gameStateDelegate?.toggleGameOver()
        }
    }
    
    override func sceneDidLoad() {
        backgroundColor = .black
        
        addChild(player)
        addAsteroids()
    }
    
    func addAsteroids() {
        let scale: CGFloat = 2.0
        
        let asteroid1 = Asteroid(Int.random(in: 1 ... 4), scale: scale, position: nil)
        addChild(asteroid1)
        participants.append(asteroid1)
        asteroidCount += 1

        let asteroid2 = Asteroid(Int.random(in: 1 ... 4), scale: scale, position: nil)
        addChild(asteroid2)
        participants.append(asteroid2)
        asteroidCount += 1

        let asteroid3 = Asteroid(Int.random(in: 1 ... 4), scale: scale, position: nil)
        addChild(asteroid3)
        participants.append(asteroid3)
        asteroidCount += 1

        let asteroid4 = Asteroid(Int.random(in: 1 ... 4), scale: scale, position: nil)
        addChild(asteroid4)
        participants.append(asteroid4)
        asteroidCount += 1
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    }
    
    override func keyDown(with event: NSEvent) {
        keyDownFlag = true
        interpretKeyEvents([event])
        handleKeyEvent(event: event, keyDown: true)
    }
    
    override func keyUp(with event: NSEvent) {
        keyDownFlag = false
        interpretKeyEvents([event])
        handleKeyEvent(event: event, keyDown: false)
    }
    
    func handleKeyEvent(event: NSEvent, keyDown: Bool) {
        let keyCode = event.keyCode
        switch keyCode {
        case Keycode.upArrow:
            if keyDown {
                arrowKeys.insert(.Up)
            }
            else {
                arrowKeys.remove(.Up)
            }
        case Keycode.downArrow:
            if keyDown {
                arrowKeys.insert(.Down)
            }
            else {
                arrowKeys.remove(.Down)
            }
        case Keycode.leftArrow:
            if keyDown {
                arrowKeys.insert(.Left)
            }
            else {
                arrowKeys.remove(.Left)
            }
        case Keycode.rightArrow:
            if keyDown {
                arrowKeys.insert(.Right)
            }
            else {
                arrowKeys.remove(.Right)
            }
            
        case Keycode.space:
            if bulletCount < 10 {
                let nose = player.getNose()
                let bullet = Bullet(start: nose, speed: player.velocity, direction: player.rotation)
                addChild(bullet)
                participants.append(bullet)
                bulletCount += 1
            }
        default:
            if keyDown {
                arrowKeys.insert(.Space)
            }
            else {
                arrowKeys.remove(.Space)
            }
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node != player && contact.bodyB.node != player {
            guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else {
                return
            }
            
            handleBulletAsteroidCollision(nodeA: nodeA, nodeB: nodeB)
        }
    }
    
    func handleBulletAsteroidCollision(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "bullet" {
            guard let bullet = nodeA as? Bullet, let asteroid = nodeB as? Asteroid else {
                return
            }
            bullet.shouldBeRemoved = true
            bullet.removeFromParent()
            
            asteroid.shouldBeRemoved = true
            asteroid.removeFromParent()
            
            gameStateDelegate?.updateScore(1)
        } else if nodeB.name == "bullet" {
            guard let bullet = nodeB as? Bullet, let asteroid = nodeA as? Asteroid else {
                return
            }
            
            bullet.shouldBeRemoved = true
            bullet.removeFromParent()
            
            asteroid.shouldBeRemoved = true
            asteroid.removeFromParent()
            
            gameStateDelegate?.updateScore(1)
        }
    }
}
