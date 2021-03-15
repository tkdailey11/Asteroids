//
//  GameScene.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SpriteKit
import VectorMath

struct PhysicsCategory {
    static let none         : UInt32 = 0
    static let all          : UInt32 = UInt32.max
    static let asteroid     : UInt32 = 0b1       // 1
    static let projectile   : UInt32 = 0b10      // 2
}

struct ArrowKeys : OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static var None : ArrowKeys { return ArrowKeys(rawValue: 0) }
    static var Up   : ArrowKeys { return ArrowKeys(rawValue: 1 << 0) }
    static var Down : ArrowKeys { return ArrowKeys(rawValue: 1 << 1) }
    static var Left : ArrowKeys { return ArrowKeys(rawValue: 1 << 2) }
    static var Right: ArrowKeys { return ArrowKeys(rawValue: 1 << 3) }
    static var Space: ArrowKeys { return ArrowKeys(rawValue: 1 << 4) }
}

class GameScene: SKScene {
    // 1
    let player = Player.instance
    var participants: [Participant] = []
    var bulletCount: Int = 0
    var previousFrameTime: CFTimeInterval?
    var keyDownFlag = false
    var arrowKeys = ArrowKeys.None

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
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
    }
    
    override func didMove(to view: SKView) {

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
            
        case Keycode.f1:
            let asteroid = Asteroid(Int.random(in: 1 ... 4))
            asteroid.velocity = Vector2(Scalar(Int.random(in: 5 ... 100)), Scalar(Int.random(in: 5 ... 100)))
            asteroid.position = CGPoint(x: Double.random(in: 0.0 ... Double(frame.width)), y: Double.random(in: 0.0 ... Double(frame.height)))
            addChild(asteroid)
            
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

//extension GameScene: SKPhysicsContactDelegate {
//    func didBegin(_ contact: SKPhysicsContact) {
//        let shockWaveAction: SKAction = {
//            let growAndFadeAction = SKAction.group([SKAction.scale(to: 50, duration: 0.5),
//                                                    SKAction.fadeOut(withDuration: 0.5)])
//
//            let sequence = SKAction.sequence([growAndFadeAction,
//                                              SKAction.removeFromParent()])
//
//            return sequence
//        }()
//        print(contact.collisionImpulse)
//        if contact.collisionImpulse > 5 &&
//            contact.bodyA.node?.name == "ball" &&
//            contact.bodyB.node?.name == "ball" {
//
//            let shockwave = SKShapeNode(circleOfRadius: 1)
//
//            shockwave.position = contact.contactPoint
//            scene?.addChild(shockwave)
//
//            shockwave.run(shockWaveAction)
//        }
//    }
//}
