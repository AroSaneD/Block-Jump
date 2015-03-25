//
//  Player.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Player : Mob{
    

    
    
    override init(parent: GameScene){
    
        super.init(parent: parent)
        
        self.color = SKColor.blueColor()
        
        position = CGPoint(x: home!.size.width * 0.1, y: size.height * 0.5)
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jump(directionVector: CGVector) {
        
        
        runAction(SKAction.sequence([
            SKAction.runBlock({
                if self.playerFooting > 0 {
                    self.physicsBody!.applyImpulse(directionVector)
                }
            }),
            SKAction.waitForDuration(0.01),
            SKAction.runBlock({
                if self.playerFooting <= 0 {
                    self.physicsBody!.applyTorque(0.001 * directionVector.dx < 0 ? 1 : -1 * (self.frame.minY / 30))
                    //self.physicsBody!.applyAngularImpulse(0.001 * directionVector.dx < 0 ? 1 : -1 * (self.frame.minY / 30))
                }
            })
            ])
        )
    }
    
}