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
    
    override init() {
        super.init()
    }
    
    convenience init(start: Vector2, speed: Vector2, direction: Scalar) {
        self.init()
        
        var points = [CGPoint(x: 0, y: 0),
                      CGPoint(x: 0, y: 5),
                      CGPoint(x: 1, y: 5),
                      CGPoint(x: 1, y: 0),
                      CGPoint(x: 0, y: 0)]
        
        self.init(points: &points, count: points.count)
        self.position = CGPoint(x: CGFloat(start.x), y: CGFloat(start.y))
        velocity = Vector2(cos(direction + Float(Double.pi / 2)) + speed.x, sin(direction + Float(Double.pi / 2)) + speed.y) * BULLET_SPEED
        zRotation = CGFloat(direction)

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height))
        self.physicsBody?.affectedByGravity = false
        
        super.type = .Bullet
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
    
    func setVelocity(speed: Vector2, direction: Scalar){
        
    }
}
