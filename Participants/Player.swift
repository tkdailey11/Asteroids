//
//  Player.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import Foundation
import SpriteKit
import VectorMath

class Player: Participant {
    
    static let instance = Player.init()
    static let RotationSpeed: Scalar = 5.0
    static let MaxAcceleration: Scalar = 10.0
    static let Deceleration: Scalar = 0.975
    
    init() {
        //With Flame
//        var points = [CGPoint(x: 0, y: 20),
//                      CGPoint(x: 12, y: -20),
//                      CGPoint(x: 10, y: -13),
//                      CGPoint(x: -5, y: -13),
//                      CGPoint(x: 0, y: -24),
//                      CGPoint(x: 5, y: -13),
//                      CGPoint(x: -10, y: -13),
//                      CGPoint(x: -12, y: -20),
//                      CGPoint(x: 0, y: 20)]
        //Without Flame
//        var points = [CGPoint(x: 0, y: 20),
//                      CGPoint(x: 12, y: -20),
//                      CGPoint(x: 10, y: -13),
//                      CGPoint(x: -10, y: -13),
//                      CGPoint(x: -12, y: -20),
//                      CGPoint(x: 0, y: 20)]
        
        // TODO: Set texture based on variety
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: NSColor.white, size: texture.size())
        
        let body = SKPhysicsBody(circleOfRadius: max(self.frame.width / 2, self.frame.height / 2))
        body.affectedByGravity = false
        body.contactTestBitMask = 0x00000001
        self.physicsBody = body

        super.type = .Player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(keys: ArrowKeys, timeDelta: Scalar, frame: CGRect){
        if keys.contains(.Right) {
            rotation = rotation - (timeDelta * Player.RotationSpeed)
        }
        else if keys.contains(.Left) {
            rotation = rotation + (timeDelta * Player.RotationSpeed)
        }
        
        if keys.contains(.Up) {
            accelerate()
        }
        else if keys.contains(.Down) {
            decelerate()
        }
        
        updateVelocity()
        updatePosition(timeDelta: timeDelta, frame: frame)
    }
    
    override func updatePosition(timeDelta: Scalar, frame: CGRect) {
        self.zRotation = CGFloat(rotation)
        super.updatePosition(timeDelta: timeDelta, frame: frame)
    }

    func getNose() -> Vector2 {
        var nose = Vector2(-0.3, 20)
        nose = transformPoint(nose)
        return nose
    }
}
