//
//  Player.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Player : Mob{
    
    var densityMultiplier: CGFloat = 0.9

    
    
    override init(parent: GameScene){
    
        super.init(parent: parent)
        
        self.color = SKColor.blueColor()
        
        position = CGPoint(x: home!.size.width * 0.1, y: size.height * 0.5)
        physicsBody?.friction = 0
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.restitution = 0
        
        name = "player"

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jump(directionVector: CGVector) {
        
        
        runAction(SKAction.sequence([
            SKAction.runBlock({
                if self.playerFooting > 0 {
                    //self.physicsBody!.applyImpulse(directionVector)
                    self.physicsBody!.applyImpulse(CGVector(dx: directionVector.dx * self.densityMultiplier, dy: directionVector.dy * self.densityMultiplier))
                }
                else if self.isDoubleJumpAvailable {
                    self.physicsBody!.applyImpulse(CGVector(dx: directionVector.dx * self.densityMultiplier, dy: directionVector.dy * self.densityMultiplier))
                    self.isDoubleJumpAvailable = false;
                }
            })/*,
            SKAction.waitForDuration(0.01),
            SKAction.runBlock({
                if self.playerFooting <= 0 {
                    self.physicsBody!.applyTorque(0.000000001 * directionVector.dx < 0 ? 1 : -1 * (self.frame.minY / 30))
                    //self.physicsBody!.applyAngularImpulse(0.001 * directionVector.dx < 0 ? 1 : -1 * (self.frame.minY / 30))
                }
            })
            */])
        )
    }
    
    override func readyDoubleJump() {
        if home!.controller!.doubleJump {
            isDoubleJumpAvailable = true
        }
    }
    
}