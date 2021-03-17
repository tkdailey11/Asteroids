//
//  Structs.swift
//  Asteroids
//
//  Created by Tyler Dailey on 3/17/21.
//

import Foundation

struct ArrowKeys : OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static var None : ArrowKeys { return ArrowKeys(rawValue: 0) }
    static var Up   : ArrowKeys { return ArrowKeys(rawValue: 1 << 0) }
    static var Down : ArrowKeys { return ArrowKeys(rawValue: 1 << 1) }
    static var Left : ArrowKeys { return ArrowKeys(rawValue: 1 << 2) }
    static var Right: ArrowKeys { return ArrowKeys(rawValue: 1 << 3) }
    static var Space: ArrowKeys { return ArrowKeys(rawValue: 1 << 4) }
}

struct ParticipantType : OptionSet {
    let rawValue: Int
    init(rawValue: Int) { self.rawValue = rawValue }
    
    static var Unassigned   : ParticipantType { return ParticipantType(rawValue: 0) }
    static var Bullet       : ParticipantType { return ParticipantType(rawValue: 1 << 0) }
    static var Player       : ParticipantType { return ParticipantType(rawValue: 1 << 1) }
    static var Asteroid     : ParticipantType { return ParticipantType(rawValue: 1 << 2) }
}

struct PhysicsCategory {
    static let none         : UInt32 = 0
    static let all          : UInt32 = UInt32.max
    static let asteroid     : UInt32 = 0b1       // 1
    static let projectile   : UInt32 = 0b10      // 2
}
