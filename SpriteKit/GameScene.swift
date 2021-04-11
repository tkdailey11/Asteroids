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
    var bulletCount: Int = 0
    var previousFrameTime: CFTimeInterval?
    var keyDownFlag = false
    var arrowKeys = ArrowKeys.None
    
    weak var scoreDelegate: UpdateScoreDelegate?
    
    
    override func update(_ currentTime: CFTimeInterval) {
        let timeDelta = Scalar(currentTime - (previousFrameTime ?? currentTime))
        
        player.update(keys: arrowKeys, timeDelta: timeDelta, frame: self.frame)
        
        for participant in participants {
            participant.updatePosition(timeDelta: timeDelta, frame: self.frame)
            if participant.type == ParticipantType.Bullet && participant.shouldBeRemoved {
                bulletCount -= 1
            }
        }
        participants = participants.filter { !$0.shouldBeRemoved }
        
        previousFrameTime = currentTime
    }
    
    override func sceneDidLoad() {
        backgroundColor = .black
        
        addChild(player)
        addAsteroids()
    }
    
    func addAsteroids() {
        let asteroid1 = Asteroid(Int.random(in: 1 ... 4))
        asteroid1.velocity = Vector2(Scalar(Int.random(in: 5 ... 100)), Scalar(Int.random(in: 5 ... 100)))
        asteroid1.position = CGPoint(x: Double.random(in: 0.0 ... Double(frame.width)), y: Double.random(in: 0.0 ... Double(frame.height)))
        addChild(asteroid1)
        
        let asteroid2 = Asteroid(Int.random(in: 1 ... 4))
        asteroid2.velocity = Vector2(Scalar(Int.random(in: 5 ... 100)), Scalar(Int.random(in: 5 ... 100)))
        asteroid2.position = CGPoint(x: Double.random(in: 0.0 ... Double(frame.width)), y: Double.random(in: 0.0 ... Double(frame.height)))
        addChild(asteroid2)
        
        let asteroid3 = Asteroid(Int.random(in: 1 ... 4))
        asteroid3.velocity = Vector2(Scalar(Int.random(in: 5 ... 100)), Scalar(Int.random(in: 5 ... 100)))
        asteroid3.position = CGPoint(x: Double.random(in: 0.0 ... Double(frame.width)), y: Double.random(in: 0.0 ... Double(frame.height)))
        addChild(asteroid3)
        
        let asteroid4 = Asteroid(Int.random(in: 1 ... 4))
        asteroid4.velocity = Vector2(Scalar(Int.random(in: 5 ... 100)), Scalar(Int.random(in: 5 ... 100)))
        asteroid4.position = CGPoint(x: Double.random(in: 0.0 ... Double(frame.width)), y: Double.random(in: 0.0 ... Double(frame.height)))
        addChild(asteroid4)
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
            if contact.bodyA.node?.name == "bullet" {
                guard let b = contact.bodyA.node as? Bullet else {
                    return
                }
                b.shouldBeRemoved = true
                b.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                
                scoreDelegate?.increaseScore()
            } else if contact.bodyB.node?.name == "bullet" {
                guard let b = contact.bodyB.node as? Bullet else {
                    return
                }
                b.shouldBeRemoved = true
                b.removeFromParent()
                contact.bodyA.node?.removeFromParent()
                
                scoreDelegate?.increaseScore()
            }
        }
    }
}

protocol UpdateScoreDelegate: AnyObject {
    func increaseScore()
}
