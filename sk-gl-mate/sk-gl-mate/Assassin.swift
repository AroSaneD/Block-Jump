//
//  Assassin.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Assassin : Mob{
    override init(imageName: NSString, parent: GameScene) {
        super.init(imageName: imageName, parent: parent)
        
        physicsBody?.categoryBitMask = PhysicsCategory.Assassin
        
        position = CGPoint(x: home!.size.width * -0.01, y: home!.size.height * 0.4)
        
        let actualDuration = Global.random(min: CGFloat(5), max: CGFloat(7.5))
        
        let moveAction = SKAction.moveBy(CGVector(dx: home!.size.width * -0.01, dy: 0.01), duration: 0.022)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hunt(){
        self.runAction(SKAction.moveBy(CGVector(dx: (home!.player!.frame.midX - self.frame.midX) / 20, dy: 0.01), duration: 0.22))
    }
    
    
    
}
