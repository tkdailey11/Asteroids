//
//  Constants.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/13/21.
//

import Foundation
import VectorMath

let SPEED_LIMIT: Float = 500.0
let SHIP_ACCELERATION: Scalar = 5.0
let FRICTION: Scalar = -0.05
let BULLET_SPEED: Float = 500.0

struct ParticipantType : OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static var Unassigned   : ParticipantType { return ParticipantType(rawValue: 0) }
    static var Bullet       : ParticipantType { return ParticipantType(rawValue: 1 << 0) }
    static var Player       : ParticipantType { return ParticipantType(rawValue: 1 << 1) }
    static var Asteroid     : ParticipantType { return ParticipantType(rawValue: 1 << 2) }
}
