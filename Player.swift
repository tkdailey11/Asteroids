//
//  Player.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/8/21.
//

import Foundation
import SpriteKit

class Player: SKShapeNode {
    
    static let instance = Player.init(5)
    
    var shouldDecelerate: Bool = false
    
    private var _acc: CGFloat = 0
    var acceleration: CGFloat {
        get {
            return _acc
        }
        set {
            if _acc > 20 {
                _acc = 20
            }
            else if newValue < 0 {
                _acc = 0
            }
            else {
                _acc = newValue
            }
        }
    }
    
    private var _angle: CGFloat = 0
    var direction: CGFloat {
        get {
            return _angle
        }
        set {
            if newValue > 10 {
                _angle = 10
            }
            else if newValue < -10 {
                _angle = -10
            }
            else {
                _angle = newValue
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    convenience init(_ count: Int) {
        self.init()
        var points = [CGPoint(x: 0, y: 25),
                              CGPoint(x: 15, y: -25),
                              CGPoint(x: 0, y: -15),
                              CGPoint(x: -15, y: -25),
                              CGPoint(x: 0, y: 25)]
        
        self.init(points: &points, count: points.count)
        
        createPhysicsBody()
        dY = 0
    }
    
    func createPhysicsBody(){
        if let p = self.path {
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: p)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
