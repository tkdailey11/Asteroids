//
//  Participant.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/11/21.
//

import Foundation
import SpriteKit
import VectorMath

class Participant: SKShapeNode {
    
    var type: ParticipantType = .Unassigned
    
    var shouldBeRemoved: Bool = false
    
    var velocity = Vector2(0, 0)
    var acceleration = Vector2(0, 0)
    var center = Vector2(0,0)
    
    private var _radians = Scalar()
    var rotation: Scalar {
        get {
            return _radians
        }
        set {
            _radians = newValue
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate(delta: Scalar) {
        _radians += delta
    }
    
    func accelerate() {
        acceleration = acceleration + Vector2(Scalar(cos(self.zRotation + CGFloat(Double.pi / 2))), Scalar(sin(self.zRotation + CGFloat(Double.pi / 2))))
        
        if acceleration.length > Player.MaxAcceleration {
            acceleration = acceleration * (Player.MaxAcceleration / acceleration.length)
        }
    }
    
    func decelerate() {
        acceleration = Vector2(0, 0)
    }
    
    func updateVelocity() {
        if acceleration.length > 0 {
            velocity = velocity + acceleration
        } else {
            velocity = velocity * Player.Deceleration
        }
        
        if velocity.length > SPEED_LIMIT {
            velocity = velocity * (SPEED_LIMIT / velocity.length)
        }
    }
    
    func updatePosition(timeDelta: Scalar, frame: CGRect) {
        let newPosition = Vector2(self.position) + (velocity * timeDelta)
        self.position = CGPoint(newPosition)
        
        if self.position.x > frame.width {
            self.position.x = 0
        } else if self.position.x < 0 {
            self.position.x = frame.width
        }
        
        if self.position.y > frame.height {
            self.position.y = 0
        } else if self.position.y < 0 {
            self.position.y = frame.height
        }
    }
    
    private func square(_ num: Scalar) -> Scalar {
        return num * num
    }
    
    func transformPoint(_ point: Vector2) -> Vector2 {
        var transform = AffineTransform.init(translationByX: CGFloat(self.position.x), byY: CGFloat(self.position.y))
        //var transform = AffineTransform.init(scaleByX: CGFloat(self.position.x), byY: CGFloat(self.position.y))
        transform.rotate(byRadians: CGFloat(rotation))
        let res = transform.transform(NSPoint(point))
        return Vector2(Scalar(res.x), Scalar(res.y))
    }
}
