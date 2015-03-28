//
//  CustomContactDelegate.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/7/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit



class CustomContactDelegate: NSObject, SKPhysicsContactDelegate{
    
    var home: GameScene?
    
    init(parent: GameScene){
        super.init()
        home = parent
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == PhysicsCategory.Player && bodyB.categoryBitMask == PhysicsCategory.Monster {
        }
        else if bodyB.categoryBitMask == PhysicsCategory.Player && bodyA.categoryBitMask == PhysicsCategory.Monster{
        }
        
        //What happens when the player collides
        if bodyA.categoryBitMask == PhysicsCategory.Player || bodyB.categoryBitMask == PhysicsCategory.Player{
            //get the object that just collided
            //decrease footing
            
            
            
            if bodyA.node!.name == "mob" {
                var mob = bodyA.node! as Mob
                if bodyB.node!.name != "mob" {
                    mob.playerFooting++
                }
            }
            else if bodyA.node!.name == "player" {
                var mob = bodyA.node! as Mob
                mob.playerFooting++
                mob.readyDoubleJump()
            }
            
            if bodyB.node!.name == "mob" {
                var mob = bodyB.node! as Mob
                if bodyA.node!.name != "mob" {
                    mob.playerFooting++
                }
            }
            else if bodyB.node!.name == "player" {
                var mob = bodyB.node! as Mob
                mob.playerFooting++
                mob.readyDoubleJump()
            }
            
        }
        
        //What happens when a monster collides
        if bodyA.categoryBitMask == PhysicsCategory.Monster || bodyB.categoryBitMask == PhysicsCategory.Monster || bodyA.categoryBitMask == PhysicsCategory.Jumper || bodyB.categoryBitMask == PhysicsCategory.Jumper{
            //get the object that just collided
            //decrease footing
            
            if bodyA.node!.name == "mob" {
                var mob = bodyA.node! as Mob
                if bodyB.node!.name != "mob" {
                    mob.playerFooting++
                }
            }
            else if bodyA.node!.name == "player" {
                var mob = bodyA.node! as Mob
                mob.playerFooting++
                mob.readyDoubleJump()
            }
            if bodyB.node!.name == "mob" {
                var mob = bodyB.node! as Mob
                if bodyA.node!.name != "mob" {
                    mob.playerFooting++
                }
            }
            else if bodyB.node!.name == "player" {
                var mob = bodyB.node! as Mob
                mob.playerFooting++
                mob.readyDoubleJump()
            }
            
        }
        
        //What happens when the floor collides
        if bodyA.categoryBitMask == PhysicsCategory.Floor || bodyB.categoryBitMask == PhysicsCategory.Floor{
        
        }
        
        //If assassin touches player, game over
        if (bodyA.categoryBitMask == PhysicsCategory.Assassin && bodyB.categoryBitMask == PhysicsCategory.Player) || (bodyB.categoryBitMask == PhysicsCategory.Assassin && bodyA.categoryBitMask == PhysicsCategory.Player){
            //game over
            home!.gameOver()
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        //What happens when the player collides
        if bodyA.categoryBitMask == PhysicsCategory.Player || bodyB.categoryBitMask == PhysicsCategory.Player{
            //player!.playerFooting--
            if bodyA.node!.name == "mob" {
                var mob = bodyA.node! as Mob
                if bodyB.node!.name != "mob" {
                    mob.playerFooting--
                }
            }
            else if bodyA.node!.name == "player" {
                var mob = bodyA.node! as Mob
                mob.playerFooting--
            }
            if bodyB.node!.name == "mob" {
                var mob = bodyB.node! as Mob
                if bodyA.node!.name != "mob" {
                    mob.playerFooting--
                }
            }
            else if bodyB.node!.name == "player" {
                var mob = bodyB.node! as Mob
                mob.playerFooting--
            }
        }
        
        //What happens when a monster collides
        if bodyA.categoryBitMask == PhysicsCategory.Monster || bodyB.categoryBitMask == PhysicsCategory.Monster || bodyA.categoryBitMask == PhysicsCategory.Jumper || bodyB.categoryBitMask == PhysicsCategory.Jumper{
            //player!.playerFooting--
            if bodyA.node!.name == "mob" {
                var mob = bodyA.node! as Mob
                if bodyB.node!.name != "mob" {
                    mob.playerFooting--
                }
            }
            else if bodyA.node!.name == "player" {
                var mob = bodyA.node! as Mob
                mob.playerFooting--
            }
            if bodyB.node!.name == "mob" {
                var mob = bodyB.node! as Mob
                if bodyA.node!.name != "mob" {
                    mob.playerFooting--
                }
            }
            else if bodyB.node!.name == "player" {
                var mob = bodyB.node! as Mob
                mob.playerFooting--
            }
        }
        
        
    }
    
    func isPlayer(bodyA: SKPhysicsBody, bodyB: SKPhysicsBody) -> Bool{
        
        return false
    }
    
}
