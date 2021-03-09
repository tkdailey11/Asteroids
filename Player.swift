//
//  Player.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import Foundation
import SpriteKit

class Player {
    
    static let instance = Player()
    
    static let MaxAcceleration: CGFloat = 10.0
    static let MaxSpeed: CGFloat = 300.0
    static let Deceleration: CGFloat = 0.995
    var acceleration = CGPoint(x: 0, y: 0)
    var velocity = CGPoint(x: 0, y: 0)
    
    var shapeNode: SKShapeNode
    var position: CGPoint {
        get {
            return shapeNode.position
        }
        set(newPos) {
            shapeNode.position = newPos
        }
    }
    
    private var points = [CGPoint(x: 0, y: 25),
                          CGPoint(x: 15, y: -25),
                          CGPoint(x: 0, y: -15),
                          CGPoint(x: -15, y: -25),
                          CGPoint(x: 0, y: 25)]

    private init() {
        shapeNode = SKShapeNode(points: &points, count: points.count)
        shapeNode.strokeColor = .white
    }
    
    func update(key: UInt16, timeDelta: CGFloat) {

        switch key {
        case Keycode.upArrow:
            accelerate()
        case Keycode.downArrow:
            stop()
        default:
            print("temp")
        }
        
        updateVelocity()
        
        updatePosition(timeDelta: timeDelta)
    }
    
    func accelerate() {
        if acceleration.length() > Player.MaxAcceleration {
            acceleration = acceleration * (Player.MaxAcceleration / acceleration.length())
        }
    }
    
    func stop() {
        acceleration = CGPoint(x: 0,y: 0)
    }
    
    func updateVelocity() {
        if acceleration.length() > 0 {
            velocity = velocity + acceleration
        } else {
            velocity = velocity * Player.Deceleration
        }
        
        if velocity.length() > Player.MaxSpeed {
            velocity = velocity * (Player.MaxSpeed / velocity.length())
        }
    }
    
    func updatePosition(timeDelta: CGFloat) {
        shapeNode.position = shapeNode.position + velocity * timeDelta
    }
    
    
}
