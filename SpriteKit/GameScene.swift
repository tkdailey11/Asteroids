//
//  GameScene.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import SpriteKit

struct PhysicsCategory {
    static let none         : UInt32 = 0
    static let all          : UInt32 = UInt32.max
    static let asteroid     : UInt32 = 0b1       // 1
    static let projectile   : UInt32 = 0b10      // 2
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene {
    // 1
    let player = Player.instance
    
    var key: UInt16 = Keycode.upArrow
    var previousFrameTime: CFTimeInterval?

    override func update(_ currentTime: CFTimeInterval) {
        let timeDelta = CGFloat(currentTime - (previousFrameTime ?? currentTime))
        
        player.update(key: key, timeDelta: timeDelta)
        applyInfiniteScrollToNode(node: player.shapeNode, frame: self.frame)
        
        previousFrameTime = currentTime
    }
    
    override func sceneDidLoad() {
        backgroundColor = .black
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        
        print("loaded")
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
    }
    
    override func didMove(to view: SKView) {
        
        // 4
        addChild(player.shapeNode)
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    override func keyDown(with event: NSEvent) {
//        print("Key Down")
//        switch event.keyCode {
//        case Keycode.upArrow:
//            if player.position.y > size.height {
//                player.position.y = 0
//            }
//            else {
//                player.position.y += 10
//            }
//        case Keycode.downArrow:
//            if player.position.y < 0 {
//                player.position.y = size.height
//            }
//            else {
//                player.position.y -= 10
//            }
//        case Keycode.leftArrow:
//            if player.position.x < 0 {
//                player.position.x = size.width
//            }
//            else {
//                player.position.x -= 10
//            }
//        case Keycode.rightArrow:
//            if player.position.x > size.width {
//                player.position.x = 0
//            }
//            else {
//                player.position.x += 10
//            }
//        default:
//            print("Unmapped Key")
//        }
        self.key = event.keyCode
    }
    
    func applyInfiniteScrollToNode(node: SKNode, frame: CGRect) {
        if node.position.x > self.frame.width {
            node.position.x = 0
        } else if node.position.x < 0 {
            node.position.x = self.frame.width
        }
        
        if node.position.y > self.frame.height {
            node.position.y = 0
        } else if node.position.y < 0 {
            node.position.y = self.frame.height
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.asteroid != 0) &&
                (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
            if let monster = firstBody.node as? SKSpriteNode,
               let projectile = secondBody.node as? SKSpriteNode {
//                projectileDidCollideWithMonster(projectile: projectile, monster: monster)
            }
        }
    }
    
}
