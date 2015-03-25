//
//  Monster.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Monster: Mob {
    
    var dieAction: SKAction?
    var moveAction: SKAction?
    var cycleCount: NSInteger?
    var target: Player?
    
    override init(parent: GameScene) {
        super.init(parent: parent)
        self.color = SKColor.redColor()
        physicsBody?.categoryBitMask = PhysicsCategory.Monster
        target = parent.player!
        position = CGPoint(x: home!.size.width * 1.8, y: home!.size.height * 0.3)
        cycleCount = 300
        
        moveAction = SKAction.moveBy(CGVector(dx: home!.size.width * -0.01, dy: 0.01), duration: 0.022)
        
        
        dieAction = SKAction.sequence([
            SKAction.runBlock({ self.home!.removeMob(self) }),
            SKAction.removeFromParent()
            ])
        
        
        //monster.runAction(SKAction.sequence([moveAction, dieAction]))
        
        //monster.runAction(SKAction.repeatActionForever(SKAction.sequence([moveAction, SKAction.waitForDuration(0.005)])))
        
    }

    func beginActions(){

        self.runAction(
            SKAction.sequence([
                SKAction.repeatAction(
                    SKAction.sequence([
                        moveAction!,
                        SKAction.runBlock(self.logic)
                        ]), count: cycleCount!),
                dieAction!])
        )

    }
    
    func logic(){
        
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
