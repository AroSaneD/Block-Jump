//
//  Assassin.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Assassin : Monster{

    var followed: Bool?

    override init(parent: GameScene) {
        super.init(parent: parent)
        color = SKColor.blackColor()
        cycleCount = 250


        //colides with ground & player
        physicsBody?.categoryBitMask = PhysicsCategory.Assassin
        physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Floor
        physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Floor
        
        //starts at left part of the screen, in the air
        position = CGPoint(x: home!.size.width * -0.01, y: home!.size.height * 0.4)

        //appeared behind the screen. Didn't have chance to follow
        followed = false
        
        //follows the player, speeds up as the player goes farther away


        //TODO: implement a lazy action. When the cycles run out, just stand still and wait for the player to run away
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func beginActions(){
        self.runAction(
            SKAction.sequence([
                SKAction.repeatAction(
                    SKAction.sequence([
                        SKAction.runBlock({
                            self.runAction(SKAction.moveBy(CGVector(dx: (self.home!.player!.frame.midX - self.frame.midX) / 50, dy: 0.01), duration: 0.02))
                        }),
                        SKAction.runBlock(self.logic)
                        ]), count: cycleCount!), dieAction!])
        )

        
    }

    override func logic(){
        //if player in less than x and in air, jump up in accordance to players coordinates
        //moveAction = SKAction.moveBy(CGVector(dx: (home!.player!.frame.midX - self.frame.midX) / 10, dy: 0.01), duration: 0.02)
        
        if target!.frame.midX - self.frame.width*4 < self.frame.midX {
            if target!.frame.midY > self.frame.midY + self.frame.height {
                jump()
            } 
        }

        //if falls behind the screen, dies
        if self.frame.midX < 0 && followed! {
            //self.runAction(dieAction!)
        }

        if self.frame.minX > 0 {
            followed = true
        }

    }
    
    
    
}
