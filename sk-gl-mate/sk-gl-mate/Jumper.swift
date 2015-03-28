//
//  Jumper.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Jumper : Monster{
    
    override init(parent: GameScene) {
        super.init(parent: parent)
        color = SKColor.brownColor()
        physicsBody?.categoryBitMask = PhysicsCategory.Jumper
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func logic() {
        if (home!.player!.frame.midX + self.frame.width*4) > self.frame.midX {
            jump()
        }
    }
    
    override func jump() {
        if playerFooting > 0 && target!.frame.midX + frame.width*4 > frame.midX && target!.frame.midX < frame.midX{
            if target!.playerFooting <= 0 {
                var xVector = CGFloat((target!.frame.midX - frame.midX)/20)
                var yVector = CGFloat((target!.frame.midY - frame.midY)/4)
                if yVector > 40{
                    yVector = 40
                }
                physicsBody!.applyImpulse(CGVector(dx: xVector, dy: yVector))
            }
            
            
            
        }
        
        
        
    }
    
}
