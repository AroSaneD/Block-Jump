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
    
    override init(imageName: NSString, parent: GameScene) {
        super.init(imageName: imageName, parent: parent)
        physicsBody?.categoryBitMask = PhysicsCategory.Monster
        
        position = CGPoint(x: home!.size.width * 1.8, y: home!.size.height * 0.3)
        
        let actualDuration = Global.random(min: CGFloat(2.5), max: CGFloat(3.2))
        
        //let moveAction = SKAction.moveTo(CGPoint(x: 0, y: monster.position.y), duration: NSTimeInterval(actualDuration))
        let moveAction = SKAction.moveBy(CGVector(dx: home!.size.width * -0.01, dy: 0.01), duration: 0.022)
        
        
        dieAction = SKAction.sequence([
            SKAction.runBlock({ self.home!.removeMob(self) }),
            SKAction.removeFromParent()
            ])
        
        
        //monster.runAction(SKAction.sequence([moveAction, dieAction]))
        self.runAction(
            SKAction.sequence([
                SKAction.repeatAction(
                    SKAction.sequence([
                        moveAction,
                        SKAction.runBlock(logic)
                        ]), count: 300),
                dieAction! ])
        )
        //monster.runAction(SKAction.repeatActionForever(SKAction.sequence([moveAction, SKAction.waitForDuration(0.005)])))
        
    }
    
    func logic(){
        
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
