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
    
    convenience init(startX: Scalar, startY: Scalar) {
        self.init()
        
        var points = [CGPoint(x: 0, y: 0),
                      CGPoint(x: 0, y: 25),
                      CGPoint(x: 5, y: 25),
                      CGPoint(x: 5, y: 0),
                      CGPoint(x: 0, y: 0)]
        
        self.init(points: &points, count: points.count)
        self.position = CGPoint(x: CGFloat(startX), y: CGFloat(startY))

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: self.frame.height))
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updatePosition(timeDelta: Scalar, frame: CGRect) {
        super.updatePosition(timeDelta: timeDelta, frame: frame)
        
        elapsedTime += timeDelta
        if elapsedTime > MaxTime {
            self.removeFromParent()
        }
    }
}
