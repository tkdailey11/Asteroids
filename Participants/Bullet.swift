//
//  Bullet.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/11/21.
//

import Foundation
import SpriteKit
import VectorMath

class Bullet: Participant {
    
    var MaxTime: Scalar = 2.0
    var elapsedTime: Scalar = 0.0
    
    init(start: Vector2, speed: Vector2, direction: Scalar) {
//        var points = [CGPoint(x: 0, y: 0),
//                      CGPoint(x: 0, y: 5),
//                      CGPoint(x: 1, y: 5),
//                      CGPoint(x: 1, y: 0),
//                      CGPoint(x: 0, y: 0)]

        // TODO: Set texture based on variety
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture: texture, color: NSColor.white, size: texture.size())
        
        self.position = CGPoint(x: CGFloat(start.x), y: CGFloat(start.y))
        velocity = Vector2(cos(direction + Float(Double.pi / 2)), sin(direction + Float(Double.pi / 2))) * BULLET_SPEED
        if velocity.length > BULLET_SPEED {
            velocity = velocity * (BULLET_SPEED / velocity.length)
        }
        zRotation = CGFloat(direction)

        let body = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height))
        body.contactTestBitMask = 0x00000001
        body.affectedByGravity = false
        self.physicsBody = body

        super.type = .Bullet
        self.name = "bullet"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updatePosition(timeDelta: Scalar, frame: CGRect) {
        super.updatePosition(timeDelta: timeDelta, frame: frame)
        
        elapsedTime += timeDelta
        if elapsedTime > MaxTime {
            self.removeFromParent()
            self.shouldBeRemoved = true
        }
    }
}
