//
//  CustomContactDelegate.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/7/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit



class CustomContactDelegate: NSObject, SKPhysicsContactDelegate{
    
    var player:Player?
    
    
    
    init(PrimaryPlayer:Player){
        super.init()
        player = PrimaryPlayer
        println("Initialized")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Monster {
        }
        else if contact.bodyB.categoryBitMask == PhysicsCategory.Player && contact.bodyA.categoryBitMask == PhysicsCategory.Monster{
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player{
            player!.playerFooting++
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Floor || contact.bodyB.categoryBitMask == PhysicsCategory.Floor{
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player{
            player!.playerFooting--
        }
    }
    
}
