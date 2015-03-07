//
//  CustomContactDelegate.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/7/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import UIKit
import SpriteKit



class CustomContactDelegate: NSObject, SKPhysicsContactDelegate{
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Player    : UInt32 = 0b1        // 1
        static let Monster   : UInt32 = 0b10       // 2
        static let Floor     : UInt32 = 0b100      // 4
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("ow")
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Monster {
            println("Sup m8")
        }
        else if contact.bodyB.categoryBitMask == PhysicsCategory.Player && contact.bodyA.categoryBitMask == PhysicsCategory.Monster{
            println("Sup m8")
        }
    }
    
}
