//
//  Asteroid.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/10/21.
//

import Foundation
import SpriteKit
import VectorMath

class Asteroid: Participant {
    
    override init() {
        super.init()
    }
    
    convenience init(_ variety: Int) {
        self.init()
        var variety1 = [CGPoint(x: 0, y: -30),
                        CGPoint(x: 28, y: -15),
                        CGPoint(x: 20, y: 20),
                        CGPoint(x: 4, y: 8),
                        CGPoint(x: -1, y: 30),
                        CGPoint(x: -12, y: 15),
                        CGPoint(x: -5, y: 2),
                        CGPoint(x: -25, y: 7),
                        CGPoint(x: -10, y: -25),
                        CGPoint(x: 0, y: -30)]
        
        var variety2 = [CGPoint(x: 10, y: -28),
                        CGPoint(x: 7, y: -16),
                        CGPoint(x: 30, y: -9),
                        CGPoint(x: 30, y: 9),
                        CGPoint(x: 10, y: 13),
                        CGPoint(x: 5, y: 30),
                        CGPoint(x: -8, y: 28),
                        CGPoint(x: -6, y: 6),
                        CGPoint(x: -27, y: 12),
                        CGPoint(x: -30, y: -11),
                        CGPoint(x: -6, y: -15),
                        CGPoint(x: -6, y: -28),
                        CGPoint(x: 10, y: -28)]
        
        var variety3 = [CGPoint(x: 10, y: -30),
                        CGPoint(x: 30, y: 0),
                        CGPoint(x: 15, y: 30),
                        CGPoint(x: 0, y: 15),
                        CGPoint(x: -15, y: 30),
                        CGPoint(x: -30, y: 0),
                        CGPoint(x: -10, y: -30),
                        CGPoint(x: 10, y: -30)]
        
        var variety4 = [CGPoint(x: 30, y: -18),
                        CGPoint(x: 5, y: 5),
                        CGPoint(x: 30, y: 15),
                        CGPoint(x: 15, y: 30),
                        CGPoint(x: 0, y: 25),
                        CGPoint(x: -15, y: 30),
                        CGPoint(x: -25, y: 8),
                        CGPoint(x: -10, y: -25),
                        CGPoint(x: 0, y: -30),
                        CGPoint(x: 10, y: -30),
                        CGPoint(x: 30, y: -18)]
        
        switch variety {
        case 1:
            self.init(points: &variety1, count: variety1.count)
        case 2:
            self.init(points: &variety2, count: variety2.count)
        case 3:
            self.init(points: &variety3, count: variety3.count)
        default:
            self.init(points: &variety4, count: variety4.count)
        }
        
        setScale(CGFloat(Float.random(in: 1.0 ... 5.0)))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: max(self.frame.width / 2, self.frame.height / 2))
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
